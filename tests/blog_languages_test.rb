# Run with: ruby tests/blog_languages_test.rb
# These lightweight Jekyll doubles test routing and filtering without site dependencies.
require 'minitest/autorun'
require 'ostruct'
require 'date'
require 'yaml'

module Jekyll
  module Errors
    class FatalException < StandardError; end
  end
  class Generator
    def self.safe(*); end
    def self.priority(*); end
  end
  class PageWithoutAFile
    attr_accessor :data, :content
    def initialize(*); @data = {}; end
  end
end
require_relative '../_plugins/blog-languages'

class BlogLanguagesTest < Minitest::Test
  def post(lang, n, featured = false)
    OpenStruct.new(data: { 'content_lang' => lang, 'featured' => featured },
                   date: Time.at(n), relative_path: "post-#{n}.md")
  end

  def site(posts)
    entries = %w[en ru].map do |lang|
      OpenStruct.new(data: { 'lang' => lang, 'permalink' => lang == 'ru' ? '/ru/blog/' : '/blog/',
                             'title' => 'blog', 'blog_language_entry' => true })
    end
    OpenStruct.new(posts: OpenStruct.new(docs: posts), pages: entries, source: Dir.pwd)
  end

  def generate(posts)
    result = site(posts)
    BlogLanguages::Generator.new.generate(result)
    result
  end

  def page(site, path)
    site.pages.find { |p| p.data['permalink'] == path }.data
  end

  def test_real_article_inventory
    posts = Dir[File.expand_path('../_posts/*.md', __dir__)].map do |file|
      meta = YAML.safe_load(File.read(file).split(/^---\s*$/, 3)[1], permitted_classes: [Date, Time])
      post(meta['content_lang'], File.basename(file)[0, 10].delete('-').to_i, meta['featured'])
    end
    result = generate(posts)
    assert_equal({ 'en' => 4, 'ru' => 2, 'zh' => 1 }, page(result, '/blog/en/')['blog_language_counts'])
    refute File.exist?(File.expand_path('../_posts/2025-10-14-CLIP_CN.md', __dir__))
  end

  def test_filters_before_pagination_and_retains_only_matching_featured_posts
    posts = (1..11).map { |n| post('en', n, n == 1) } + (12..18).map { |n| post('ru', n, true) }
    result = generate(posts)
    assert_equal [5, 5, 1], ['/blog/en/', '/blog/en/page/2/', '/blog/en/page/3/'].map { |url| page(result, url)['language_posts'].size }
    result.pages.each do |p|
      %w[language_posts language_featured_posts].each do |key|
        assert p.data[key].all? { |item| item.data['content_lang'] == p.data['content_lang'] }
      end
    end
    assert_equal 1, page(result, '/blog/en/')['language_featured_posts'].size
    assert_equal [11, 10, 9, 8, 7], page(result, '/blog/en/')['language_posts'].map { |p| p.date.to_i }
  end

  def test_pagination_and_interface_counterparts_have_valid_routes
    result = generate((1..11).map { |n| post('en', n) })
    urls = result.pages.map { |p| p.data['permalink'] }
    result.pages.each do |p|
      data = p.data
      assert_includes urls, data['translation_url']
      links = data['blog_pagination']['pages'].map { |item| item['url'] }
      links += [data['blog_pagination']['previous'], data['blog_pagination']['next']].compact
      links.each { |url| assert_includes urls, url }
    end
    assert_nil page(result, '/blog/en/')['blog_pagination']['previous']
    assert_equal '/blog/en/', page(result, '/blog/en/page/2/')['blog_pagination']['previous']
    assert_nil page(result, '/blog/en/page/3/')['blog_pagination']['next']
    assert_equal '/ru/blog/en/page/2/', page(result, '/blog/en/page/2/')['translation_url']
  end

  def test_empty_languages_and_no_posts_still_produce_working_pages
    result = generate([])
    assert_equal 8, result.pages.size
    assert_empty page(result, '/blog/zh/')['language_posts']
    assert_equal 1, page(result, '/blog/zh/')['blog_pagination']['total_pages']
  end

  def test_default_language_depends_on_interface
    result = generate([post('en', 1), post('ru', 2)])
    assert_equal 'en', page(result, '/blog/')['content_lang']
    assert_equal 'ru', page(result, '/ru/blog/')['content_lang']
  end

  def test_missing_or_invalid_language_fails_instead_of_silently_hiding_an_article
    [nil, 'ch', 'de'].each do |lang|
      assert_raises(Jekyll::Errors::FatalException) { generate([post(lang, 1)]) }
    end
  end
end

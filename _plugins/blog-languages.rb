# Filter before paginating: every page and featured card has one article language.
module BlogLanguages
  LANGUAGES = %w[en ru zh].freeze
  PER_PAGE = 5

  class Generator < Jekyll::Generator
    safe true
    priority :normal # ExternalPosts runs at :high, before this generator.

    def generate(site)
      posts = site.posts.docs.sort_by(&:date).reverse
      posts.each do |post|
        next if LANGUAGES.include?(post.data['content_lang'])

        raise Jekyll::Errors::FatalException,
              "Set content_lang to en, ru or zh for #{post.relative_path}"
      end
      grouped = LANGUAGES.map { |lang| [lang, posts.select { |p| p.data['content_lang'] == lang }] }.to_h
      counts = grouped.transform_values(&:size)

      %w[en ru].each do |interface|
        entry_url = interface == 'ru' ? '/ru/blog/' : '/blog/'
        entry = site.pages.find { |p| p.data['permalink'] == entry_url }
        next unless entry

        entry.data.merge!(page_data(interface, interface, grouped, counts, 1))
        entry.data['translation_url'] = interface == 'ru' ? '/blog/' : '/ru/blog/'
        LANGUAGES.each do |lang|
          total = [(grouped[lang].size.to_f / PER_PAGE).ceil, 1].max
          (1..total).each do |number|
            url = path(interface, lang, number)
            page = Jekyll::PageWithoutAFile.new(site, site.source, url.sub(%r{^/}, ''), 'index.html')
            page.content = ''
            page.data = page_data(interface, lang, grouped, counts, number).merge(
              'layout' => 'blog-languages', 'title' => entry.data['title'],
              'lang' => interface, 'nav' => false, 'permalink' => url,
              'pagination' => { 'enabled' => false },
              'translation_url' => path(interface == 'ru' ? 'en' : 'ru', lang, number)
            )
            site.pages << page
          end
        end
      end
    end

    def path(interface, lang, number = 1)
      base = "#{interface == 'ru' ? '/ru' : ''}/blog/#{lang}/"
      number == 1 ? base : "#{base}page/#{number}/"
    end

    def page_data(interface, lang, grouped, counts, number)
      posts = grouped.fetch(lang)
      total = [(posts.size.to_f / PER_PAGE).ceil, 1].max
      {
        'content_lang' => lang, 'blog_language_counts' => counts,
        'blog_language_base' => interface == 'ru' ? '/ru/blog/' : '/blog/',
        'language_posts' => posts.slice((number - 1) * PER_PAGE, PER_PAGE) || [],
        'language_featured_posts' => posts.select { |p| p.data['featured'] == true },
        'blog_pagination' => {
          'page' => number, 'total_pages' => total,
          'previous' => number > 1 ? path(interface, lang, number - 1) : nil,
          'next' => number < total ? path(interface, lang, number + 1) : nil,
          'pages' => (1..total).map { |n| { 'number' => n, 'url' => path(interface, lang, n) } }
        }
      }
    end
  end
end

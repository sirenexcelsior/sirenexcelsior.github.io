// Run with: node --test tests/blog-languages.test.js
const { test } = require('node:test');
const assert = require('node:assert/strict');
const vm = require('node:vm');
const fs = require('node:fs');
const source = fs.readFileSync('assets/js/blog-languages.js', 'utf8');

function run({ listing, stored = {}, blocked = false, back = null } = {}) {
  const storage = new Map(Object.entries(stored));
  let redirected;
  const events = {};
  const context = {
    localStorage: {
      getItem: (key) => { if (blocked) throw Error('blocked'); return storage.get(key) || null; },
      setItem: (key, value) => { if (blocked) throw Error('blocked'); storage.set(key, value); },
    },
    document: { querySelector: (selector) => selector === '[data-blog-languages]' ? listing : back },
    window: { location: { replace: (url) => { redirected = url; } }, addEventListener: (event, fn) => { events[event] = fn; } },
  };
  vm.runInNewContext(source, context);
  return { storage, redirected, events, back };
}
const list = (language = 'en', ui = 'en', entry = false) => ({
  dataset: { selectedLanguage: language, interfaceLanguage: ui, languageBase: `${ui === 'ru' ? '/ru' : ''}/blog/` },
  hasAttribute: () => entry,
});
test('entry defaults and saved preference', () => {
  assert.equal(run({ listing: list('en', 'en', true) }).redirected, '/blog/en/');
  assert.equal(run({ listing: list('ru', 'ru', true) }).redirected, '/ru/blog/ru/');
  assert.equal(run({ listing: list('en', 'en', true), stored: { 'blog-content-language': 'zh' } }).redirected, '/blog/zh/');
});
test('explicit shared URL wins over stored preference; BFCache restores that selection', () => {
  const result = run({ listing: list('ru'), stored: { 'blog-content-language': 'en' } });
  assert.equal(result.redirected, undefined);
  assert.equal(result.storage.get('blog-content-language'), 'ru');
  result.storage.set('blog-content-language', 'zh');
  result.events.pageshow();
  assert.equal(result.storage.get('blog-content-language'), 'ru');
});
test('storage unavailable or invalid has a safe default', () => {
  assert.equal(run({ listing: list('ru', 'ru', true), blocked: true }).redirected, '/ru/blog/ru/');
  assert.equal(run({ listing: list('en', 'en', true), stored: { 'blog-content-language': 'bad' } }).redirected, '/blog/en/');
});
test('article return link preserves article selection and interface language', () => {
  const back = { dataset: { contentLanguage: 'en', baseurl: '/test' } };
  run({ back, stored: { 'blog-content-language': 'zh', 'blog-interface-language': 'ru' } });
  assert.equal(back.href, '/test/ru/blog/zh/');
  run({ back, blocked: true });
  assert.equal(back.href, '/test/blog/en/');
});

// Site interface language and article language are separate preferences.
(() => {
  const supported = ['en', 'ru', 'zh'];
  const key = 'blog-content-language';
  const uiKey = 'blog-interface-language';
  const read = (name) => {
    try { return localStorage.getItem(name); } catch (_) { return null; }
  };
  const save = (name, value) => {
    try { localStorage.setItem(name, value); } catch (_) { /* Storage is optional. */ }
  };
  const listing = document.querySelector('[data-blog-languages]');
  if (listing) {
    const { selectedLanguage, interfaceLanguage, languageBase } = listing.dataset;
    const saved = read(key);
    if (listing.hasAttribute('data-language-entry')) {
      const language = supported.includes(saved) ? saved : selectedLanguage;
      window.location.replace(`${languageBase}${language}/`);
      return;
    }
    save(key, selectedLanguage);
    save(uiKey, interfaceLanguage);
    // A BFCache restore must also restore the selection of the visible list.
    window.addEventListener('pageshow', () => {
      save(key, selectedLanguage);
      save(uiKey, interfaceLanguage);
    });
  }

  const back = document.querySelector('[data-blog-return]');
  if (back) {
    const saved = read(key);
    const language = supported.includes(saved) ? saved : back.dataset.contentLanguage;
    const prefix = read(uiKey) === 'ru' ? '/ru' : '';
    back.href = `${back.dataset.baseurl}${prefix}/blog/${language}/`;
  }
})();

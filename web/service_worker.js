self.addEventListener('install', function(event) {
    event.waitUntil(
      caches.open('flutter-app-cache').then(function(cache) {
        return cache.addAll([
          '/',
          '/index.html',
          '/main.dart.js',
          '/icons/192x192.png',
          '/icons/512x512.png',
          '/styles.css',
        ]);
      })
    );
  });
  
  self.addEventListener('fetch', function(event) {
    event.respondWith(
      caches.match(event.request).then(function(cachedResponse) {
        return cachedResponse || fetch(event.request);
      })
    );
  });
  
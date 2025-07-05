'use strict';
const MANIFEST = 'flutter-app-manifest';
const TEMP = 'flutter-temp-cache';
const CACHE_NAME = 'flutter-app-cache';

const RESOURCES = {"assets/AssetManifest.bin": "c1ec4f95b3cb543c4a89cc3f457a9535",
"assets/AssetManifest.bin.json": "d7d3173c49f6a88876f90db31352d8d3",
"assets/AssetManifest.json": "f7934b24b6fab2000f81ee3fc801df0b",
"assets/assets/123.json": "26fefed6c52c8e1f9c48ca8545174265",
"assets/assets/authorization_1.png": "5b9ba64b1f0a3398c480840ad2488bde",
"assets/assets/authorization_2.png": "74498c98549ced05974896e7315e408b",
"assets/assets/authorization_3.png": "b2a3c4288bc30feefe6da15a0297419b",
"assets/assets/authorization_4.png": "9f6b8400c2c27908aaaf63f2297355f8",
"assets/assets/authorization_5.png": "2eb3099f56ffddef40fc16e27b597cd4",
"assets/assets/back_lottie.json": "af440d1af5bcf9454cd9c17f08437caf",
"assets/assets/bubble_sort_1.png": "d769615e5d035660cf2f88dbd59dd0a2",
"assets/assets/bubble_sort_2.png": "c396c60cd9f2427cbdff9cd671b73cd2",
"assets/assets/bubble_sort_3.png": "af55d0194d5e178e318d0bab84dc46e7",
"assets/assets/bubble_sort_4.png": "ff36dccf6385359662a98bdcf409657c",
"assets/assets/cinemafilter_1.png": "07988913e3a33dc724253fd7eb3c2562",
"assets/assets/cinemafilter_10.png": "0ddf42b5910b4cda0255c3359080fe20",
"assets/assets/cinemafilter_2.png": "e9284c4c99d944a1c14a2720fb4fb04a",
"assets/assets/cinemafilter_3.png": "e3c3c416acd58461d053331cc4b7e876",
"assets/assets/cinemafilter_4.png": "53ffc6b33956f672e6624efb33e232fb",
"assets/assets/cinemafilter_5.png": "0cbb4c93b9e0cbd411aba82dc02cd1fb",
"assets/assets/cinemafilter_6.png": "c594028df00a9af36b73f3c7f54277e2",
"assets/assets/cinemafilter_7.png": "aec04c117078edb381daf7c9a9ec6cdd",
"assets/assets/cinemafilter_8.png": "3f985e1fdabd13e29158313af7fe79cc",
"assets/assets/cinemafilter_9.png": "4b9895c7839e0023b3393cfe0a973ef6",
"assets/assets/dark-light.json": "19b7c0113070e0ee1caa67b421b98f61",
"assets/assets/design.png": "a59d0ce601d1ef6885b1eebcf8b7403a",
"assets/assets/develop.png": "f0cdce9ad5c457a7e9ee660dee2e5cdc",
"assets/assets/email.png": "5eb3c4b86aafbee72b8c471b29413a50",
"assets/assets/magic_lama_1.png": "4d3a2e0e9d77633900cc92c42f7cc1e3",
"assets/assets/magic_lama_2.png": "302bc89b82b499673875d9f711189ea5",
"assets/assets/magic_lama_3.png": "8ab1447863c6434a4ca59fa1b6f408d1",
"assets/assets/mappin.png": "9cc090022ae31337336d2024160714b8",
"assets/assets/phone.png": "45903a1ffa9ede882171aca9f71c4c29",
"assets/assets/promote.png": "d05a3c494c551a130b5c4fd8b3708d73",
"assets/assets/quote.png": "1a0aa9a06293ac5689bc32012e0e13e6",
"assets/assets/shresh1_dark.png": "0a1057edab31023df01f2137daa02000",
"assets/assets/shresh1_light.png": "50d507697b11b50ec2d0100a9ecc5f38",
"assets/assets/shresh_project_dark.png": "bb131427b941d1a2987840af782bb9c6",
"assets/assets/shresh_project_light.png": "33d4b701052301d24453ead2583659a7",
"assets/assets/whatsapp.png": "426617ad28567da23a2346566d84b5a6",
"assets/assets/write.png": "b54f6819aef8a60464998c635422ef4d",
"assets/FontManifest.json": "5a32d4310a6f5d9a6b651e75ba0d7372",
"assets/fonts/MaterialIcons-Regular.otf": "068bfacbab0ed0db97e5b553ec6dbb3e",
"assets/NOTICES": "0bc08da77d88f6f161be50a687a1feab",
"assets/packages/cupertino_icons/assets/CupertinoIcons.ttf": "33b7d9392238c04c131b6ce224e13711",
"assets/packages/font_awesome_flutter/lib/fonts/fa-brands-400.ttf": "ea2b9e19cdd9305c441cf3a7a5f02f8a",
"assets/packages/font_awesome_flutter/lib/fonts/fa-regular-400.ttf": "3ca5dc7621921b901d513cc1ce23788c",
"assets/packages/font_awesome_flutter/lib/fonts/fa-solid-900.ttf": "a2eb084b706ab40c90610942d98886ec",
"assets/shaders/ink_sparkle.frag": "ecc85a2e95f5e9f53123dcaf8cb9b6ce",
"canvaskit/canvaskit.js": "728b2d477d9b8c14593d4f9b82b484f3",
"canvaskit/canvaskit.js.symbols": "bdcd3835edf8586b6d6edfce8749fb77",
"canvaskit/canvaskit.wasm": "7a3f4ae7d65fc1de6a6e7ddd3224bc93",
"canvaskit/chromium/canvaskit.js": "8191e843020c832c9cf8852a4b909d4c",
"canvaskit/chromium/canvaskit.js.symbols": "b61b5f4673c9698029fa0a746a9ad581",
"canvaskit/chromium/canvaskit.wasm": "f504de372e31c8031018a9ec0a9ef5f0",
"canvaskit/skwasm.js": "ea559890a088fe28b4ddf70e17e60052",
"canvaskit/skwasm.js.symbols": "e72c79950c8a8483d826a7f0560573a1",
"canvaskit/skwasm.wasm": "39dd80367a4e71582d234948adc521c0",
"favicon.png": "5dcef449791fa27946b3d35ad8803796",
"flutter.js": "83d881c1dbb6d6bcd6b42e274605b69c",
"flutter_bootstrap.js": "476458faf77d2fe4fa7c7e67eeb4f627",
"icons/Icon-192.png": "ac9a721a12bbc803b44f645561ecb1e1",
"icons/Icon-512.png": "96e752610906ba2a93c65f8abe1645f1",
"icons/Icon-maskable-192.png": "c457ef57daa1d16f64b27b786ec2ea3c",
"icons/Icon-maskable-512.png": "301a7604d45b3e739efc881eb04896ea",
"index.html": "b3a089ab9fe29e08ea852386308c661d",
"/": "b3a089ab9fe29e08ea852386308c661d",
"main.dart.js": "03aef75307642985508dbc2d8694784d",
"manifest.json": "e74af8957b5899dc6da961caee768ec9",
"version.json": "009c9e65172e010890f7f65fde438006"};
// The application shell files that are downloaded before a service worker can
// start.
const CORE = ["main.dart.js",
"index.html",
"flutter_bootstrap.js",
"assets/AssetManifest.bin.json",
"assets/FontManifest.json"];

// During install, the TEMP cache is populated with the application shell files.
self.addEventListener("install", (event) => {
  self.skipWaiting();
  return event.waitUntil(
    caches.open(TEMP).then((cache) => {
      return cache.addAll(
        CORE.map((value) => new Request(value, {'cache': 'reload'})));
    })
  );
});
// During activate, the cache is populated with the temp files downloaded in
// install. If this service worker is upgrading from one with a saved
// MANIFEST, then use this to retain unchanged resource files.
self.addEventListener("activate", function(event) {
  return event.waitUntil(async function() {
    try {
      var contentCache = await caches.open(CACHE_NAME);
      var tempCache = await caches.open(TEMP);
      var manifestCache = await caches.open(MANIFEST);
      var manifest = await manifestCache.match('manifest');
      // When there is no prior manifest, clear the entire cache.
      if (!manifest) {
        await caches.delete(CACHE_NAME);
        contentCache = await caches.open(CACHE_NAME);
        for (var request of await tempCache.keys()) {
          var response = await tempCache.match(request);
          await contentCache.put(request, response);
        }
        await caches.delete(TEMP);
        // Save the manifest to make future upgrades efficient.
        await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
        // Claim client to enable caching on first launch
        self.clients.claim();
        return;
      }
      var oldManifest = await manifest.json();
      var origin = self.location.origin;
      for (var request of await contentCache.keys()) {
        var key = request.url.substring(origin.length + 1);
        if (key == "") {
          key = "/";
        }
        // If a resource from the old manifest is not in the new cache, or if
        // the MD5 sum has changed, delete it. Otherwise the resource is left
        // in the cache and can be reused by the new service worker.
        if (!RESOURCES[key] || RESOURCES[key] != oldManifest[key]) {
          await contentCache.delete(request);
        }
      }
      // Populate the cache with the app shell TEMP files, potentially overwriting
      // cache files preserved above.
      for (var request of await tempCache.keys()) {
        var response = await tempCache.match(request);
        await contentCache.put(request, response);
      }
      await caches.delete(TEMP);
      // Save the manifest to make future upgrades efficient.
      await manifestCache.put('manifest', new Response(JSON.stringify(RESOURCES)));
      // Claim client to enable caching on first launch
      self.clients.claim();
      return;
    } catch (err) {
      // On an unhandled exception the state of the cache cannot be guaranteed.
      console.error('Failed to upgrade service worker: ' + err);
      await caches.delete(CACHE_NAME);
      await caches.delete(TEMP);
      await caches.delete(MANIFEST);
    }
  }());
});
// The fetch handler redirects requests for RESOURCE files to the service
// worker cache.
self.addEventListener("fetch", (event) => {
  if (event.request.method !== 'GET') {
    return;
  }
  var origin = self.location.origin;
  var key = event.request.url.substring(origin.length + 1);
  // Redirect URLs to the index.html
  if (key.indexOf('?v=') != -1) {
    key = key.split('?v=')[0];
  }
  if (event.request.url == origin || event.request.url.startsWith(origin + '/#') || key == '') {
    key = '/';
  }
  // If the URL is not the RESOURCE list then return to signal that the
  // browser should take over.
  if (!RESOURCES[key]) {
    return;
  }
  // If the URL is the index.html, perform an online-first request.
  if (key == '/') {
    return onlineFirst(event);
  }
  event.respondWith(caches.open(CACHE_NAME)
    .then((cache) =>  {
      return cache.match(event.request).then((response) => {
        // Either respond with the cached resource, or perform a fetch and
        // lazily populate the cache only if the resource was successfully fetched.
        return response || fetch(event.request).then((response) => {
          if (response && Boolean(response.ok)) {
            cache.put(event.request, response.clone());
          }
          return response;
        });
      })
    })
  );
});
self.addEventListener('message', (event) => {
  // SkipWaiting can be used to immediately activate a waiting service worker.
  // This will also require a page refresh triggered by the main worker.
  if (event.data === 'skipWaiting') {
    self.skipWaiting();
    return;
  }
  if (event.data === 'downloadOffline') {
    downloadOffline();
    return;
  }
});
// Download offline will check the RESOURCES for all files not in the cache
// and populate them.
async function downloadOffline() {
  var resources = [];
  var contentCache = await caches.open(CACHE_NAME);
  var currentContent = {};
  for (var request of await contentCache.keys()) {
    var key = request.url.substring(origin.length + 1);
    if (key == "") {
      key = "/";
    }
    currentContent[key] = true;
  }
  for (var resourceKey of Object.keys(RESOURCES)) {
    if (!currentContent[resourceKey]) {
      resources.push(resourceKey);
    }
  }
  return contentCache.addAll(resources);
}
// Attempt to download the resource online before falling back to
// the offline cache.
function onlineFirst(event) {
  return event.respondWith(
    fetch(event.request).then((response) => {
      return caches.open(CACHE_NAME).then((cache) => {
        cache.put(event.request, response.clone());
        return response;
      });
    }).catch((error) => {
      return caches.open(CACHE_NAME).then((cache) => {
        return cache.match(event.request).then((response) => {
          if (response != null) {
            return response;
          }
          throw error;
        });
      });
    })
  );
}

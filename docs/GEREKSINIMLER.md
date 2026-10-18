# Yönerge karşılıkları

| Gereksinim | Uygulama karşılığı |
| --- | --- |
| Flutter / Dart / Material | `pubspec.yaml`, `lib/main.dart` |
| Ek paket kullanılmaması | Yalnızca SDK bağımlılıkları |
| Stateless ve Stateful widget | Ekranlar, CatalogApp ve CatalogScreen |
| Ana sayfa / liste / detay | HomeScreen / CatalogScreen / DetailScreen |
| push / pop / MaterialPageRoute | Ana sayfa CTA, rotalar ve geri düğmesi |
| Route Arguments | `/product`, Product nesnesi, RouteSettings |
| JSON simülasyonu | assets/data/products.json, CatalogRepository |
| Model, fromJson / toJson | lib/models/product.dart |
| GridView ile ürün kartları | GridView.builder ve genişliğe uyumlu kolon sayısı |
| ListView.builder | CartScreen |
| Arama / filtreleme | CatalogScreen, kategori + metin |
| Asset ve Image.asset | 8 yerel PNG ürün görseli |
| Sepet state simülasyonu | Cart, rozet, adet, toplam, boş durum |
| Tema ve klasör düzeni | Material 3 tema, models/data/state/screens/widgets |
| Flutter sürümü ve çalıştırma adımları | README.md |
| Ekran görüntüleri | screenshots/android/: Android 15 emülatöründen 5 ekran |
| Android cihaz doğrulaması | docs/ANDROID_DOGRULAMA.md, integration_test/ |
| Public GitHub URL | https://github.com/sevvalkasan/mini-katalog |

PDF'deki ders anlatımı ve kurulum önerileri, uygulama içi özelliklerden ayrılmıştır. API adresleri eğitim kaynağı olarak verilmiştir; yönergedeki JSON simülasyonu için çevrimdışı veri tercih edilmiştir. Gerçek ödeme veya kimlik doğrulama eklenmemiştir.

# Android doğrulama raporu

Tarih: **18 Ekim 2026**

Uygulama Android emülatörüne APK olarak kurulmuş ve cihaz üzerinde çalıştırılmıştır. Bu doğrulama tarayıcıda mobil görünüm testi değildir. Fiziksel Android telefon ve iOS cihaz testleri bu raporun kapsamında değildir.

## Ortam

| Bileşen | Değer |
| --- | --- |
| Flutter / Dart | 3.47.4 stable / 3.13.3 |
| Android | Android 15, API 35 |
| Sistem imajı | AOSP ARM64 (`arm64-v8a`) |
| Sanal cihaz | `MiniKatalog_API35`, Pixel 7 donanım profili |
| Ekran | 1080 × 2400 piksel |
| Android Emulator | 37.2.12 |
| Derleme SDK / Build Tools | API 36 / 36.0.0 |
| Java | OpenJDK 21 |
| Uygulama paketi | `com.example.mini_katalog` |
| Uygulama sürümü | 1.0.0+1 |

## Cihaz üzerinde sınanan akış

| Kontrol | Beklenen sonuç | Sonuç |
| --- | --- | --- |
| Ana sayfa | Uygulama açılır, katalog düğmesi görünür | Geçti |
| Listeye geçiş | 8 ürün görünür | Geçti |
| Kategori filtresi | Yaşam kategorisi 2 ürün gösterir | Geçti |
| Arama | `KUPA` araması 1 ürün gösterir | Geçti |
| Boş arama sonucu | Eşleşmeyen arama için açıklama görünür | Geçti |
| Filtreleri temizleme | 8 ürün geri gelir | Geçti |
| Ürün detayı | Seçilen ürünün detayı açılır | Geçti |
| Sepete ekleme | Sepette 1 ürün görünür | Geçti |
| Adet artırma / toplam | 2 kupa için toplam 498,00 TL olur | Geçti |
| Adet azaltma | Adet 1'e düşer | Geçti |
| Son ürünü kaldırma | Boş sepet görünür | Geçti |
| Geri dönüş | Ürün detayına geri dönülür | Geçti |

Test kaynağı: [catalog_flow_test.dart](../integration_test/catalog_flow_test.dart).

## Test sonucu

Son Android çalıştırması başarıyla tamamlandı (çıkış kodu 0):

```text
00:28 +1: (tearDownAll)
00:28 +2: All tests passed!
All tests passed.
```

Bu çıktı bir uçtan uca senaryo ve test kapanış adımını kapsar. Ayrı birim/widget test paketindeki 4 test de geçti; `flutter analyze` sorun bildirmedi.

## Tekrar çalıştırma

Android SDK ve Java kurulduktan sonra bir Android emülatörü başlatın; `flutter devices` çıktısındaki cihaz kimliğini kullanın:

```bash
flutter pub get
flutter analyze
flutter test
flutter drive --no-dds \
  --driver=test_driver/integration_test.dart \
  --target=integration_test/catalog_flow_test.dart \
  -d emulator-5554
```

Test görüntüleri `screenshots/android/` klasörüne kaydedilir. `--no-dds`, kullanılan Flutter SDK kurulumundaki DDS snapshot hatasını aşar. Test, Flutter SDK'nın `integration_test` paketini kullanır; uygulamaya harici çalışma zamanı bağımlılığı eklenmez.

Normal uygulama APK'sını oluşturmak için:

```bash
flutter build apk --debug --target lib/main.dart
```

## Normal APK kontrolü

Test APK'sından ayrı olan normal uygulama APK'sı da emülatöre kurulmuş ve `MainActivity` başarıyla açılmıştır (`Status: ok`). Android imza kontrolü `apksigner verify` ile geçmiştir. APK, uygulamanın normal `main.dart` giriş noktasını içerir; test senaryosunun Dart giriş noktasını içermez.

Yerel teslim dosyası: `output/mini-katalog-android-debug.apk` (debug imzalı geliştirme sürümü; repository'ye büyük ikili dosya olarak eklenmez).

SHA-256:

```text
bd3160fbd53c57decfb1887e6df716be85f0c7428c144c6303a51ea1d31667ef
```

## Android ekran görüntüleri

- [Normal APK, Android sistem çubuklarıyla](../screenshots/android/android-00-cihaz.png)
- [Ana sayfa](../screenshots/android/android-01-ana-sayfa.png)
- [Ürün kataloğu](../screenshots/android/android-02-katalog.png)
- [Ürün detayı](../screenshots/android/android-03-urun-detayi.png)
- [Sepet ve toplam tutar](../screenshots/android/android-04-sepet.png)
- [Boş sepet](../screenshots/android/android-05-bos-sepet.png)

`android-00-cihaz.png` normal APK'nın Android ekran yakalamasıdır. Diğer beş görüntü, cihazda çalışan Flutter entegrasyon testinden alınır. Önceki web önizleme görüntüleri üst `screenshots/` klasöründe ayrıca korunur.

import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:integration_test/integration_test.dart';
import 'package:mini_katalog/main.dart' as app;

void main() {
  final binding = IntegrationTestWidgetsFlutterBinding.ensureInitialized();
  binding.framePolicy = LiveTestWidgetsFlutterBindingFramePolicy.fullyLive;
  testWidgets('Android: ana sayfa, arama, filtre, detay ve sepet', (
    tester,
  ) async {
    Future<void> capture(String name) async {
      await tester.pumpAndSettle();
      await tester.runAsync(
        () => Future<void>.delayed(const Duration(seconds: 3)),
      );
      await tester.pumpAndSettle();
      await binding.takeScreenshot(name);
    }

    app.main();
    await tester.pumpAndSettle();
    await binding.convertFlutterSurfaceToImage();
    await tester.pumpAndSettle();
    await capture('android-01-ana-sayfa');

    await tester.ensureVisible(find.text('Kataloğu keşfet'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Kataloğu keşfet'));
    await tester.pumpAndSettle();
    expect(find.text('8 ürün'), findsOneWidget);
    await capture('android-02-katalog');

    await tester.tap(find.text('Yaşam').first);
    await tester.pumpAndSettle();
    expect(find.text('2 ürün'), findsOneWidget);
    await tester.tap(find.text('Tümü'));
    await tester.pumpAndSettle();
    await tester.enterText(find.byType(TextField), 'KUPA');
    await tester.pumpAndSettle();
    expect(find.text('1 ürün'), findsOneWidget);
    await tester.enterText(find.byType(TextField), 'olmayan ürün');
    await tester.pumpAndSettle();
    expect(find.text('Aramana uygun ürün bulunamadı.'), findsOneWidget);
    FocusManager.instance.primaryFocus?.unfocus();
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Filtreleri temizle'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Filtreleri temizle'));
    await tester.pumpAndSettle();
    expect(find.text('8 ürün'), findsOneWidget);

    await tester.ensureVisible(find.text('Seramik Kupa'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Seramik Kupa'));
    await tester.pumpAndSettle();
    expect(find.text('Ürün detayı'), findsOneWidget);
    await capture('android-03-urun-detayi');
    await tester.tap(find.text('Sepete ekle'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Sepetim'));
    await tester.pumpAndSettle();
    expect(find.text('Toplam (1 ürün)'), findsOneWidget);
    await tester.tap(find.byTooltip('Seramik Kupa artır'));
    await tester.pumpAndSettle();
    expect(find.text('498,00 ₺'), findsOneWidget);
    await capture('android-04-sepet');
    await tester.tap(find.byTooltip('Seramik Kupa azalt'));
    await tester.pumpAndSettle();
    expect(find.text('Toplam (1 ürün)'), findsOneWidget);
    await tester.tap(find.byTooltip('Seramik Kupa azalt'));
    await tester.pumpAndSettle();
    expect(find.text('Sepetin henüz boş.'), findsOneWidget);
    await capture('android-05-bos-sepet');
    await tester.tap(find.text('Koleksiyona dön'));
    await tester.pumpAndSettle();
    expect(find.text('Ürün detayı'), findsOneWidget);
    expect(tester.takeException(), isNull);
  });
}

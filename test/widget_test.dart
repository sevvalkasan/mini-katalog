import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mini_katalog/main.dart';
import 'package:mini_katalog/data/catalog_repository.dart';
import 'package:mini_katalog/models/product.dart';
import 'package:mini_katalog/state/cart.dart';

void main() {
  TestWidgetsFlutterBinding.ensureInitialized();
  test('Yerel JSON ve model dönüşümü', () async {
    final products = await CatalogRepository().load();
    expect(products.length, 8);
    for (final p in products) {
      expect(Product.fromJson(p.toJson()).toJson(), p.toJson());
    }
  });
  test('Sepet adet, toplam ve son ürünü silme', () async {
    final p = (await CatalogRepository().load()).first;
    final cart = Cart();
    cart.add(p);
    cart.add(p);
    expect(cart.count, 2);
    expect(cart.total, p.price * 2);
    cart.remove(p);
    expect(cart.quantity(p), 1);
    cart.remove(p);
    expect(cart.count, 0);
    expect(cart.total, 0);
    expect(cart.products, isEmpty);
    cart.remove(p);
    expect(cart.count, 0);
    cart.dispose();
  });
  testWidgets('Arama, boş sonuç ve filtre temizleme', (tester) async {
    await tester.runAsync(() async {
      await tester.pumpWidget(const CatalogApp());
      await Future<void>.delayed(const Duration(milliseconds: 300));
    });
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Kataloğu keşfet'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Kataloğu keşfet'));
    await tester.runAsync(() async {
      await tester.pump();
      await Future<void>.delayed(const Duration(milliseconds: 300));
    });
    await tester.pumpAndSettle();
    expect(find.text('Koleksiyonu keşfet'), findsOneWidget);
    await tester.enterText(find.byType(TextField), 'olmayan ürün');
    await tester.pumpAndSettle();
    expect(find.text('Aramana uygun ürün bulunamadı.'), findsOneWidget);
    tester.testTextInput.hide();
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Filtreleri temizle'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Filtreleri temizle'));
    await tester.pumpAndSettle();
    expect(find.text('8 ürün'), findsOneWidget);
    await tester.enterText(find.byType(TextField), 'KUPA');
    await tester.pumpAndSettle();
    expect(find.text('1 ürün'), findsOneWidget);
  });
  testWidgets('Route arguments, detaydan sepete ve geri dönüş', (tester) async {
    await tester.runAsync(() async {
      await tester.pumpWidget(const CatalogApp());
      await Future<void>.delayed(const Duration(milliseconds: 300));
    });
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Kataloğu keşfet'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Kataloğu keşfet'));
    await tester.runAsync(() async {
      await tester.pump();
      await Future<void>.delayed(const Duration(milliseconds: 300));
    });
    await tester.pumpAndSettle();
    await tester.ensureVisible(find.text('Seramik Kupa'));
    await tester.pumpAndSettle();
    await tester.tap(find.text('Seramik Kupa'));
    await tester.pumpAndSettle();
    expect(find.text('Ürün detayı'), findsOneWidget);
    await tester.tap(find.text('Sepete ekle'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Sepetim'));
    await tester.pumpAndSettle();
    expect(find.text('Toplam (1 ürün)'), findsOneWidget);
    await tester.tap(find.byTooltip('Seramik Kupa artır'));
    await tester.pumpAndSettle();
    expect(find.text('498,00 ₺'), findsOneWidget);
    await tester.tap(find.byTooltip('Seramik Kupa azalt'));
    await tester.pumpAndSettle();
    await tester.tap(find.byTooltip('Seramik Kupa azalt'));
    await tester.pumpAndSettle();
    expect(find.text('Sepetin henüz boş.'), findsOneWidget);
    await tester.tap(find.text('Koleksiyona dön'));
    await tester.pumpAndSettle();
    expect(find.text('Ürün detayı'), findsOneWidget);
  });
}

import 'package:flutter/material.dart';
import '../data/catalog_repository.dart';
import '../models/product.dart';
import '../state/cart.dart';
import '../widgets/cart_button.dart';

class CatalogScreen extends StatefulWidget {
  final Cart cart;
  const CatalogScreen({super.key, required this.cart});
  @override
  State<CatalogScreen> createState() => _CatalogScreenState();
}

class _CatalogScreenState extends State<CatalogScreen> {
  late Future<List<Product>> future;
  String query = '', category = 'Tümü';
  final search = TextEditingController();
  @override
  void initState() {
    super.initState();
    future = CatalogRepository().load();
  }

  @override
  void dispose() {
    search.dispose();
    super.dispose();
  }

  String normalize(String s) =>
      s.replaceAll('İ', 'i').replaceAll('I', 'ı').toLowerCase();
  @override
  Widget build(BuildContext context) => Scaffold(
    appBar: AppBar(
      title: const Row(
        children: [
          Icon(Icons.grid_view_rounded),
          SizedBox(width: 10),
          Text(
            'mini katalog',
            style: TextStyle(fontWeight: FontWeight.w800, letterSpacing: -1),
          ),
        ],
      ),
      actions: [CartButton(cart: widget.cart)],
    ),
    body: FutureBuilder<List<Product>>(
      future: future,
      builder: (context, snapshot) {
        if (snapshot.hasError)
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Text('Katalog yüklenemedi.'),
                TextButton(
                  onPressed: () => setState(() {
                    future = CatalogRepository().load();
                  }),
                  child: const Text('Tekrar dene'),
                ),
              ],
            ),
          );
        if (!snapshot.hasData)
          return const Center(child: CircularProgressIndicator());
        final all = snapshot.data!;
        final filtered = all
            .where(
              (p) =>
                  (category == 'Tümü' || p.category == category) &&
                  normalize(
                    '${p.name} ${p.category}',
                  ).contains(normalize(query)),
            )
            .toList();
        return Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 1100),
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Padding(
                    padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: double.infinity,
                          padding: const EdgeInsets.all(26),
                          decoration: BoxDecoration(
                            color: const Color(0xFF284D3F),
                            borderRadius: BorderRadius.circular(24),
                          ),
                          child: const Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                'AZ PARÇA, ÇOK İLHAM',
                                style: TextStyle(
                                  color: Color(0xFFD7E5BC),
                                  fontSize: 11,
                                  letterSpacing: 2,
                                ),
                              ),
                              SizedBox(height: 12),
                              Text(
                                'Günlük hayatın,\ngüzel detayları.',
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 32,
                                  height: 1.12,
                                  fontWeight: FontWeight.w700,
                                ),
                              ),
                              SizedBox(height: 14),
                              Text(
                                'Senin için seçilmiş sade ve işlevsel ürünler.',
                                style: TextStyle(
                                  color: Color(0xFFCFDBD3),
                                  height: 1.5,
                                ),
                              ),
                              SizedBox(height: 18),
                              Row(
                                children: [
                                  Icon(
                                    Icons.eco_outlined,
                                    color: Color(0xFFD7E5BC),
                                    size: 18,
                                  ),
                                  SizedBox(width: 8),
                                  Text(
                                    'Küçük bir keşfe çık',
                                    style: TextStyle(color: Colors.white),
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(height: 24),
                        TextField(
                          controller: search,
                          onChanged: (v) => setState(() => query = v),
                          decoration: InputDecoration(
                            hintText: 'Ürün veya kategori ara',
                            prefixIcon: const Icon(Icons.search),
                            suffixIcon: query.isEmpty
                                ? null
                                : IconButton(
                                    tooltip: 'Aramayı temizle',
                                    onPressed: () {
                                      search.clear();
                                      setState(() => query = '');
                                    },
                                    icon: const Icon(Icons.close),
                                  ),
                          ),
                        ),
                        const SizedBox(height: 14),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: Row(
                            children:
                                ['Tümü', ...all.map((p) => p.category).toSet()]
                                    .map(
                                      (c) => Padding(
                                        padding: const EdgeInsets.only(
                                          right: 8,
                                        ),
                                        child: ChoiceChip(
                                          label: Text(c),
                                          selected: category == c,
                                          onSelected: (_) =>
                                              setState(() => category = c),
                                          showCheckmark: false,
                                        ),
                                      ),
                                    )
                                    .toList(),
                          ),
                        ),
                        const SizedBox(height: 24),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Koleksiyonu keşfet',
                              style: TextStyle(
                                fontSize: 22,
                                fontWeight: FontWeight.w700,
                                letterSpacing: -.5,
                              ),
                            ),
                            Text(
                              '${filtered.length} ürün',
                              style: const TextStyle(color: Colors.black54),
                            ),
                          ],
                        ),
                        const SizedBox(height: 16),
                      ],
                    ),
                  ),
                ),
                if (filtered.isEmpty)
                  SliverToBoxAdapter(
                    child: Padding(
                      padding: const EdgeInsets.all(36),
                      child: Column(
                        children: [
                          const Icon(Icons.search_off, size: 42),
                          const SizedBox(height: 12),
                          const Text('Aramana uygun ürün bulunamadı.'),
                          TextButton(
                            onPressed: () {
                              search.clear();
                              setState(() {
                                query = '';
                                category = 'Tümü';
                              });
                            },
                            child: const Text('Filtreleri temizle'),
                          ),
                        ],
                      ),
                    ),
                  )
                else
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    sliver: SliverToBoxAdapter(
                      child: LayoutBuilder(
                        builder: (context, constraints) => GridView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          padding: EdgeInsets.zero,
                          itemCount: filtered.length,
                          itemBuilder: (context, i) {
                            final p = filtered[i];
                            return Card(
                              margin: EdgeInsets.zero,
                              elevation: 0,
                              color: Colors.white,
                              clipBehavior: Clip.antiAlias,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(18),
                                side: const BorderSide(
                                  color: Color(0xFFEAECE6),
                                ),
                              ),
                              child: InkWell(
                                onTap: () => Navigator.pushNamed(
                                  context,
                                  '/product',
                                  arguments: p,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Expanded(
                                      child: SizedBox(
                                        width: double.infinity,
                                        child: Hero(
                                          tag: 'product-${p.id}',
                                          child: Image.asset(
                                            p.image,
                                            fit: BoxFit.cover,
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.all(12),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            p.category.toUpperCase(),
                                            style: const TextStyle(
                                              fontSize: 9,
                                              letterSpacing: 1.2,
                                              color: Colors.black54,
                                            ),
                                          ),
                                          const SizedBox(height: 5),
                                          Text(
                                            p.name,
                                            maxLines: 1,
                                            overflow: TextOverflow.ellipsis,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w600,
                                              fontSize: 14,
                                            ),
                                          ),
                                          const SizedBox(height: 8),
                                          Row(
                                            children: [
                                              Expanded(
                                                child: Text(
                                                  money(p.price),
                                                  style: const TextStyle(
                                                    fontWeight: FontWeight.w800,
                                                    fontSize: 14,
                                                  ),
                                                ),
                                              ),
                                              SizedBox(
                                                width: 32,
                                                height: 32,
                                                child: IconButton.filled(
                                                  tooltip:
                                                      '${p.name} sepete ekle',
                                                  padding: EdgeInsets.zero,
                                                  iconSize: 18,
                                                  onPressed: () {
                                                    widget.cart.add(p);
                                                    ScaffoldMessenger.of(
                                                      context,
                                                    ).hideCurrentSnackBar();
                                                    ScaffoldMessenger.of(
                                                      context,
                                                    ).showSnackBar(
                                                      SnackBar(
                                                        content: Text(
                                                          '${p.name} sepete eklendi',
                                                        ),
                                                        duration:
                                                            const Duration(
                                                              seconds: 2,
                                                            ),
                                                      ),
                                                    );
                                                  },
                                                  icon: const Icon(Icons.add),
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            );
                          },
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: constraints.maxWidth > 760
                                    ? 4
                                    : constraints.maxWidth > 520
                                    ? 3
                                    : 2,
                                mainAxisExtent: 275,
                                mainAxisSpacing: 14,
                                crossAxisSpacing: 14,
                              ),
                        ),
                      ),
                    ),
                  ),
                const SliverToBoxAdapter(
                  child: Padding(
                    padding: EdgeInsets.all(28),
                    child: Text(
                      'Özenle seçildi. Keyifle keşfet.\nMini Katalog • Eğitim projesi',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        color: Colors.black45,
                        height: 1.8,
                        fontSize: 12,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    ),
  );
}

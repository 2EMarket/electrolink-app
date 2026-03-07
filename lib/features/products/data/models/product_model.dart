class ProductModel {
  final String id;
  final String title;
  final String condition;
  final num price; // استخدمنا num عشان تقبل double أو int
  final String status;
  final int viewCount;
  final bool isNegotiable;
  // المصفوفات والكائنات الفرعية (ممكن نخليها nullable مؤقتاً لتجنب الأخطاء)
  final List<String> images;
  final String description;
  final DateTime? createdAt;
  final Map<String, dynamic>? user;

  ProductModel({
    required this.id,
    required this.title,
    required this.condition,
    required this.price,
    required this.status,
    required this.viewCount,
    required this.isNegotiable,
    required this.images,
    this.description = '',
    this.createdAt,
    this.user,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    // 1. تحديد المصدر الأساسي (المنتج المتداخل أو الكائن نفسه)
    final Map<String, dynamic>? nestedProduct =
        json['product'] is Map<String, dynamic> ? json['product'] : null;

    // 2. دالة بحث عميقة عن السعر في أي أوبجكت
    num? findPriceDeep(dynamic data) {
      if (data == null) return null;
      if (data is num && data > 0) return data;
      if (data is String) {
        String clean = data.replaceAll(RegExp(r'[^\d.]'), '');
        if (clean.contains('.') &&
            clean.indexOf('.') != clean.lastIndexOf('.')) {
          // التعامل مع حالات مثل 1.500.00
          clean = clean.replaceFirst('.', '');
        }
        num? p = num.tryParse(clean);
        if (p != null && p > 0) return p;
      }
      if (data is List && data.isNotEmpty) {
        for (var item in data) {
          num? p = findPriceDeep(item);
          if (p != null) return p;
        }
      }
      if (data is Map) {
        // مفاتيح ذات أولوية
        const priorityKeys = [
          'price',
          'listing_price',
          'amount',
          'value',
          'current_price',
          'productPrice',
        ];
        for (var k in priorityKeys) {
          num? p = findPriceDeep(data[k]);
          if (p != null) return p;
        }
        // بحث في كل المفاتيح التي تحتوي كلمة price أو amount
        for (var entry in data.entries) {
          String key = entry.key.toString().toLowerCase();
          if (key.contains('price') || key.contains('amount')) {
            num? p = findPriceDeep(entry.value);
            if (p != null) return p;
          }
        }
      }
      return null;
    }

    // 3. محاولة إيجاد السعر من أي مكان (الأب أو الابن)
    num price = findPriceDeep(json) ?? findPriceDeep(nestedProduct) ?? 0;

    // 4. بناء الـ Source النهائي بالدمج
    final Map<String, dynamic> source = Map<String, dynamic>.from(
      nestedProduct ?? json,
    );
    if (nestedProduct != null) {
      // دمج حقول الأب في الابن إذا كانت ناقصة
      json.forEach((key, value) {
        if (key != 'product' && value != null) {
          if (source[key] == null ||
              source[key] == 0 ||
              source[key].toString() == '0') {
            source[key] = value;
          }
        }
      });
    }

    // 5. ضمان الـ ID الصحيح (تجنب ID سجل المفضلة)
    String finalId =
        (nestedProduct?['id'] ??
                nestedProduct?['productId'] ??
                json['productId'] ??
                json['id'] ??
                '')
            .toString();

    return ProductModel(
      id: finalId,
      title: (source['title'] ?? source['name'] ?? '').toString(),
      condition: (source['condition'] ?? '').toString(),
      price: price,
      status: (source['status'] ?? '').toString(),
      viewCount: int.tryParse(source['viewCount']?.toString() ?? '0') ?? 0,
      isNegotiable:
          source['isNegotiable'] == true || source['is_negotiable'] == true,
      description:
          (source['description'] ?? source['content'] ?? '').toString(),
      createdAt:
          source['createdAt'] != null
              ? DateTime.tryParse(source['createdAt'].toString())
              : null,
      user: source['user'] ?? source['owner'] ?? source['author'],
      images:
          source['images'] != null
              ? (source['images'] as List)
                  .map((img) {
                    if (img is String) return img;
                    if (img is Map)
                      return (img['url'] ??
                              img['imageUrl'] ??
                              img['path'] ??
                              '')
                          .toString();
                    return '';
                  })
                  .where((url) => url.isNotEmpty)
                  .toList()
              : [],
    );
  }
}

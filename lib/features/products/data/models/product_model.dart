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

  ProductModel({
    required this.id,
    required this.title,
    required this.condition,
    required this.price,
    required this.status,
    required this.viewCount,
    required this.isNegotiable,
    required this.images,
  });

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id']?.toString() ?? '', // أمان إضافي لو الـ id رجع كرقم
      title: json['title'] ?? '',
      condition: json['condition'] ?? '',
      price: json['price'] ?? 0,
      status: json['status'] ?? '',
      viewCount: json['viewCount'] ?? 0,
      isNegotiable: json['isNegotiable'] ?? false,

      // التعديل السحري لحل مشكلة الـ Map:
      images:
          json['images'] != null
              ? (json['images'] as List)
                  .map((img) {
                    // إذا كانت الصورة جاية كنص مباشر
                    if (img is String) return img;
                    // إذا كانت جاية كـ Object (Map)
                    if (img is Map) {
                      // غالباً الرابط بيكون في حقل url أو path أو imageUrl
                      return img['url']?.toString() ??
                          img['imageUrl']?.toString() ??
                          img['path']?.toString() ??
                          '';
                    }
                    return '';
                  })
                  .where((url) => url.isNotEmpty)
                  .toList()
              : [],
    );
  }
}

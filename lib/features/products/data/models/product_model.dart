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
    // دالة مساعدة لضمان الحصول على رقم حتى لو وصلت البيانات كـ Map أو String
    num parseNum(dynamic value) {
      if (value is num) return value;
      if (value is String) return num.tryParse(value) ?? 0;
      if (value is Map && value.containsKey('price'))
        return parseNum(value['price']);
      if (value is Map && value.containsKey('value'))
        return parseNum(value['value']);
      if (value is Map && value.containsKey('amount'))
        return parseNum(value['amount']);
      return 0;
    }

    return ProductModel(
      id: json['id']?.toString() ?? '',
      title: json['title'] ?? '',
      condition: json['condition'] ?? '',
      price: parseNum(json['price']),
      status: json['status'] ?? '',
      viewCount: parseNum(json['viewCount']).toInt(),
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

import 'package:second_hand_electronics_marketplace/core/constants/app_assets.dart';
import 'package:second_hand_electronics_marketplace/features/auth/data/models/auth_models.dart';
import 'package:second_hand_electronics_marketplace/features/categories/data/models/category_model.dart';
import 'package:second_hand_electronics_marketplace/features/listing/data/models/listing_field_config.dart';
import 'package:second_hand_electronics_marketplace/features/location/data/models/city_model.dart' as loc;
import 'package:second_hand_electronics_marketplace/features/location/data/models/country_model.dart' as loc;
import 'package:second_hand_electronics_marketplace/features/products/data/models/product_model.dart';
import 'package:second_hand_electronics_marketplace/features/profile/data/models/user_model.dart';

/// ============================================================
/// MockData — بيانات وهمية احتياطية لكل نقاط الاتصال بالباكند
/// تُستخدم تلقائياً عند فشل الطلبات (الباكند واقف / لا إنترنت)
/// ============================================================
class MockData {
  MockData._();

  // ──────────────────────────────────────────
  // 🔑 Demo Account — للدخول وقت الباكند واقف
  // ──────────────────────────────────────────
  static const String demoEmail = 'demo@electrolink.com';
  static const String demoPassword = 'Demo1234';
  static const String mockToken = 'mock_demo_token_electrolink_2025';

  // ──────────────────────────────────────────
  // 🌍 Countries & Cities — دول ومدن وهمية
  // ──────────────────────────────────────────
  static List<loc.CountryModel> get mockCountries => [
    loc.CountryModel(
      id: 'mock_country_01',
      nameEn: 'Palestine',
      nameAr: 'فلسطين',
      isoCode: 'PS',
      isActive: true,
      cities: [
        loc.CityModel(
          id: 'mock_city_01',
          nameEn: 'Gaza',
          nameAr: 'غزة',
          latitude: 31.5017,
          longitude: 34.4674,
        ),
        loc.CityModel(
          id: 'mock_city_02',
          nameEn: 'Ramallah',
          nameAr: 'رام الله',
          latitude: 31.9038,
          longitude: 35.2034,
        ),
        loc.CityModel(
          id: 'mock_city_03',
          nameEn: 'Nablus',
          nameAr: 'نابلس',
          latitude: 32.2211,
          longitude: 35.2544,
        ),
        loc.CityModel(
          id: 'mock_city_04',
          nameEn: 'Hebron',
          nameAr: 'الخليل',
          latitude: 31.5326,
          longitude: 35.0998,
        ),
        loc.CityModel(
          id: 'mock_city_05',
          nameEn: 'Jenin',
          nameAr: 'جنين',
          latitude: 32.4591,
          longitude: 35.2972,
        ),
        loc.CityModel(
          id: 'mock_city_06',
          nameEn: 'Bethlehem',
          nameAr: 'بيت لحم',
          latitude: 31.7054,
          longitude: 35.2024,
        ),
        loc.CityModel(
          id: 'mock_city_07',
          nameEn: 'Tulkarm',
          nameAr: 'طولكرم',
          latitude: 32.3107,
          longitude: 35.0286,
        ),
        loc.CityModel(
          id: 'mock_city_08',
          nameEn: 'Qalqilya',
          nameAr: 'قلقيلية',
          latitude: 32.1894,
          longitude: 34.9704,
        ),
      ],
    ),
    loc.CountryModel(
      id: 'mock_country_02',
      nameEn: 'Jordan',
      nameAr: 'الأردن',
      isoCode: 'JO',
      isActive: true,
      cities: [
        loc.CityModel(
          id: 'mock_city_09',
          nameEn: 'Amman',
          nameAr: 'عمان',
          latitude: 31.9539,
          longitude: 35.9106,
        ),
        loc.CityModel(
          id: 'mock_city_10',
          nameEn: 'Irbid',
          nameAr: 'إربد',
          latitude: 32.5556,
          longitude: 35.8500,
        ),
        loc.CityModel(
          id: 'mock_city_11',
          nameEn: 'Zarqa',
          nameAr: 'الزرقاء',
          latitude: 32.0728,
          longitude: 36.0879,
        ),
        loc.CityModel(
          id: 'mock_city_12',
          nameEn: 'Aqaba',
          nameAr: 'العقبة',
          latitude: 29.5321,
          longitude: 35.0063,
        ),
      ],
    ),
    loc.CountryModel(
      id: 'mock_country_03',
      nameEn: 'Egypt',
      nameAr: 'مصر',
      isoCode: 'EG',
      isActive: true,
      cities: [
        loc.CityModel(
          id: 'mock_city_13',
          nameEn: 'Cairo',
          nameAr: 'القاهرة',
          latitude: 30.0444,
          longitude: 31.2357,
        ),
        loc.CityModel(
          id: 'mock_city_14',
          nameEn: 'Alexandria',
          nameAr: 'الإسكندرية',
          latitude: 31.2001,
          longitude: 29.9187,
        ),
        loc.CityModel(
          id: 'mock_city_15',
          nameEn: 'Giza',
          nameAr: 'الجيزة',
          latitude: 30.0131,
          longitude: 31.2089,
        ),
      ],
    ),
    loc.CountryModel(
      id: 'mock_country_04',
      nameEn: 'Lebanon',
      nameAr: 'لبنان',
      isoCode: 'LB',
      isActive: true,
      cities: [
        loc.CityModel(
          id: 'mock_city_16',
          nameEn: 'Beirut',
          nameAr: 'بيروت',
          latitude: 33.8938,
          longitude: 35.5018,
        ),
        loc.CityModel(
          id: 'mock_city_17',
          nameEn: 'Tripoli',
          nameAr: 'طرابلس',
          latitude: 34.4367,
          longitude: 35.8497,
        ),
        loc.CityModel(
          id: 'mock_city_18',
          nameEn: 'Sidon',
          nameAr: 'صيدا',
          latitude: 33.5631,
          longitude: 35.3714,
        ),
      ],
    ),
    loc.CountryModel(
      id: 'mock_country_05',
      nameEn: 'Saudi Arabia',
      nameAr: 'المملكة العربية السعودية',
      isoCode: 'SA',
      isActive: true,
      cities: [
        loc.CityModel(
          id: 'mock_city_19',
          nameEn: 'Riyadh',
          nameAr: 'الرياض',
          latitude: 24.6877,
          longitude: 46.7219,
        ),
        loc.CityModel(
          id: 'mock_city_20',
          nameEn: 'Jeddah',
          nameAr: 'جدة',
          latitude: 21.5433,
          longitude: 39.1728,
        ),
        loc.CityModel(
          id: 'mock_city_21',
          nameEn: 'Mecca',
          nameAr: 'مكة المكرمة',
          latitude: 21.3891,
          longitude: 39.8579,
        ),
      ],
    ),
  ];


  static AuthResponseModel get mockAuthResponse => AuthResponseModel(
    success: true,
    message: '🧪 Demo Mode: تسجيل دخول تجريبي',
    token: mockToken,
    user: UserModel(
      id: 'mock_user_001',
      fullName: 'مستخدم تجريبي',
      email: demoEmail,
      phoneNumber: '+970599000000',
      role: 'buyer',
      isEmailVerified: true,
      isPhoneVerified: true,
      isIdentityVerified: false,
    ),
  );

  // ──────────────────────────────────────────
  // 👤 Profile — بروفايل وهمي
  // ──────────────────────────────────────────
  static ProfileModel get mockProfile => ProfileModel(
    id: 1,
    userId: 1,
    bio: 'مستخدم تجريبي في وضع المحاكاة 🧪',
    location: 'فلسطين، رام الله',
    avatarAssetId: null,
    countryId: 1,
    country: CountryModel(
      id: 1,
      nameEn: 'Palestine',
      nameAr: 'فلسطين',
      isoCode: 'PS',
      currencySymbolEn: 'ILS',
      currencySymbolAr: '₪',
      isActive: true,
    ),
  );

  static AppUserModel get mockAppUser => AppUserModel(
    user: mockAuthResponse.user!,
    profile: mockProfile,
  );

  // ──────────────────────────────────────────
  // 🏷️ Categories — كاتيغوري وهمية
  // ──────────────────────────────────────────
  static CategoryResponseModel get mockCategoryResponse =>
      CategoryResponseModel(
        data: [
          CategoryModel(
            id: 'mock_cat_01',
            name: 'Phones',
            isActive: true,
            icon: CategoryIconModel(
              id: 'icon_01',
              url: '',
              type: 'svg',
              fileName: 'smart_phone_category.svg',
            ),
          ),
          CategoryModel(
            id: 'mock_cat_02',
            name: 'Laptops',
            isActive: true,
            icon: CategoryIconModel(
              id: 'icon_02',
              url: '',
              type: 'svg',
              fileName: 'laptop_category.svg',
            ),
          ),
          CategoryModel(
            id: 'mock_cat_03',
            name: 'Tablets',
            isActive: true,
            icon: CategoryIconModel(
              id: 'icon_03',
              url: '',
              type: 'svg',
              fileName: 'tablet_category.svg',
            ),
          ),
          CategoryModel(
            id: 'mock_cat_04',
            name: 'Gaming',
            isActive: true,
            icon: CategoryIconModel(
              id: 'icon_04',
              url: '',
              type: 'svg',
              fileName: 'game_category.svg',
            ),
          ),
          CategoryModel(
            id: 'mock_cat_05',
            name: 'Cameras',
            isActive: true,
            icon: CategoryIconModel(
              id: 'icon_05',
              url: '',
              type: 'svg',
              fileName: 'camera_category.svg',
            ),
          ),
          CategoryModel(
            id: 'mock_cat_06',
            name: 'Audio',
            isActive: true,
            icon: CategoryIconModel(
              id: 'icon_06',
              url: '',
              type: 'svg',
              fileName: 'headphone_category.svg',
            ),
          ),
          CategoryModel(
            id: 'mock_cat_07',
            name: 'Smart Watches',
            isActive: true,
            icon: CategoryIconModel(
              id: 'icon_07',
              url: '',
              type: 'svg',
              fileName: 'smart_watch_category.svg',
            ),
          ),
        ],
        meta: CategoryMetaModel(total: 7, page: 1, lastPage: 1),
      );

  // ──────────────────────────────────────────
  // 📦 Products — منتجات وهمية
  // ──────────────────────────────────────────
  static List<ProductModel> get mockProducts => [
    ProductModel(
      id: 'mock_prod_001',
      title: 'iPhone 15 Pro Max - 256GB',
      condition: 'like_new',
      price: 1200,
      status: 'approved',
      viewCount: 342,
      isNegotiable: true,
      description:
          'آيفون 15 برو ماكس بحالة ممتازة، استخدام خفيف، مع الكرتون الأصلي وجميع الملحقات.',
      createdAt: DateTime.now().subtract(const Duration(days: 3)),
      images: [
        'https://images.unsplash.com/photo-1695048133142-1a20484d2569?w=400',
      ],
      user: {
        'id': 'mock_user_002',
        'fullName': 'أحمد الخالدي',
        'email': 'ahmad@example.com',
      },
    ),
    ProductModel(
      id: 'mock_prod_002',
      title: 'Samsung Galaxy S24 Ultra',
      condition: 'good',
      price: 900,
      status: 'approved',
      viewCount: 210,
      isNegotiable: false,
      description:
          'سامسونج جالاكسي S24 الترا، 512GB، بحالة جيدة جداً. بدون خدش.',
      createdAt: DateTime.now().subtract(const Duration(days: 7)),
      images: [
        'https://images.unsplash.com/photo-1706467488050-b0c45d695e2e?w=400',
      ],
      user: {
        'id': 'mock_user_003',
        'fullName': 'سارة محمود',
        'email': 'sara@example.com',
      },
    ),
    ProductModel(
      id: 'mock_prod_003',
      title: 'MacBook Pro M3 - 14 inch',
      condition: 'like_new',
      price: 2500,
      status: 'approved',
      viewCount: 589,
      isNegotiable: true,
      description: 'ماك بوك برو M3، 16GB RAM، 512GB SSD. استُخدم لمدة شهر فقط.',
      createdAt: DateTime.now().subtract(const Duration(days: 1)),
      images: [
        'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=400',
      ],
      user: {
        'id': 'mock_user_004',
        'fullName': 'عمر العمري',
        'email': 'omar@example.com',
      },
    ),
    ProductModel(
      id: 'mock_prod_004',
      title: 'Dell XPS 15 - 2023',
      condition: 'good',
      price: 1800,
      status: 'approved',
      viewCount: 134,
      isNegotiable: true,
      description: 'ديل XPS 15، Intel Core i7، 32GB RAM، 1TB SSD، بطاقة Nvidia.',
      createdAt: DateTime.now().subtract(const Duration(days: 12)),
      images: [
        'https://images.unsplash.com/photo-1593642632559-0c6d3fc62b89?w=400',
      ],
      user: {
        'id': 'mock_user_005',
        'fullName': 'نور الدين',
        'email': 'nour@example.com',
      },
    ),
    ProductModel(
      id: 'mock_prod_005',
      title: 'iPad Air 5th Gen - 64GB',
      condition: 'new',
      price: 750,
      status: 'approved',
      viewCount: 278,
      isNegotiable: false,
      description: 'آيباد إير الجيل الخامس، جديد بالكرتون، لم يُفتح. لون أزرق.',
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
      images: [
        'https://images.unsplash.com/photo-1544244015-0df4b3ffc6b0?w=400',
      ],
      user: {
        'id': 'mock_user_006',
        'fullName': 'ليلى حسن',
        'email': 'layla@example.com',
      },
    ),
    ProductModel(
      id: 'mock_prod_006',
      title: 'Sony WH-1000XM5 Headphones',
      condition: 'like_new',
      price: 350,
      status: 'approved',
      viewCount: 95,
      isNegotiable: true,
      description:
          'سماعات سوني WH-1000XM5، إلغاء الضوضاء الرائد. بحالة ممتازة مع الحقيبة.',
      createdAt: DateTime.now().subtract(const Duration(days: 5)),
      images: [
        'https://images.unsplash.com/photo-1583394838336-acd977736f90?w=400',
      ],
      user: {
        'id': 'mock_user_007',
        'fullName': 'خالد العزاوي',
        'email': 'khaled@example.com',
      },
    ),
    ProductModel(
      id: 'mock_prod_007',
      title: 'PlayStation 5 - Disc Edition',
      condition: 'good',
      price: 550,
      status: 'approved',
      viewCount: 421,
      isNegotiable: false,
      description: 'بلايستيشن 5 نسخة الأقراص، مع يد تحكم إضافية وثلاثة العاب.',
      createdAt: DateTime.now().subtract(const Duration(days: 9)),
      images: [
        'https://images.unsplash.com/photo-1607853202273-797f1c22a38e?w=400',
      ],
      user: {
        'id': 'mock_user_008',
        'fullName': 'يوسف السالم',
        'email': 'yousef@example.com',
      },
    ),
    ProductModel(
      id: 'mock_prod_008',
      title: 'Canon EOS R50 Camera Kit',
      condition: 'new',
      price: 800,
      status: 'approved',
      viewCount: 167,
      isNegotiable: true,
      description: 'كاميرا كانون EOS R50 بعدستين، جديدة بالكرتون. مثالية للمبتدئين.',
      createdAt: DateTime.now().subtract(const Duration(days: 4)),
      images: [
        'https://images.unsplash.com/photo-1510127034890-ba27508e9f1c?w=400',
      ],
      user: {
        'id': 'mock_user_009',
        'fullName': 'مريم القاسم',
        'email': 'mariam@example.com',
      },
    ),
    ProductModel(
      id: 'mock_prod_009',
      title: 'Apple Watch Series 9 - 45mm',
      condition: 'like_new',
      price: 400,
      status: 'approved',
      viewCount: 203,
      isNegotiable: true,
      description:
          'ساعة آبل Series 9، 45mm، ألومنيوم أسود. مع حزامين إضافيين.',
      createdAt: DateTime.now().subtract(const Duration(days: 6)),
      images: [
        'https://images.unsplash.com/photo-1546868871-7041f2a55e12?w=400',
      ],
      user: {
        'id': 'mock_user_010',
        'fullName': 'طارق المنصور',
        'email': 'tarek@example.com',
      },
    ),
    ProductModel(
      id: 'mock_prod_010',
      title: 'ASUS ROG Gaming Laptop',
      condition: 'good',
      price: 2000,
      status: 'approved',
      viewCount: 315,
      isNegotiable: true,
      description:
          'لاب توب ASUS ROG للألعاب، RTX 4070، Intel i9، 32GB RAM، 1TB SSD.',
      createdAt: DateTime.now().subtract(const Duration(days: 8)),
      images: [
        'https://images.unsplash.com/photo-1525547719571-a2d4ac8945e2?w=400',
      ],
      user: {
        'id': 'mock_user_011',
        'fullName': 'هاني العلي',
        'email': 'hani@example.com',
      },
    ),
  ];

  /// منتجات الحساب التجريبي (my products)
  static List<ProductModel> get mockMyProducts => [
    ProductModel(
      id: 'mock_my_prod_001',
      title: 'iPhone 13 - 128GB',
      condition: 'good',
      price: 650,
      status: 'approved',
      viewCount: 45,
      isNegotiable: true,
      description: 'آيفون 13، بحالة جيدة، بدون خدوش كبيرة.',
      createdAt: DateTime.now().subtract(const Duration(days: 15)),
      images: [
        'https://images.unsplash.com/photo-1632661674596-df8be070a5c5?w=400',
      ],
    ),
    ProductModel(
      id: 'mock_my_prod_002',
      title: 'AirPods Pro 2nd Gen',
      condition: 'like_new',
      price: 180,
      status: 'pending',
      viewCount: 12,
      isNegotiable: false,
      description: 'إيربودز برو الجيل الثاني، بحالة ممتازة.',
      createdAt: DateTime.now().subtract(const Duration(days: 2)),
      images: [
        'https://images.unsplash.com/photo-1600294037681-c80b4cb5b434?w=400',
      ],
    ),
  ];

  // ──────────────────────────────────────────
  // ❤️ Wishlist — قائمة المفضلة الوهمية
  // ──────────────────────────────────────────
  static Map<String, dynamic> get mockWishlistResponse => {
    'success': true,
    'data': {
      'data': [
        {
          'id': 'wish_001',
          'productId': 'mock_prod_001',
          'product': {
            'id': 'mock_prod_001',
            'title': 'iPhone 15 Pro Max - 256GB',
            'condition': 'like_new',
            'price': 1200,
            'status': 'approved',
            'viewCount': 342,
            'isNegotiable': true,
            'images': [
              {
                'url':
                    'https://images.unsplash.com/photo-1695048133142-1a20484d2569?w=400',
              },
            ],
          },
        },
        {
          'id': 'wish_002',
          'productId': 'mock_prod_003',
          'product': {
            'id': 'mock_prod_003',
            'title': 'MacBook Pro M3 - 14 inch',
            'condition': 'like_new',
            'price': 2500,
            'status': 'approved',
            'viewCount': 589,
            'isNegotiable': true,
            'images': [
              {
                'url':
                    'https://images.unsplash.com/photo-1517336714731-489689fd1ca8?w=400',
              },
            ],
          },
        },
      ],
    },
  };

  // ──────────────────────────────────────────
  // 🏷️ Listing Categories — كاتيغوري الـ Listing
  // ──────────────────────────────────────────
  static List<ListingCategoryConfig> get mockListingCategories => [
    ListingCategoryConfig(
      id: 'mock_cat_01',
      name: 'Phones',
      icon: AppAssets.smartPhoneCatIcon,
      fields: [
        const ListingFieldConfig(
          key: 'mock_attr_brand',
          attributeId: 'mock_attr_brand',
          label: 'Brand',
          hint: 'e.g. Apple, Samsung',
          required: true,
          type: ListingFieldType.selection,
          options: ['Apple', 'Samsung', 'Huawei', 'Xiaomi', 'OnePlus', 'Other'],
          legacyKey: 'brand',
        ),
        const ListingFieldConfig(
          key: 'mock_attr_storage',
          attributeId: 'mock_attr_storage',
          label: 'Storage',
          required: true,
          type: ListingFieldType.selection,
          options: ['64GB', '128GB', '256GB', '512GB', '1TB'],
          legacyKey: 'storage',
        ),
        const ListingFieldConfig(
          key: 'mock_attr_color',
          attributeId: 'mock_attr_color',
          label: 'Color',
          hint: 'e.g. Black, White',
          required: false,
          type: ListingFieldType.text,
          legacyKey: 'color',
        ),
      ],
    ),
    ListingCategoryConfig(
      id: 'mock_cat_02',
      name: 'Laptops',
      icon: AppAssets.laptopCatIcon,
      fields: [
        const ListingFieldConfig(
          key: 'mock_attr_brand_laptop',
          attributeId: 'mock_attr_brand_laptop',
          label: 'Brand',
          required: true,
          type: ListingFieldType.selection,
          options: [
            'Apple',
            'Dell',
            'HP',
            'Lenovo',
            'ASUS',
            'Acer',
            'MSI',
            'Other',
          ],
          legacyKey: 'brand',
        ),
        const ListingFieldConfig(
          key: 'mock_attr_ram',
          attributeId: 'mock_attr_ram',
          label: 'RAM',
          required: true,
          type: ListingFieldType.selection,
          options: ['8GB', '16GB', '32GB', '64GB'],
          legacyKey: 'ram',
        ),
        const ListingFieldConfig(
          key: 'mock_attr_ssd',
          attributeId: 'mock_attr_ssd',
          label: 'Storage (SSD)',
          required: false,
          type: ListingFieldType.selection,
          options: ['256GB', '512GB', '1TB', '2TB'],
          legacyKey: 'storage',
        ),
      ],
    ),
    ListingCategoryConfig(
      id: 'mock_cat_03',
      name: 'Tablets',
      icon: AppAssets.tabletCatIcon,
      fields: [
        const ListingFieldConfig(
          key: 'mock_attr_brand_tab',
          attributeId: 'mock_attr_brand_tab',
          label: 'Brand',
          required: true,
          type: ListingFieldType.selection,
          options: ['Apple', 'Samsung', 'Lenovo', 'Huawei', 'Other'],
          legacyKey: 'brand',
        ),
        const ListingFieldConfig(
          key: 'mock_attr_storage_tab',
          attributeId: 'mock_attr_storage_tab',
          label: 'Storage',
          required: false,
          type: ListingFieldType.selection,
          options: ['64GB', '128GB', '256GB', '512GB'],
          legacyKey: 'storage',
        ),
      ],
    ),
    ListingCategoryConfig(
      id: 'mock_cat_04',
      name: 'Gaming',
      icon: AppAssets.gameCatIcon,
      fields: [
        const ListingFieldConfig(
          key: 'mock_attr_platform',
          attributeId: 'mock_attr_platform',
          label: 'Platform',
          required: true,
          type: ListingFieldType.selection,
          options: [
            'PlayStation 5',
            'PlayStation 4',
            'Xbox Series X',
            'Xbox One',
            'Nintendo Switch',
            'PC',
            'Other',
          ],
          legacyKey: 'platform',
        ),
      ],
    ),
    ListingCategoryConfig(
      id: 'mock_cat_05',
      name: 'Cameras',
      icon: AppAssets.cameraCatIcon,
      fields: [
        const ListingFieldConfig(
          key: 'mock_attr_brand_cam',
          attributeId: 'mock_attr_brand_cam',
          label: 'Brand',
          required: true,
          type: ListingFieldType.selection,
          options: [
            'Canon',
            'Nikon',
            'Sony',
            'Fujifilm',
            'Panasonic',
            'Other',
          ],
          legacyKey: 'brand',
        ),
        const ListingFieldConfig(
          key: 'mock_attr_type_cam',
          attributeId: 'mock_attr_type_cam',
          label: 'Camera Type',
          required: false,
          type: ListingFieldType.selection,
          options: ['DSLR', 'Mirrorless', 'Compact', 'Action'],
          legacyKey: 'camera_type',
        ),
      ],
    ),
    ListingCategoryConfig(
      id: 'mock_cat_06',
      name: 'Audio',
      icon: AppAssets.headphoneCatIcon,
      fields: [
        const ListingFieldConfig(
          key: 'mock_attr_brand_audio',
          attributeId: 'mock_attr_brand_audio',
          label: 'Brand',
          required: true,
          type: ListingFieldType.selection,
          options: ['Sony', 'Apple', 'Bose', 'JBL', 'Sennheiser', 'Other'],
          legacyKey: 'brand',
        ),
        const ListingFieldConfig(
          key: 'mock_attr_type_audio',
          attributeId: 'mock_attr_type_audio',
          label: 'Type',
          required: false,
          type: ListingFieldType.selection,
          options: [
            'Over-Ear',
            'In-Ear (Earbuds)',
            'On-Ear',
            'Speaker',
            'Other',
          ],
          legacyKey: 'audio_type',
        ),
      ],
    ),
    ListingCategoryConfig(
      id: 'mock_cat_07',
      name: 'Smart Watches',
      icon: AppAssets.smartWatchCatIcon,
      fields: [
        const ListingFieldConfig(
          key: 'mock_attr_brand_watch',
          attributeId: 'mock_attr_brand_watch',
          label: 'Brand',
          required: true,
          type: ListingFieldType.selection,
          options: [
            'Apple',
            'Samsung',
            'Garmin',
            'Fitbit',
            'Huawei',
            'Other',
          ],
          legacyKey: 'brand',
        ),
      ],
    ),
  ];
}

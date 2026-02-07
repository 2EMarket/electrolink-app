import 'package:second_hand_electronics_marketplace/core/constants/app_assets.dart';
import 'package:second_hand_electronics_marketplace/features/listing/data/models/listing_field_config.dart';

class ListingCatalogService {
  List<ListingCategoryConfig> getCategories() {
    return const [
      ListingCategoryConfig(
        name: 'Phones',
        icon: AppAssets.smartPhoneCatIcon,
        fields: [
          ListingFieldConfig(
            key: 'brand',
            label: 'Brand',
            required: true,
            type: ListingFieldType.selection,
            options: [
              'Apple',
              'Samsung',
              'Xiaomi',
              'Huawei',
              'Nokia',
              'Google',
              'OnePlus',
            ],
          ),
          ListingFieldConfig(
            key: 'model',
            label: 'Model',
            required: true,
            hint: 'Enter model',
            type: ListingFieldType.text,
          ),
          ListingFieldConfig(
            key: 'storage',
            label: 'Storage',
            required: true,
            type: ListingFieldType.selection,
            options: ['64 GB', '128 GB', '256 GB', '512 GB', '1 TB'],
          ),
          ListingFieldConfig(
            key: 'battery',
            label: 'Battery Health',
            hint: 'Enter battery health (e.g. 85%)',
            type: ListingFieldType.number,
          ),
        ],
      ),
      ListingCategoryConfig(
        name: 'Tablets',
        icon: AppAssets.tabletCatIcon,
        fields: [
          ListingFieldConfig(
            key: 'brand',
            label: 'Brand',
            required: true,
            type: ListingFieldType.selection,
            options: ['Apple', 'Samsung', 'Huawei', 'Xiaomi', 'Lenovo'],
          ),
          ListingFieldConfig(
            key: 'model',
            label: 'Model',
            required: true,
            hint: 'Enter model',
          ),
          ListingFieldConfig(
            key: 'storage',
            label: 'Storage',
            required: true,
            type: ListingFieldType.selection,
            options: ['32 GB', '64 GB', '128 GB', '256 GB'],
          ),
        ],
      ),
      ListingCategoryConfig(
        name: 'Laptops',
        icon: AppAssets.laptopCatIcon,
        fields: [
          ListingFieldConfig(
            key: 'brand',
            label: 'Brand',
            required: true,
            type: ListingFieldType.selection,
            options: ['Apple', 'Dell', 'HP', 'Lenovo', 'Asus', 'Acer'],
          ),
          ListingFieldConfig(
            key: 'model',
            label: 'Model',
            required: true,
            hint: 'Enter model',
          ),
          ListingFieldConfig(
            key: 'cpu',
            label: 'CPU',
            hint: 'Enter CPU model',
          ),
          ListingFieldConfig(
            key: 'ram',
            label: 'RAM',
            type: ListingFieldType.selection,
            options: ['4 GB', '8 GB', '16 GB', '32 GB', '64 GB'],
          ),
          ListingFieldConfig(
            key: 'storage',
            label: 'Storage',
            type: ListingFieldType.selection,
            options: ['128 GB', '256 GB', '512 GB', '1 TB', '2 TB'],
          ),
        ],
      ),
      ListingCategoryConfig(
        name: 'PC Parts',
        icon: AppAssets.aiChipCatIcon,
        fields: [
          ListingFieldConfig(
            key: 'brand',
            label: 'Brand',
            hint: 'Enter brand',
          ),
          ListingFieldConfig(
            key: 'model',
            label: 'Model',
            hint: 'Enter model',
          ),
        ],
      ),
      ListingCategoryConfig(
        name: 'Gaming',
        icon: AppAssets.gameCatIcon,
        fields: [
          ListingFieldConfig(
            key: 'brand',
            label: 'Brand',
            hint: 'Enter brand',
          ),
          ListingFieldConfig(
            key: 'model',
            label: 'Model',
            hint: 'Enter model',
          ),
        ],
      ),
      ListingCategoryConfig(
        name: 'Audio',
        icon: AppAssets.headphoneCatIcon,
        fields: [
          ListingFieldConfig(
            key: 'brand',
            label: 'Brand',
            hint: 'Enter brand',
          ),
          ListingFieldConfig(
            key: 'model',
            label: 'Model',
            hint: 'Enter model',
          ),
        ],
      ),
      ListingCategoryConfig(
        name: 'Smartwatches',
        icon: AppAssets.smartWatchCatIcon,
        fields: [
          ListingFieldConfig(
            key: 'brand',
            label: 'Brand',
            hint: 'Enter brand',
          ),
          ListingFieldConfig(
            key: 'model',
            label: 'Model',
            hint: 'Enter model',
          ),
        ],
      ),
      ListingCategoryConfig(
        name: 'Cameras',
        icon: AppAssets.cameraCatIcon,
        fields: [
          ListingFieldConfig(
            key: 'brand',
            label: 'Brand',
            required: true,
            type: ListingFieldType.selection,
            options: ['Canon', 'Nikon', 'Sony', 'Fujifilm', 'Panasonic'],
          ),
          ListingFieldConfig(
            key: 'model',
            label: 'Model',
            required: true,
            hint: 'Enter model',
          ),
          ListingFieldConfig(
            key: 'lens',
            label: 'Lens',
            hint: 'Enter lens info',
          ),
        ],
      ),
      ListingCategoryConfig(
        name: 'Smart Home',
        icon: AppAssets.plugCatIcon,
        fields: [
          ListingFieldConfig(
            key: 'brand',
            label: 'Brand',
            hint: 'Enter brand',
          ),
          ListingFieldConfig(
            key: 'model',
            label: 'Model',
            hint: 'Enter model',
          ),
        ],
      ),
      ListingCategoryConfig(
        name: 'TV & Monitors',
        icon: AppAssets.tvCatIcon,
        fields: [
          ListingFieldConfig(
            key: 'brand',
            label: 'Brand',
            hint: 'Enter brand',
          ),
          ListingFieldConfig(
            key: 'model',
            label: 'Model',
            hint: 'Enter model',
          ),
          ListingFieldConfig(
            key: 'size',
            label: 'Screen Size',
            hint: 'Enter size (e.g. 55 in)',
          ),
        ],
      ),
      ListingCategoryConfig(
        name: 'Accessories',
        icon: AppAssets.headphoneCatIcon,
        fields: [
          ListingFieldConfig(
            key: 'brand',
            label: 'Brand',
            hint: 'Enter brand',
          ),
          ListingFieldConfig(
            key: 'model',
            label: 'Model',
            hint: 'Enter model',
          ),
        ],
      ),
      ListingCategoryConfig(
        name: 'Networking',
        icon: AppAssets.routerCatIcon,
        fields: [
          ListingFieldConfig(
            key: 'brand',
            label: 'Brand',
            hint: 'Enter brand',
          ),
          ListingFieldConfig(
            key: 'model',
            label: 'Model',
            hint: 'Enter model',
          ),
        ],
      ),
    ];
  }

  ListingCategoryConfig? getCategoryConfig(String categoryName) {
    if (categoryName.trim().isEmpty) return null;
    return getCategories()
        .cast<ListingCategoryConfig?>()
        .firstWhere(
          (c) => c?.name.toLowerCase() == categoryName.toLowerCase(),
          orElse: () => null,
        );
  }

  List<String> getCountryOptions() {
    return const [
      'Palestine',
      'Jordan',
      'Egypt',
      'Lebanon',
      'Saudi Arabia',
    ];
  }

  List<String> getCityOptions(String country) {
    final c = country.toLowerCase();
    if (c.contains('palestine')) {
      return const ['Gaza', 'Ramallah', 'Hebron', 'Nablus'];
    }
    if (c.contains('jordan')) {
      return const ['Amman', 'Irbid', 'Zarqa'];
    }
    if (c.contains('egypt')) {
      return const ['Cairo', 'Alexandria', 'Giza'];
    }
    if (c.contains('lebanon')) {
      return const ['Beirut', 'Tripoli', 'Sidon'];
    }
    return const ['City 1', 'City 2', 'City 3'];
  }
}

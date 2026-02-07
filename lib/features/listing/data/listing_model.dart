import 'package:equatable/equatable.dart';

class ListingModel extends Equatable {
  final String id;
  final String name;
  final String price;
  final String location;
  final String imageUrl;
  final String category;
  final bool isFavorite;
  final bool isSold;
  final String ownerId;
  final ListingStatus? status;

  const ListingModel({
    required this.id,
    required this.name,
    required this.price,
    required this.location,
    required this.imageUrl,
    required this.category,
    this.isSold = false,
    this.isFavorite = false,
    this.ownerId = '1',
    this.status,
  });

  ListingModel copyWith({
    String? id,
    String? title,
    String? price,
    String? location,
    String? imageUrl,
    String? category,
    bool? isFavorite,
    bool? isSold,
  }) {
    return ListingModel(
      id: id ?? this.id,
      name: title ?? this.name,
      price: price ?? this.price,
      location: location ?? this.location,
      imageUrl: imageUrl ?? this.imageUrl,
      category: category ?? this.category,
      isFavorite: isFavorite ?? this.isFavorite,
      isSold: isSold ?? this.isSold,
    );
  }

  @override
  List<Object?> get props => [
    id,
    name,
    price,
    location,
    imageUrl,
    category,
    isFavorite,
    isSold,
    status,
  ];
}

final List<ListingModel> dummyListings = [
  const ListingModel(
    id: '1',
    name: 'iPhone 14 Pro Max',
    price: '2000 ILS',
    location: 'Gaza City',
    imageUrl:
        'https://fdn2.gsmarena.com/vv/pics/apple/apple-iphone-14-pro-max-1.jpg', // رابط صورة تجريبي
    category: 'Phones',
    isFavorite: true,
    isSold: true,
    ownerId: '1',
    status: ListingStatus.pending,
  ),
  const ListingModel(
    id: '2',
    name: 'MacBook Pro M2',
    price: '4500 ILS',
    location: 'Ramallah',
    imageUrl:
        'https://fdn2.gsmarena.com/vv/pics/apple/apple-macbook-pro-14-2021-01.jpg',
    category: 'Laptops',
    isFavorite: false,
    ownerId: '1',
    status: ListingStatus.active,
  ),
  const ListingModel(
    id: '3',
    name: 'Sony WH-1000XM5',
    price: '800 ILS',
    location: 'Nablus',
    imageUrl:
        'https://m.media-amazon.com/images/I/51SKmu2G9FL._AC_UF1000,1000_QL80_.jpg',
    category: 'Audio',
    isFavorite: false,
    ownerId: '1',
    status: ListingStatus.sold,
  ),
  const ListingModel(
    id: '4',
    name: 'iPad Air 5',
    price: '1800 ILS',
    location: 'Hebron',
    imageUrl:
        'https://fdn2.gsmarena.com/vv/pics/apple/apple-ipad-air-2022-1.jpg',
    category: 'Tablets',
    isFavorite: true,
    ownerId: '1',
    status: ListingStatus.rejected,
  ),
];

enum ListingStatus { pending, active, sold, archived, draft, rejected }

import 'package:equatable/equatable.dart';

enum ListingFieldType { text, number, selection }

class ListingFieldConfig extends Equatable {
  final String key;
  final String label;
  final String hint;
  final bool required;
  final ListingFieldType type;
  final List<String> options;

  const ListingFieldConfig({
    required this.key,
    required this.label,
    this.hint = '',
    this.required = false,
    this.type = ListingFieldType.text,
    this.options = const [],
  });

  @override
  List<Object?> get props => [key, label, hint, required, type, options];
}

class ListingCategoryConfig extends Equatable {
  final String name;
  final String icon;
  final List<ListingFieldConfig> fields;

  const ListingCategoryConfig({
    required this.name,
    required this.icon,
    required this.fields,
  });

  @override
  List<Object?> get props => [name, icon, fields];
}

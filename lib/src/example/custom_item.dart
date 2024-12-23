import 'package:searchable_dropdown/src/models/dropdown_item.dart';

class CustomItem implements DropdownItem {
  final String name;
  final String id;

  CustomItem({required this.name, required this.id});

  @override
  String get displayName => name;

  @override
  bool matches(String query) => name.toLowerCase().contains(query.toLowerCase());
}

import 'package:flutter/material.dart';
import 'package:searchable_dropdown/src/models/theme/dropdown_theme.dart';
import '../models/dropdown_item.dart';

class SearchableDropdown<T extends DropdownItem> extends StatefulWidget {
  final List<T> items;
  final T? value;
  final ValueChanged<T> onChanged;
  final String hint;
  final SearchableDropdownTheme theme;
  final Widget Function(T)? itemBuilder;
  final Widget Function(T?)? selectedItemBuilder;
  final bool showSearchBox;
  final String searchHint;

  const SearchableDropdown({
    super.key,
    required this.items,
    required this.onChanged,
    this.value,
    this.hint = 'Select an item',
    this.theme = const SearchableDropdownTheme(),
    this.itemBuilder,
    this.selectedItemBuilder,
    this.showSearchBox = true,
    this.searchHint = 'Search...',
  });

  @override
  State<SearchableDropdown<T>> createState() => _SearchableDropdownState<T>();
}

class _SearchableDropdownState<T extends DropdownItem>
    extends State<SearchableDropdown<T>> {
  final TextEditingController _searchController = TextEditingController();
  bool _isOpen = false;
  String _searchQuery = '';

  List<T> get filteredItems {
    if (_searchQuery.isEmpty) return widget.items;
    return widget.items
        .where((item) => item.matches(_searchQuery.toLowerCase()))
        .toList();
  }

  Widget _buildSelectedItem(T? item) {
    if (widget.selectedItemBuilder != null) {
      return widget.selectedItemBuilder!(item);
    }
    return Text(
      item?.displayName ?? widget.hint,
      style: item == null ? widget.theme.hintStyle : widget.theme.selectedItemStyle,
    );
  }

  Widget _buildDropdownItem(T item) {
    if (widget.itemBuilder != null) {
      return widget.itemBuilder!(item);
    }
    return Text(
      item.displayName,
      style: widget.theme.textStyle,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        _buildHeader(),
        if (_isOpen) _buildDropdown(),
      ],
    );
  }

  Widget _buildHeader() {
    return GestureDetector(
      onTap: () => setState(() => _isOpen = !_isOpen),
      child: Container(
        decoration: BoxDecoration(
          color: widget.theme.backgroundColor,
          borderRadius: BorderRadius.circular(widget.theme.borderRadius),
          border: _isOpen
              ? Border.all(color: widget.theme.activeColor)
              : null,
        ),
        padding: widget.theme.contentPadding,
        child: Row(
          children: [
            Expanded(child: _buildSelectedItem(widget.value)),
            Icon(
              _isOpen ? Icons.arrow_drop_up : Icons.arrow_drop_down,
              size: widget.theme.iconSize,
              color: widget.theme.hintColor,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDropdown() {
    return Container(
      margin: const EdgeInsets.only(top: 4),
      constraints: BoxConstraints(maxHeight: widget.theme.maxDropdownHeight),
      decoration: BoxDecoration(
        color: widget.theme.dropdownBackgroundColor,
        borderRadius: BorderRadius.circular(widget.theme.borderRadius),
        boxShadow: [
          BoxShadow(
            color: widget.theme.shadowColor,
            blurRadius: 8,
            offset: const Offset(0, 4),
          ),
        ],
      ),
      child: Column(
        children: [
          if (widget.showSearchBox) _buildSearchBox(),
          Expanded(child: _buildItemsList()),
        ],
      ),
    );
  }

  Widget _buildSearchBox() {
    return TextField(
      controller: _searchController,
      decoration: InputDecoration(
        hintText: widget.searchHint,
        hintStyle: widget.theme.hintStyle,
        contentPadding: widget.theme.contentPadding,
        border: InputBorder.none,
      ),
      style: widget.theme.textStyle,
      onChanged: (value) => setState(() => _searchQuery = value),
    );
  }

  Widget _buildItemsList() {
    return ListView.builder(
      padding: EdgeInsets.zero,
      shrinkWrap: true,
      itemCount: filteredItems.length,
      itemBuilder: (context, index) {
        final item = filteredItems[index];
        return InkWell(
          onTap: () {
            widget.onChanged(item);
            setState(() {
              _isOpen = false;
              _searchQuery = '';
              _searchController.clear();
            });
          },
          child: Container(
            padding: widget.theme.contentPadding,
            child: _buildDropdownItem(item),
          ),
        );
      },
    );
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }
}
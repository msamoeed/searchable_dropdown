import 'package:flutter/material.dart';

class SearchableDropdownTheme {
  final Color backgroundColor;
  final Color textColor;
  final Color hintColor;
  final Color activeColor;
  final Color dropdownBackgroundColor;
  final Color shadowColor;
  final double borderRadius;
  final EdgeInsets contentPadding;
  final TextStyle textStyle;
  final TextStyle hintStyle;
  final TextStyle selectedItemStyle;
  final double maxDropdownHeight;
  final double iconSize;

  const SearchableDropdownTheme({
    this.backgroundColor = Colors.white,
    this.textColor = Colors.black,
    this.hintColor = Colors.grey,
    this.activeColor = Colors.blue,
    this.dropdownBackgroundColor = Colors.white,
    this.shadowColor = Colors.black12,
    this.borderRadius = 8.0,
    this.contentPadding = const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
    this.textStyle = const TextStyle(fontSize: 16),
    this.hintStyle = const TextStyle(fontSize: 16, color: Colors.grey),
    this.selectedItemStyle = const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
    this.maxDropdownHeight = 200,
    this.iconSize = 24,
  });
}

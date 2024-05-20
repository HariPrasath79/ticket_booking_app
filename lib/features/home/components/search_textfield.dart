import 'package:flutter/material.dart';

class SearchInputField extends StatelessWidget {
  const SearchInputField({
    super.key,
    required this.focusNode,
    required this.controller,
    required this.onChanged,
    required this.fromOrTo,
    this.hintText = 'Enter city/airport name',
    required this.containsValue,
    required this.isFrom,
  });
  final String fromOrTo;
  final bool isFrom;
  final FocusNode focusNode;
  final bool containsValue;
  final String? hintText;

  final TextEditingController controller;
  final void Function(String)? onChanged;

  @override
  Widget build(BuildContext context) {
    return TextField(
      focusNode: focusNode,
      onChanged: onChanged,
      controller: controller,
      decoration: InputDecoration(
        hintStyle:
            containsValue ? const TextStyle(fontWeight: FontWeight.bold) : null,
        prefixIcon: isFrom
            ? IconButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                icon: const Icon(Icons.arrow_back))
            : null,
        floatingLabelBehavior: FloatingLabelBehavior.always,
        floatingLabelAlignment: FloatingLabelAlignment.start,
        border: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.black26)),
        label: Text(fromOrTo),
        hintText: hintText,
      ),
    );
  }
}

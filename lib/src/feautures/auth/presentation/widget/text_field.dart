import 'package:flutter/material.dart';

class TextFieldColumn extends StatelessWidget {
  const TextFieldColumn({
    super.key,
    required this.hintText,
    required this.headerText,
    this.maxLength,
    this.maxLines,
  });

  final String hintText;
  final String headerText;
  final int? maxLength;
  final int? maxLines;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 8.0),
            child: Text(
              headerText,
              style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.bold,
                  color: Theme.of(context).primaryColor),
            ),
          ),
          const SizedBox(height: 10),
          Padding(
            padding: const EdgeInsets.only(right: 10.0),
            child: TextFormField(
              maxLength: maxLength,
              maxLines: maxLines,
              decoration: InputDecoration(
                hintText: hintText,
                fillColor: Theme.of(context).primaryColor.withOpacity(0.3),
                filled: true,
                border: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide.none,
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: BorderSide(
                    color: Theme.of(context).primaryColor,
                    width: 2,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}

import 'package:flutter/material.dart';

class DescriptionTextField extends StatelessWidget {
  final String labelText;
  final void Function(String) onSave;
  final String Function(String) validator;

  const DescriptionTextField(
      {@required this.labelText,
      @required this.onSave,
      @required this.validator});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(7.0),
      child: TextFormField(
        maxLines: 5,
        cursorColor: Colors.blue[900],
        decoration: InputDecoration(
          floatingLabelBehavior: FloatingLabelBehavior.always,
          border: InputBorder.none,
          filled: true,
          fillColor: Colors.grey,
          labelText: 'Refflection Note',
          labelStyle: TextStyle(
            fontSize: 20,
            color: Colors.black,
          ),
        ),
        validator: validator,
        onSaved: onSave,
      ),
    );
  }
}

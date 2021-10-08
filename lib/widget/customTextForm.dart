import 'package:flutter/material.dart';

class CustomTextFormField extends StatelessWidget {
  final String labelText;
  VoidCallback function;
  final TextEditingController stringController;

  CustomTextFormField(
      {@required this.labelText, this.stringController, this.function});
  @override
  Widget build(BuildContext context) {
    final txt = new TextEditingController();
    return Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: new BorderRadius.circular(6.0),
        ),
        child: Padding(
          padding: const EdgeInsets.only(left: 20.0, right: 5.0),
          child: TextFormField(
            // onFieldSubmitted:function ,
            // TODO: on Submit Button
            // controller: stringController,
            cursorColor: Colors.blue[900],
            decoration: InputDecoration(
              border: InputBorder.none,
              labelText: labelText,
              labelStyle: TextStyle(
                fontSize: 14.0,
              ),
            ),
          ),
        ));
  }
}

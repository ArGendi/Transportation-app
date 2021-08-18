import 'package:flutter/material.dart';
import 'package:transportation/constants.dart';

class CustomTextField extends StatefulWidget {
  final String text;
  final bool obscureText;
  final TextInputType textInputType;
  final Function(String textInput) setValue;
  final Function(String value) validation;

  const CustomTextField({Key? key, required this.text, required this.obscureText, required this.textInputType, required this.setValue, required this.validation}) : super(key: key);

  @override
  _CustomTextFieldState createState() =>
      _CustomTextFieldState(obscureText: obscureText);
}

class _CustomTextFieldState extends State<CustomTextField> {
  bool _visibility = false;
  bool obscureText;

  _CustomTextFieldState({required this.obscureText});
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: Colors.grey.shade800,
      keyboardType: widget.textInputType,
      style: TextStyle(color: Colors.grey.shade800),
      obscureText: obscureText,
      decoration: InputDecoration(
        suffixIcon: widget.obscureText ? IconButton(
          icon: Icon(!_visibility ? Icons.visibility_off : Icons.visibility),
          color: Colors.grey.shade800,
          onPressed: () {
            setState(() {
              _visibility = !_visibility;
              obscureText = !obscureText;
            });
          },
        ) : null,
        labelText: widget.text,
        labelStyle: TextStyle(color: Colors.grey.shade800),
        contentPadding: EdgeInsets.all(15),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey.shade800,
            width: 2.0,
          ),
        ),
        enabledBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.grey.shade800,
            width: 2.0,
          ),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
            width: 2.0,
          ),
        ),
        focusedErrorBorder: OutlineInputBorder(
          borderSide: BorderSide(
            color: Colors.red,
            width: 2.0,
          ),
        ),
      ),
      onSaved: (value){
        widget.setValue(value!);
      },
      validator: (value){
        return widget.validation(value!);
      },
    );
  }
}

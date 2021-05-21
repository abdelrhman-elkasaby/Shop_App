import 'package:flutter/material.dart';

class WidgetsHelper{

  Widget buildTextFormField(
      {Icon prefIcon,
      IconButton suffixIcon,
      bool visible,
      @required TextEditingController controller,
      @required TextInputType type,
      @required Function(String) validatorFunction,
      @required Function(String) onSavedFunction,
      @required String hint}){
    return TextFormField(
      controller: controller,
      keyboardType: type,
      validator: validatorFunction,
      onSaved: onSavedFunction,
      obscureText:visible??false ,
      decoration: InputDecoration(
        alignLabelWithHint: true,
        // labelText: hint,
        prefixIcon: prefIcon,
        suffixIcon: suffixIcon,
        contentPadding: const EdgeInsets.symmetric(
            vertical: 12, horizontal: 20),
        filled: true,
        fillColor: Colors.blue.withOpacity(0.2),
        hintText: hint,
        border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.circular(40)),
      ),
    );
  }
}
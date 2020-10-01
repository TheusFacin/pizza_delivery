import 'package:flutter/material.dart';

class PizzaDeliveryInput extends TextFormField {
  PizzaDeliveryInput(
    label, {
    TextEditingController controller,
    TextInputType keyboardType,
    FormFieldValidator validator,
    Icon suffixIcon,
    Function suffixIconOnPressed,
    obscureText = false,
  }) : super(
          keyboardType: keyboardType,
          validator: validator,
          controller: controller,
          obscureText: obscureText,
          style: TextStyle(fontSize: 18),
          decoration: InputDecoration(
            labelStyle: TextStyle(fontSize: 16),
            labelText: label,
            suffixIcon: suffixIcon != null
                ? IconButton(
                    icon: suffixIcon,
                    onPressed: suffixIconOnPressed,
                  )
                : null,
          ),
        );
}

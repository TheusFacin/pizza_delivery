import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class PizzaDeliveryButton extends Container {
  PizzaDeliveryButton(
    String label, {
    @required double width,
    @required double height,
    Color labelColor = Colors.white,
    double labelSize = 18,
    TextStyle textStyle,
    ShapeBorder shape,
    Color buttonColor,
    @required Function onPressed,
  }) : super(
          width: width,
          height: height,
          child: RaisedButton(
            onPressed: onPressed,
            color: buttonColor,
            child: Text(label,
                style: textStyle ??
                    TextStyle(fontSize: labelSize, color: labelColor)),
            shape: shape ??
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
          ),
        );
}

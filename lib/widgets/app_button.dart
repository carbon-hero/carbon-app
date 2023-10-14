import 'package:flutter/material.dart';
import 'package:flutter_lifestyle/helper/dimens.dart';
import 'package:flutter_lifestyle/helper/strings.dart';

import '../helper/colors.dart';

class AppButton extends StatelessWidget {
  final String label;
  final Function() onPressed;
  final Color? backgroundColor;
  final Color? borderColor;
  final double? borderRadius;
  final double? height;
  final double? width;
  final EdgeInsetsGeometry? margin;
  final EdgeInsetsGeometry? padding;
  final Color? textColor;
  final double? textSize;
  final Widget? suffixIcon;
  final bool isUppercase;

  const AppButton(
      {Key? key,
      required this.label,
      required this.onPressed,
      this.backgroundColor = primaryColor,
      this.borderColor = primaryColor,
      this.borderRadius = 7,
      this.height = 50,
      this.width,
      this.margin,
      this.padding,
      this.textColor = white,
      this.textSize = 13,
      this.suffixIcon,
      this.isUppercase = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: margin,
      padding: padding,
      height: height,
      width: width ?? MediaQuery.of(context).size.width,
      child: OutlinedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          foregroundColor: white,
          backgroundColor: backgroundColor,
          disabledBackgroundColor: Colors.grey.withOpacity(0.4),
          textStyle: TextStyle(color: textColor, fontWeight: FontWeight.bold),
          side: BorderSide(color: borderColor!, style: BorderStyle.solid),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(borderRadius!),
          ),
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              label,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: textColor,
                  fontSize: textSize,
                  fontFamily: Fonts.regular),
            ),
            if (suffixIcon != null)
              Padding(
                padding: EdgeInsets.only(left: Dimens.dimen_4),
                child: suffixIcon!,
              ),
          ],
        ),
      ),
    );
  }
}

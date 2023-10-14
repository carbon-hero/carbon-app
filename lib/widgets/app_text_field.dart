import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_lifestyle/helper/colors.dart';
import 'package:flutter_lifestyle/helper/dimens.dart';
import 'package:flutter_lifestyle/helper/strings.dart';

class BoxTextField extends StatefulWidget {
  final String? labelText;
  final String? hintText;
  final bool? obscureText;
  final TextInputType? keyboardType;
  final ValueChanged<String>? onChanged;
  final FormFieldValidator? validator;
  final Function()? onTap;
  final Widget? prefix;
  final Widget? suffix;
  final bool? read;
  final bool? dense;
  final bool filled;
  final TextEditingController? controller;
  final String? alert;
  final int? maxLines;
  final List<TextInputFormatter>? inputFormatters;
  final EdgeInsets? padding;
  final EdgeInsets? contentPadding;
  final bool? isRequired;
  final String? prefixText;
  final Color? filledColor;

  BoxTextField(
      {this.labelText,
      this.hintText,
      this.obscureText,
      this.keyboardType,
      this.prefix,
      this.suffix,
      this.read,
      this.dense,
      this.filled = false,
      this.onChanged,
      this.validator,
      this.onTap,
      @required this.controller,
      this.inputFormatters,
      this.maxLines,
      this.alert,
      this.padding = EdgeInsets.zero,
      this.contentPadding =
          const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
      this.isRequired = false,
      this.prefixText,
      this.filledColor = Colors.transparent});

  @override
  State<BoxTextField> createState() => _BoxTextFieldState();
}

class _BoxTextFieldState extends State<BoxTextField> {
  @override
  Widget build(BuildContext context) {
    return Theme(
      data: ThemeData(
        primaryColor: primaryColor,
        hintColor: hintTextColor,
        fontFamily: Fonts.medium,
      ),
      child: Padding(
        padding: widget.padding!,
        child: TextFormField(
          inputFormatters: widget.inputFormatters ?? [],
          autofocus: false,
          maxLines: widget.maxLines ?? 1,
          controller: widget.controller,
          onTap: widget.onTap,
          style: TextStyle(
              color: textColor,
              fontFamily: Fonts.medium,
              fontSize: Dimens.fontSize_14),
          decoration: InputDecoration(
            prefixIcon: widget.prefix,
            filled: widget.filled,
            fillColor: widget.filledColor,
            contentPadding: EdgeInsets.all(Dimens.padding_16),
            prefixText: widget.prefixText,
            hintText: widget.hintText,
            errorMaxLines: 4,
            suffixIcon: widget.suffix,
            isDense: widget.dense ?? true,
            hintStyle:
                TextStyle(color: hintTextColor, fontSize: Dimens.fontSize_14),
            focusedBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimens.radius_7),
              borderSide: BorderSide(
                  width: 1,
                  color: widget.filled ? Colors.transparent : primaryColor),
            ),
            errorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimens.radius_7),
              borderSide: BorderSide(
                  width: 1,
                  color: widget.filled ? Colors.transparent : Colors.red),
            ),
            focusedErrorBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimens.radius_7),
              borderSide: BorderSide(
                  width: 1,
                  color: widget.filled ? Colors.transparent : Colors.red),
            ),
            enabledBorder: OutlineInputBorder(
              borderRadius: BorderRadius.circular(Dimens.radius_7),
              borderSide: BorderSide(
                  width: 1,
                  color: widget.filled
                      ? Colors.transparent
                      : inactiveColor.withOpacity(0.4)),
            ),
          ),
          obscureText: widget.obscureText ?? false,
          readOnly: widget.read ?? false,
          keyboardType: widget.keyboardType ?? TextInputType.text,
          cursorColor: primaryColor,
          onChanged: widget.onChanged ?? (val) {},
          validator: widget.alert == null
              ? widget.validator
              : (val) => val!.isEmpty ? widget.alert : null,
          autovalidateMode: widget.alert == null
              ? AutovalidateMode.onUserInteraction
              : AutovalidateMode.disabled,
        ),
      ),
    );
  }
}

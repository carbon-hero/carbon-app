
import 'package:flutter/material.dart';
import 'package:flutter_lifestyle/helper/dimens.dart';
import 'package:flutter_lifestyle/helper/strings.dart';
import 'package:flutter_svg/svg.dart';


import '../helper/colors.dart';

class BackAppBar extends StatelessWidget {
  final String label;
  final Function()? onPressed;
  final Widget? trailing;
  final bool? isBack;

  const BackAppBar(
      {Key? key,
      required this.label,
      this.onPressed,
      this.trailing,
      this.isBack = true})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      left: false,
      top: true,
      right: false,
      bottom: false,
      child: Container(
        color:  white,
        height: Dimens.height_70,
        padding: EdgeInsets.only(
            top: Dimens.padding_20,
            left: Dimens.padding_12,
            right: Dimens.padding_12),
        child: Row(
          children: [
            InkWell(
              onTap: onPressed ??
                      () {
                    Navigator.pop(context);
                  },
              child: Container(
                height: Dimens.height_35,
                width: Dimens.width_35,
                padding: const EdgeInsets.all(8.0),
                child: SvgPicture.asset(
                  Images.back,
                  color: textColor,
                ),
              ),
            ),
            SizedBox(
              width: Dimens.width_5,
            ),
            Text(
              label,
              style: TextStyle(
                  fontSize: Dimens.fontSize_16,
                  color: textColor,
                  fontFamily: Fonts.medium),
            ),
          ],
        ),
      ),
    );
  }
}

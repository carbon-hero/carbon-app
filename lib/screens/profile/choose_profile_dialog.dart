import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_lifestyle/helper/colors.dart';
import 'package:flutter_lifestyle/helper/dimens.dart';
import 'package:flutter_lifestyle/helper/navigation.dart';
import 'package:flutter_lifestyle/helper/strings.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';

class ChooseProfileDialog extends StatefulWidget {
  Function(File file) onTap;

  ChooseProfileDialog(this.onTap);

  @override
  State<ChooseProfileDialog> createState() => _ChooseProfileDialogState();
}

class _ChooseProfileDialogState extends State<ChooseProfileDialog> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: Dimens.height_230,
      child: Column(
        children: [
          SizedBox(height: Dimens.height_20,),
          Container(
            height: Dimens.height_5,
            width: Dimens.width_80,
            decoration: BoxDecoration(
                color: inactiveColor,
                borderRadius: BorderRadius.circular(Dimens.radius_10)),
          ),
          SizedBox(height: Dimens.height_20,),
          Text(
            Constants.editProfilePicture,
            style: TextStyle(
                color: textColor,
                fontFamily: Fonts.bold,
                fontSize: Dimens.fontSize_24),
          ),
          SizedBox(height: Dimens.height_20,),
          containerTile(
            icon: Images.gallery,
            title: Constants.choosePhoto,
            onTap: (){
              getImage(ImageSource.gallery);
            }
          ),
          containerTile(
              icon: Images.camera,
              title: Constants.takePhoto,
              onTap: (){
                getImage(ImageSource.camera);
              }
          )
        ],
      ),
    );
  }

  containerTile(
      {required String icon,
      required String title,
      required Function() onTap}) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: Dimens.padding_20,vertical: Dimens.padding_15),
        child: Row(
          children: [
            SvgPicture.asset(icon,color: accentColor,),
            SizedBox(width: Dimens.width_15,),
            Text(
              title,
              style: TextStyle(
                  color: textColor,
                  fontFamily: Fonts.regular,
                  fontSize: Dimens.fontSize_14),
            )
          ],
        ),
      ),
    );
  }

  getImage(ImageSource imageSource) async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: imageSource);
    widget.onTap(File(image!.path));
    Navigator.pop(NavigationService.context);
  }


}

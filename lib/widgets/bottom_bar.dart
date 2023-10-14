import 'package:flutter/material.dart';
import 'package:flutter_lifestyle/helper/dimens.dart';
import 'package:flutter_lifestyle/helper/strings.dart';
import 'package:flutter_svg/flutter_svg.dart';

import '../helper/colors.dart';

class BottomBar extends StatefulWidget {
  int selectedIndex;
  Function(int val) onChange;

  BottomBar({required this.selectedIndex, required this.onChange});

  @override
  State<BottomBar> createState() => _BottomBarState();
}

class _BottomBarState extends State<BottomBar> {
  @override
  Widget build(BuildContext context) {
    return BottomAppBar(
      color: white,
      height: Dimens.height_80,
      child: SizedBox(
        height: Dimens.height_80,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            imageTile(
              image: Images.commute,
              selectedImage: Images.commuteSelect,
              index: 0,
              title: Constants.commute,
            ),
            imageTile(
                image: Images.carbonOffset,
                selectedImage: Images.carbonOffsetSelect,
                index: 1,
                title: Constants.carbonOffset),
            imageTile(
              image: Images.points,
              index: 2,
              title: Constants.points,
              selectedImage: Images.pointsSelect,
            ),
            imageTile(
              image: Images.profile,
              index: 3,
              title: Constants.profile,
              selectedImage: Images.profileSelect,
            ),
          ],
        ),
      ),
    );
  }

  imageTile({
    required String image,
    required String selectedImage,
    required String title,
    required int index,
  }) {
    return Expanded(
      child: InkWell(
        onTap: () {
          setState(() {
            widget.onChange(index);
          });
        },
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              height: Dimens.height_35,
              width: Dimens.width_35,
              padding: EdgeInsets.all(Dimens.padding_7),
              decoration: BoxDecoration(
                  color: widget.selectedIndex == index
                      ? bottomBarSelect.withOpacity(0.5)
                      : Colors.transparent,
                  borderRadius: BorderRadius.circular(Dimens.radius_10)),
              child: SvgPicture.asset(
                widget.selectedIndex == index ? selectedImage : image,
              ),
            ),
            SizedBox(
              height: Dimens.height_5,
            ),
            FittedBox(
              child: Text(
                title,
                maxLines: 1,
                style: TextStyle(
                    color: widget.selectedIndex == index
                        ? textColor
                        : bottomBarInactive,
                    fontFamily: widget.selectedIndex == index
                        ? Fonts.bold
                        : Fonts.semiBold,
                    fontSize: Dimens.fontSize_12),
              ),
            )
          ],
        ),
      ),
    );
  }
}

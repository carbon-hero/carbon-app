import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lifestyle/helper/colors.dart';
import 'package:flutter_lifestyle/helper/dimens.dart';
import 'package:flutter_lifestyle/helper/navigation.dart';
import 'package:flutter_lifestyle/helper/strings.dart';
import 'package:flutter_lifestyle/provider/user_provider.dart';
import 'package:flutter_lifestyle/screens/main/carbon_offset_page.dart';
import 'package:flutter_lifestyle/screens/main/commute_page.dart';
import 'package:flutter_lifestyle/screens/main/points_page.dart';
import 'package:flutter_lifestyle/screens/main/profile_page.dart';
import 'package:flutter_lifestyle/widgets/bottom_bar.dart';
import 'package:flutter_lifestyle/widgets/drawer.dart';
import 'package:flutter_lifestyle/widgets/loading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class MainScreen extends StatefulWidget {
  @override
  State<MainScreen> createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  GlobalKey<ScaffoldState> drawerKey = GlobalKey<ScaffoldState>();

  int selectedIndex = 0;

  List<String> titleList = [
    Constants.commute,
    Constants.carbonOffset,
    Constants.points,
    Constants.profile
  ];

  List pageList = [
    CommutePage(),
    CarbonOffsetPage(),
    PointsPage(),
    ProfilePage(),
  ];

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      getUserStore(context).getPoints();
      getUserStore(context).getTravelMode();
      getContact();
    });
  }

  void _handleInvalidPermissions(PermissionStatus permissionStatus) {
    if (permissionStatus == PermissionStatus.denied) {
      const snackBar = SnackBar(content: Text('Access to contact data denied'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    } else if (permissionStatus == PermissionStatus.permanentlyDenied) {
      const snackBar =
      SnackBar(content: Text('Contact data not available on device'));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }
  }

  Future<PermissionStatus> _getContactPermission() async {
    PermissionStatus permission = await Permission.contacts.status;
    if (permission != PermissionStatus.granted &&
        permission != PermissionStatus.permanentlyDenied) {
      PermissionStatus permissionStatus = await Permission.contacts.request();
      return permissionStatus;
    } else {
      return permission;
    }
  }

  Future getContact() async {
    PermissionStatus permissionStatus = await _getContactPermission();
    if (permissionStatus == PermissionStatus.granted) {
      getUserStore(NavigationService.context).getContacts();
    } else {
      _handleInvalidPermissions(permissionStatus);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: drawerKey,
      backgroundColor: selectedIndex == 3 ? textColor : white,
      drawer: AppDrawer(
        onTap: (val){
          if(val == 0){
            setState(() {
              selectedIndex = 2;
            });
          }else if(val == 1){
            setState(() {
              selectedIndex = 3;
            });
          }
        },
      ),
      bottomNavigationBar: BottomBar(
        selectedIndex: selectedIndex,
        onChange: (val) {
          setState(() {
            selectedIndex = val;
          });
        },
      ),
      body: Consumer<UserProvider>(builder: (context, userStore, snapshot) {
        return Stack(
          children: [
            if (selectedIndex == 3)
              Align(
                alignment: Alignment.topCenter,
                child: userStore.user!.fullFileUrl.isNotEmpty
                    ? CachedNetworkImage(
                        imageUrl: userStore.user!.fullFileUrl,
                        width: 250,
                        height: 250,
                        fit: BoxFit.cover,
                      )
                    : Image.asset(
                        Images.profileDp,
                        width: 250,
                        height: 250,
                        fit: BoxFit.cover,
                      ),
              ),
            if (selectedIndex == 3)
              Positioned.fill(
                child: BackdropFilter(
                  filter: ImageFilter.blur(
                    sigmaX: 15.0,
                    sigmaY: 15.0,
                  ),
                  child: Container(
                    width: double.infinity,
                    height: MediaQuery.of(context).size.width,
                    color: textColor.withOpacity(0.2),
                  ),
                ),
              ),
            SafeArea(
              child: Column(
                children: [
                  Container(
                    color: selectedIndex == 3 ? Colors.transparent : white,
                    height: Dimens.height_70,
                    padding: EdgeInsets.only(
                        top: Dimens.padding_20,
                        left: Dimens.padding_12,
                        right: Dimens.padding_12),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            drawerKey.currentState!.openDrawer();
                          },
                          child: Container(
                            height: Dimens.height_35,
                            width: Dimens.width_35,
                            padding: const EdgeInsets.all(8.0),
                            child: SvgPicture.asset(
                              Images.menu,
                              color: selectedIndex == 3 ? white : textColor,
                            ),
                          ),
                        ),
                        SizedBox(
                          width: Dimens.width_5,
                        ),
                        Text(
                          titleList[selectedIndex],
                          style: TextStyle(
                              fontSize: Dimens.fontSize_16,
                              color: selectedIndex == 3 ? white : textColor,
                              fontFamily: Fonts.medium),
                        ),
                        const Expanded(child: SizedBox()),
                        // InkWell(
                        //   onTap: () {},
                        //   child: Container(
                        //     height: Dimens.height_35,
                        //     width: Dimens.width_35,
                        //     padding: const EdgeInsets.all(8.0),
                        //     child: SvgPicture.asset(
                        //       Images.settings,
                        //       color: selectedIndex == 3 ? white : textColor,
                        //     ),
                        //   ),
                        // ),
                        // InkWell(
                        //   onTap: () {},
                        //   child: Container(
                        //     height: Dimens.height_35,
                        //     width: Dimens.width_35,
                        //     padding: const EdgeInsets.all(8.0),
                        //     child: SvgPicture.asset(
                        //       Images.notification,
                        //       color: selectedIndex == 3 ? white : textColor,
                        //     ),
                        //   ),
                        // ),
                      ],
                    ),
                  ),
                  Expanded(child: pageList[selectedIndex])
                ],
              ),
            ),
            LoadingWithBackground(userStore.isLoading)
          ],
        );
      }),
    );
  }
}

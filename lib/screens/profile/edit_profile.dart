import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lifestyle/helper/app_dialog.dart';
import 'package:flutter_lifestyle/helper/colors.dart';
import 'package:flutter_lifestyle/helper/dimens.dart';
import 'package:flutter_lifestyle/helper/navigation.dart';
import 'package:flutter_lifestyle/helper/routes.dart';
import 'package:flutter_lifestyle/helper/strings.dart';
import 'package:flutter_lifestyle/models/user.dart';
import 'package:flutter_lifestyle/provider/location_provider.dart';
import 'package:flutter_lifestyle/provider/user_provider.dart';
import 'package:flutter_lifestyle/widgets/app_bar.dart';
import 'package:flutter_lifestyle/widgets/app_button.dart';
import 'package:flutter_lifestyle/widgets/app_text_field.dart';
import 'package:flutter_lifestyle/widgets/loading.dart';
import 'package:flutter_lifestyle/widgets/shimmer.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  State<EditProfileScreen> createState() => _EditProfileScreenState();
}

class _EditProfileScreenState extends State<EditProfileScreen> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController homeController = TextEditingController();
  TextEditingController officeController = TextEditingController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      var userStore = getUserStore(context);
      firstNameController.text = userStore.user!.firstName;
      lastNameController.text = userStore.user!.lastName;
      homeController.text = userStore.user!.homeAddress;
      officeController.text = userStore.user!.officeAddress;
    });
  }

  File? selectedFile;

  @override
  Widget build(BuildContext context) {
    final profileKey = GlobalKey<FormState>();

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: white,
      body: Consumer2<UserProvider,LocationProvider>(builder: (context, userStore,locationStore, snapshot) {
        return Stack(
          children: [
            Column(
              children: [
                const BackAppBar(label: Constants.editProfile),
                SizedBox(
                  height: Dimens.height_50,
                ),
                InkWell(
                  borderRadius: BorderRadius.circular(Dimens.radius_100),
                  onTap: () {
                    AppDialog.chooseProfileDialog(
                      context: context,
                      onTap: (file) {
                        setState(() {
                          selectedFile = file;
                        });
                      },
                    );
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      boxShadow: [
                        BoxShadow(
                            color: Colors.grey.shade200,
                            spreadRadius: 5,
                            blurRadius: 15,
                            offset: const Offset(-5, 15))
                      ],
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(Dimens.radius_100),
                      child: selectedFile != null
                          ? Image.file(
                              selectedFile!,
                              height: Dimens.height_100,
                              width: Dimens.width_100,
                              fit: BoxFit.cover,
                            )
                          : userStore.user!.fullFileUrl.isNotEmpty
                              ? CachedNetworkImage(
                                  imageUrl: userStore.user!.fullFileUrl,
                                  height: Dimens.height_100,
                                  width: Dimens.width_100,
                                  fit: BoxFit.cover,
                                  progressIndicatorBuilder:
                                      (context, url, downloadProgress) =>
                                          Shimmer.fromColors(
                                    baseColor: Colors.grey.shade300,
                                    highlightColor: Colors.grey.shade100,
                                    enabled: true,
                                    child: Container(
                                      height: Dimens.height_100,
                                      width: Dimens.width_100,
                                      decoration: BoxDecoration(
                                          color: Colors.white,
                                          borderRadius:
                                              BorderRadius.circular(10)),
                                    ),
                                  ),
                                  errorWidget: (context, url, error) =>
                                      Image.asset(
                                    Images.profileDp,
                                    height: Dimens.height_100,
                                    width: Dimens.width_100,
                                  ),
                                )
                              : Image.asset(
                                  Images.profileDp,
                                  height: Dimens.height_100,
                                  width: Dimens.width_100,
                                ),
                    ),
                  ),
                ),
                SizedBox(
                  height: Dimens.height_30,
                ),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: Dimens.padding_20),
                  child: Form(
                    key: profileKey,
                    child: Column(
                      children: [
                        BoxTextField(
                          controller: firstNameController,
                          hintText: Constants.firstName,
                          validator: (val) {
                            if (val.toString().isEmpty) {
                              return "First Name is required!";
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(
                          height: Dimens.height_20,
                        ),
                        BoxTextField(
                          controller: lastNameController,
                          hintText: Constants.lastName,
                          validator: (val) {
                            if (val.toString().isEmpty) {
                              return "Last Name is required!";
                            } else {
                              return null;
                            }
                          },
                        ),
                        SizedBox(
                          height: Dimens.height_20,
                        ),
                        BoxTextField(
                          controller: homeController,
                          hintText: Constants.homeLocation,
                          read: true,
                          validator: (val) {
                            if (val.toString().isEmpty) {
                              return "Home Address is required!";
                            } else {
                              return null;
                            }
                          },
                          onTap: () {
                            NavigationService.navigateTo(Routes.searchLocation,
                                arguments: true)
                                .then((value) {
                              homeController.text = locationStore.homeLocation!.address;
                            });
                          },
                          suffix: Padding(
                            padding: EdgeInsets.all(Dimens.padding_15),
                            child: SvgPicture.asset(Images.pin),
                          ),
                        ),
                        SizedBox(
                          height: Dimens.height_20,
                        ),
                        BoxTextField(
                          controller: officeController,
                          hintText: Constants.officeLocation,
                          read: true,
                          validator: (val) {
                            if (val.toString().isEmpty) {
                              return "Office Address is required!";
                            } else {
                              return null;
                            }
                          },
                          onTap: () {
                            NavigationService.navigateTo(Routes.searchLocation,
                                    arguments: false)
                                .then((value) {
                              officeController.text = locationStore.officeLocation!.address;
                            });
                          },
                          suffix: Padding(
                            padding: EdgeInsets.all(Dimens.padding_15),
                            child: SvgPicture.asset(Images.pin),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
                const Expanded(child: SizedBox()),
                Padding(
                  padding: EdgeInsets.all(Dimens.padding_30),
                  child: Row(
                    children: [
                      Expanded(
                        child: AppButton(
                          label: Constants.cancel,
                          backgroundColor: Colors.transparent,
                          borderColor: textColor,
                          textColor: textColor,
                          onPressed: () {
                            Navigator.pop(context);
                          },
                        ),
                      ),
                      SizedBox(
                        width: Dimens.width_20,
                      ),
                      Expanded(
                        child: AppButton(
                          label: Constants.save,
                          onPressed: () async {
                            if (profileKey.currentState!.validate()) {
                              if (selectedFile != null) {
                                await userStore.saveFile(
                                    "image", selectedFile!);
                              }

                              String homeAddress = homeController.text.trim();
                              String officeAddress = officeController.text.trim();

                              User user = userStore.user!;
                              Map<String, dynamic> params = {
                                "Id": user.id,
                                "firstName": firstNameController.text.trim(),
                                "lastName": lastNameController.text.trim(),
                                "homeAddress": homeAddress,
                                "homeLat": homeAddress.isEmpty ? 0 : locationStore.homeLocation!.latlng.latitude,
                                "homeLong": homeAddress.isEmpty ? 0 : locationStore.homeLocation!.latlng.longitude,
                                "officeAddress": officeAddress,
                                "officeLat": officeAddress.isEmpty ? 0 : locationStore.officeLocation!.latlng.latitude,
                                "officeLong":  officeAddress.isEmpty ? 0 : locationStore.officeLocation!.latlng.longitude,
                                "profilePicId": userStore.profileID.isEmpty
                                    ? user.profilePicId
                                    : userStore.profileID,
                                "email": user.email,
                                "password": user.password,
                                "phoneNumber": user.phoneNumber
                              };
                              await userStore.saveUser(params);
                            }
                          },
                        ),
                      )
                    ],
                  ),
                )
              ],
            ),
            LoadingWithBackground(userStore.isLoading)
          ],
        );
      }),
    );
  }
}

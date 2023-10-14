import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lifestyle/helper/colors.dart';
import 'package:flutter_lifestyle/helper/dimens.dart';
import 'package:flutter_lifestyle/helper/navigation.dart';
import 'package:flutter_lifestyle/helper/routes.dart';
import 'package:flutter_lifestyle/helper/snakbar.dart';
import 'package:flutter_lifestyle/helper/strings.dart';
import 'package:flutter_lifestyle/provider/user_provider.dart';
import 'package:flutter_lifestyle/widgets/app_bar.dart';
import 'package:flutter_lifestyle/widgets/app_button.dart';
import 'package:flutter_lifestyle/widgets/app_text_field.dart';
import 'package:flutter_lifestyle/widgets/loading.dart';
import 'package:provider/provider.dart';

class StartJourneyScreen extends StatefulWidget {
  @override
  State<StartJourneyScreen> createState() => _StartJourneyScreenState();
}

class _StartJourneyScreenState extends State<StartJourneyScreen> {
  int selectedTravelIndex = 0;
  int selectedTravelTypeIndex = 0;

  TextEditingController selectFriendController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: white,
      body: Consumer<UserProvider>(builder: (context, userStore, snapshot) {
        List<Contact> allList = userStore.selectedContactList();
        return Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const BackAppBar(label: Constants.travelDetails),
                SizedBox(
                  height: Dimens.height_20,
                ),
                Expanded(
                  child: SingleChildScrollView(
                    physics: const BouncingScrollPhysics(),
                    child: Padding(
                      padding: EdgeInsets.symmetric(horizontal: Dimens.padding_20),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            Constants.selectTravelMode,
                            style: TextStyle(
                                fontSize: Dimens.fontSize_16,
                                fontFamily: Fonts.bold,
                                color: textColor),
                          ),
                          SizedBox(
                            height: Dimens.height_15,
                          ),
                          SizedBox(
                            height: Dimens.height_45,
                            child: SingleChildScrollView(
                              scrollDirection : Axis.horizontal,
                              child: Row(
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: List.generate(
                                  userStore.travelModeList.length,
                                  (i) => GestureDetector(
                                    onTap: () {
                                      setState(() {
                                        selectedTravelIndex = i;
                                      });
                                    },
                                    child: Container(
                                      margin:
                                          EdgeInsets.only(right: Dimens.margin_10),
                                      height: double.infinity,
                                      padding: EdgeInsets.symmetric(
                                          horizontal: Dimens.padding_30),
                                      decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(Dimens.radius_7),
                                          color: accentColor.withOpacity(
                                              selectedTravelIndex == i ? 1 : 0.05)),
                                      child: Center(
                                        child: Text(
                                          userStore.travelModeList[i].value,
                                          style: TextStyle(
                                            color: selectedTravelIndex == i
                                                ? white
                                                : textColor,
                                            fontSize: Dimens.fontSize_14,
                                            fontFamily: Fonts.regular,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: Dimens.height_40,
                          ),
                          Text(
                            Constants.selectTravelType,
                            style: TextStyle(
                                fontSize: Dimens.fontSize_16,
                                fontFamily: Fonts.bold,
                                color: textColor),
                          ),
                          SizedBox(
                            height: Dimens.height_15,
                          ),
                          SizedBox(
                            height: Dimens.height_45,
                            child: Row(
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: List.generate(
                                userStore.travelTypeList.length,
                                (i) => GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      selectedTravelTypeIndex = i;
                                    });
                                  },
                                  child: Container(
                                    margin:
                                        EdgeInsets.only(right: Dimens.margin_10),
                                    height: double.infinity,
                                    padding: EdgeInsets.symmetric(
                                        horizontal: Dimens.padding_30),
                                    decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(Dimens.radius_7),
                                        color: accentColor.withOpacity(
                                            selectedTravelTypeIndex == i
                                                ? 1
                                                : 0.05)),
                                    child: Center(
                                      child: Text(
                                        userStore.travelTypeList[i].value,
                                        style: TextStyle(
                                          color: selectedTravelTypeIndex == i
                                              ? white
                                              : textColor,
                                          fontSize: Dimens.fontSize_14,
                                          fontFamily: Fonts.regular,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ),
                          SizedBox(
                            height: Dimens.height_30,
                          ),
                          if (selectedTravelTypeIndex != 0)
                            Column(
                              children: [
                                BoxTextField(
                                  controller: selectFriendController,
                                  hintText: Constants.selectFriend,
                                  read: true,
                                  onTap: () {
                                    NavigationService.navigateTo(
                                        Routes.contactList);
                                  },
                                ),
                                ListView.separated(
                                    shrinkWrap: true,
                                    physics: const NeverScrollableScrollPhysics(),
                                    itemBuilder: (context, index) {
                                      Contact contact = allList[index];
                                      return Container(
                                        padding: EdgeInsets.all(Dimens.padding_10),
                                        decoration: BoxDecoration(
                                            color: textColor.withOpacity(0.04),
                                            borderRadius: BorderRadius.circular(
                                                Dimens.radius_7)),
                                        child: Row(
                                          children: [
                                            Container(
                                              height: Dimens.height_35,
                                              width: Dimens.width_35,
                                              margin: EdgeInsets.only(
                                                  right: Dimens.margin_10),
                                              decoration: const BoxDecoration(
                                                shape: BoxShape.circle,
                                                color: accentColor,
                                              ),
                                              child: Center(
                                                child: Text(
                                                  getTitle(
                                                      contact.displayName ?? ""),
                                                  style: TextStyle(
                                                      color: white,
                                                      fontSize: Dimens.fontSize_14,
                                                      fontFamily: Fonts.regular),
                                                ),
                                              ),
                                            ),
                                            Text(
                                              contact.displayName ?? "",
                                              style: TextStyle(
                                                  color: textColor,
                                                  fontFamily: Fonts.regular,
                                                  fontSize: Dimens.fontSize_14),
                                            ),
                                            const Expanded(child: SizedBox()),
                                            InkWell(
                                              onTap: () {
                                                int index = userStore.contacts
                                                    .indexOf(contact);
                                                userStore.removeContact(index);
                                              },
                                              child: const Icon(
                                                Icons.highlight_remove_sharp,
                                                color: textColor,
                                              ),
                                            )
                                          ],
                                        ),
                                      );
                                    },
                                    separatorBuilder: (context, index) {
                                      return SizedBox(
                                        height: Dimens.height_15,
                                      );
                                    },
                                    itemCount: allList.length),
                              ],
                            ),
                          SizedBox(
                            height: Dimens.height_20,
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(Dimens.padding_20),
                  child: AppButton(
                    label: Constants.next,
                    borderColor: textColor,
                    textColor: textColor,
                    backgroundColor: Colors.transparent,
                    onPressed: () {
                      if(selectedTravelTypeIndex == 1){
                        if(allList.isEmpty){
                          AlertSnackBar.error("Please add friends!");
                          return;
                        }
                      }

                      if(selectedTravelTypeIndex != 0 && allList.isNotEmpty){
                        userStore.clearFriendList();
                        for (var element in allList) {
                          String? firstName = element.displayName!.contains(" ")
                              ? element.displayName!.split(" ").first
                              : element.displayName;
                          String? lastName = element.displayName!.contains(" ")
                              ? element.displayName!.split(" ").last
                              : element.displayName;
                          Map<String, dynamic> params = {
                            "firstName": firstName ?? "",
                            "lastName": lastName,
                            "email": element.phones!.first.value,
                            "phoneNumber": element.phones!.first.value
                          };
                          print(element.phones!.first.value);
                          userStore.addFriend(params);
                        }
                      }

                      userStore.travelMode = userStore.travelModeList[selectedTravelIndex];
                      userStore.travelType = userStore.travelTypeList[selectedTravelTypeIndex];
                      NavigationService.navigateTo(Routes.selectLocation);
                    },
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

  getTitle(String value) {
    if (value.isEmpty) {
      return "";
    } else {
      if (value.contains(" ")) {
        String first = value.split(" ").first;
        String last = value.split(" ").last;
        return "${first[0]}${last[0]}";
      } else {
        return value[0];
      }
    }
  }
}

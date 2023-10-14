import 'package:contacts_service/contacts_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_lifestyle/helper/colors.dart';
import 'package:flutter_lifestyle/helper/dimens.dart';
import 'package:flutter_lifestyle/helper/navigation.dart';
import 'package:flutter_lifestyle/helper/strings.dart';
import 'package:flutter_lifestyle/provider/user_provider.dart';
import 'package:flutter_lifestyle/widgets/app_bar.dart';
import 'package:flutter_lifestyle/widgets/app_button.dart';
import 'package:flutter_lifestyle/widgets/loading.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:provider/provider.dart';

class ContactListScreen extends StatefulWidget {

  @override
  State<ContactListScreen> createState() => _ContactListScreenState();
}

class _ContactListScreenState extends State<ContactListScreen> {

  bool permissionDenied = false;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) async {
      refreshList(false);
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

  Future refreshList(bool isRefresh) async {
    var userStore = getUserStore(context);
    PermissionStatus permissionStatus = await _getContactPermission();
    if (permissionStatus == PermissionStatus.granted) {
      if(isRefresh){
        getUserStore(NavigationService.context).getContacts();
      }else{
        if(userStore.contacts.isEmpty){
          getUserStore(NavigationService.context).getContacts();
        }
      }
    } else {
      _handleInvalidPermissions(permissionStatus);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: white,
      body: Consumer<UserProvider>(builder: (context, userStore, snapshot) {
        return Stack(
          children: [
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const BackAppBar(label: Constants.contactList),
                SizedBox(
                  height: Dimens.height_20,
                ),
                Expanded(
                  child: RefreshIndicator(
                    onRefresh: () async {
                      refreshList(true);
                    },
                    child: ListView.separated(
                        physics: const BouncingScrollPhysics(),
                        padding: EdgeInsets.symmetric(
                          horizontal: Dimens.padding_20,
                        ),
                        itemBuilder: (context, index) {
                          Contact contact = userStore.contacts[index];
                          return InkWell(
                            onTap: () {
                              if (userStore.selectedIndexList.contains(index)) {
                                userStore.removeContact(index);
                              } else {
                                userStore.addContact(index);
                              }
                            },
                            child: Container(
                              padding: EdgeInsets.all(Dimens.padding_10),
                              decoration: BoxDecoration(
                                  color: textColor.withOpacity(0.05),
                                  borderRadius:
                                      BorderRadius.circular(Dimens.radius_7)),
                              child: Row(
                                children: [
                                  Container(
                                    height: Dimens.height_35,
                                    width: Dimens.width_35,
                                    margin:
                                        EdgeInsets.only(right: Dimens.margin_10),
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: accentColor,
                                    ),
                                    child: Center(
                                      child: Text(
                                        getTitle(contact.displayName ?? ""),
                                        style: TextStyle(
                                            color: white,
                                            fontSize: Dimens.fontSize_14,
                                            fontFamily: Fonts.regular),
                                      ),
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      contact.displayName ?? "",
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(
                                          color: textColor,
                                          fontFamily: Fonts.regular,
                                          fontSize: Dimens.fontSize_14),

                                    ),
                                  ),
                                  const Expanded(child: SizedBox()),
                                  if (userStore.selectedIndexList.contains(index))
                                    const Icon(
                                      Icons.check_circle,
                                      color: primaryColor,
                                    )
                                ],
                              ),
                            ),
                          );
                        },
                        separatorBuilder: (context, index) {
                          return SizedBox(
                            height: Dimens.height_15,
                          );
                        },
                        itemCount: userStore.contacts.length),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(Dimens.padding_20),
                  child: AppButton(
                    label: Constants.continues,
                    borderColor: textColor,
                    textColor: textColor,
                    backgroundColor: Colors.transparent,
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ),
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

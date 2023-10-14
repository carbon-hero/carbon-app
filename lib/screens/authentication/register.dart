import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_lifestyle/helper/colors.dart';
import 'package:flutter_lifestyle/helper/dimens.dart';
import 'package:flutter_lifestyle/helper/strings.dart';
import 'package:flutter_lifestyle/provider/auth_provider.dart';
import 'package:flutter_lifestyle/widgets/app_button.dart';
import 'package:flutter_lifestyle/widgets/app_text_field.dart';
import 'package:flutter_lifestyle/widgets/loading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';

class RegisterScreen extends StatefulWidget {
  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  TextEditingController passwordController = TextEditingController();

  final registerKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Consumer<AuthProvider>(
        builder: (context,authStore, snapshot) {
          return Stack(
            children: [
              Padding(
                padding: EdgeInsets.symmetric(horizontal: Dimens.padding_20),
                child: Form(
                  key: registerKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Expanded(flex: 2, child: SizedBox()),
                      Center(
                        child: Text(
                          Constants.signUp,
                          style: TextStyle(
                              fontSize: Dimens.fontSize_24,
                              color: textColor,
                              fontFamily: Fonts.bold),
                        ),
                      ),
                      SizedBox(
                        height: Dimens.height_10,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: Dimens.padding_20),
                        child: Text(
                          Constants.signInContent,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                              color: textColor,
                              fontSize: Dimens.fontSize_14,
                              fontFamily: Fonts.regular),
                        ),
                      ),
                      SizedBox(
                        height: Dimens.height_30,
                      ),
                      BoxTextField(
                        controller: firstNameController,
                        hintText: Constants.firstName,
                        prefix: Padding(
                          padding: EdgeInsets.all(Dimens.padding_15),
                          child: SvgPicture.asset(Images.user),
                        ),
                        validator: (val) {
                          if (val.toString().isEmpty) {
                            return "First Name is required!";
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: Dimens.height_15,
                      ),
                      BoxTextField(
                        controller: lastNameController,
                        hintText: Constants.lastName,
                        prefix: Padding(
                          padding: EdgeInsets.all(Dimens.padding_15),
                          child: SvgPicture.asset(Images.user),
                        ),
                        validator: (val) {
                          if (val.toString().isEmpty) {
                            return "Last Name is required!";
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: Dimens.height_15,
                      ),
                      BoxTextField(
                        controller: emailController,
                        hintText: Constants.email,
                        prefix: Padding(
                          padding: EdgeInsets.all(Dimens.padding_15),
                          child: SvgPicture.asset(Images.email),
                        ),
                        validator: (val) {
                          if (val.toString().isEmpty) {
                            return "Email is required!";
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: Dimens.height_15,
                      ),
                      BoxTextField(
                        controller: passwordController,
                        hintText: Constants.password,
                        prefix: Padding(
                          padding: EdgeInsets.all(Dimens.padding_15),
                          child: SvgPicture.asset(Images.password),
                        ),
                        validator: (val) {
                          if (val.toString().isEmpty) {
                            return "Password is required!";
                          } else {
                            return null;
                          }
                        },
                      ),
                      SizedBox(
                        height: Dimens.height_40,
                      ),
                      AppButton(
                        label: Constants.createAccount,
                        onPressed: () async {
                          FocusScope.of(context).requestFocus(FocusNode());
                          if (registerKey.currentState!.validate()) {
                            Map<String, dynamic> params = {
                              "firstName": firstNameController.text.trim(),
                              "lastName": lastNameController.text.trim(),
                              "email": emailController.text.trim(),
                              "password": passwordController.text.trim(),
                            };
                            await authStore.register(params);
                          }
                        },
                      ),
                      const Expanded(flex: 6, child: SizedBox()),
                    ],
                  ),
                ),
              ),
              Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding:  EdgeInsets.all(Dimens.padding_20),
                  child: InkWell(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: RichText(
                      text: TextSpan(
                        text: Constants.alreadyAccount,
                        style: TextStyle(
                            color: textColor,
                            fontFamily: Fonts.regular,
                            fontSize: Dimens.fontSize_14),
                        children: [
                          WidgetSpan(
                            child: Text(
                              Constants.signIn,
                              style: TextStyle(
                                  color: primaryColor,
                                  fontFamily: Fonts.bold,
                                  fontSize: Dimens.fontSize_14),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
              LoadingWithBackground(authStore.isLoading)
            ],
          );
        }
      ),
    );
  }
}

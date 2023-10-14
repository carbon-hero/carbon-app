import 'dart:async';

import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_lifestyle/helper/colors.dart';
import 'package:flutter_lifestyle/helper/dimens.dart';
import 'package:flutter_lifestyle/helper/snakbar.dart';
import 'package:flutter_lifestyle/helper/strings.dart';
import 'package:flutter_lifestyle/provider/auth_provider.dart';
import 'package:flutter_lifestyle/widgets/app_button.dart';
import 'package:flutter_lifestyle/widgets/box_pin/models/animation_type.dart';
import 'package:flutter_lifestyle/widgets/box_pin/models/pin_theme.dart';
import 'package:flutter_lifestyle/widgets/box_pin/pin_code_fields.dart';
import 'package:flutter_lifestyle/widgets/loading.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:percent_indicator/percent_indicator.dart';
import 'package:provider/provider.dart';

class OTPVerificationScreen extends StatefulWidget {
  String mobileNumber;

  OTPVerificationScreen(this.mobileNumber);

  @override
  State<OTPVerificationScreen> createState() => _OTPVerificationScreenState();
}

class _OTPVerificationScreenState extends State<OTPVerificationScreen> {
  TextEditingController pinCodeController = TextEditingController();

  bool emailCountdownOver = false;
  Timer? emailTimer;
  int emailStart = 0;

  void startOtpTimer() {
    emailStart = 59;
    const oneSec = Duration(seconds: 1);
    emailTimer = Timer.periodic(
      oneSec,
      (Timer timer) {
        if (emailStart == 0) {
          setState(() {
            emailCountdownOver = true;
            timer.cancel();
          });
        } else {
          setState(() {
            emailCountdownOver = false;
            emailStart--;
          });
        }
      },
    );
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    startOtpTimer();
  }

  @override
  void dispose() {
    try {
      pinCodeController.dispose();
    } catch (e) {
      e.toString();
    }
    if (emailTimer != null) {
      emailTimer!.cancel();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Consumer<AuthProvider>(builder: (context, authStore, snapshot) {
        return Stack(
          children: [
            SafeArea(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: EdgeInsets.symmetric(
                      horizontal: Dimens.padding_10,
                      vertical: Dimens.padding_20,
                    ),
                    child: Row(
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            height: Dimens.height_35,
                            width: Dimens.width_35,
                            padding: const EdgeInsets.all(10.0),
                            child: SvgPicture.asset(
                              Images.back,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SvgPicture.asset(
                    Images.verification,
                  ),
                  SizedBox(
                    height: Dimens.height_20,
                  ),
                  Text(
                    Constants.verification,
                    style: TextStyle(
                        fontSize: Dimens.fontSize_24,
                        color: textColor,
                        fontFamily: Fonts.bold),
                  ),
                  SizedBox(
                    height: Dimens.height_10,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: Dimens.padding_20),
                    child: Text(
                      Constants.verificationContent,
                      textAlign: TextAlign.center,
                      style: TextStyle(
                          color: textColor,
                          fontSize: Dimens.fontSize_14,
                          fontFamily: Fonts.regular),
                    ),
                  ),
                  SizedBox(
                    height: Dimens.height_20,
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: Dimens.dimen_50),
                    child: PinCodeTextField(
                      controller: pinCodeController,
                      keyboardType: TextInputType.number,
                      animationType: AnimationType.fade,
                      pinTheme: PinTheme(
                          shape: PinCodeFieldShape.box,
                          borderRadius: BorderRadius.circular(Dimens.radius_5),
                          fieldHeight: Dimens.height_50,
                          fieldWidth: Dimens.width_50,
                          activeFillColor: inactiveColor,
                          activeColor: inactiveColor,
                          borderWidth: 0.5,
                          inactiveColor: inactiveColor,
                          selectedColor: primaryColor,
                          selectedFillColor: inactiveColor,
                          inactiveFillColor: inactiveColor,
                          disabledColor: inactiveColor),
                      inputFormatters: [
                        FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                        FilteringTextInputFormatter.digitsOnly,
                        LengthLimitingTextInputFormatter(4)
                      ],
                      appContext: context,
                      length: 4,
                      cursorColor: textColor,
                      textStyle: TextStyle(
                          color: textColor,
                          fontFamily: Fonts.regular,
                          fontSize: Dimens.fontSize_18),
                      onChanged: (String value) {},
                    ),
                  ),
                  Padding(
                    padding: EdgeInsets.symmetric(horizontal: Dimens.padding_20),
                    child: AppButton(
                      label: Constants.continues,
                      onPressed: () async {
                        if (pinCodeController.text.isEmpty) {
                          AlertSnackBar.error("OTP is required!");
                        } else if (pinCodeController.text.length != 4) {
                          AlertSnackBar.error("Invalid OTP!");
                        } else {
                          // await authStore.verifyOTP(
                          //     widget.mobileNumber, pinCodeController.text);
                        }
                      },
                    ),
                  ),
                  SizedBox(
                    height: Dimens.height_20,
                  ),
                  RichText(
                    text: TextSpan(
                      text: '${Constants.didNotReceive}  ',
                      style: TextStyle(
                          color: Theme.of(context).textTheme.titleSmall!.color,
                          fontFamily: Fonts.regular,
                          fontSize: Dimens.fontSize_14),
                      children: <TextSpan>[
                        TextSpan(
                            text: Constants.resendOTP,
                            recognizer: TapGestureRecognizer()
                              ..onTap = () async {
                                // if (emailCountdownOver) {
                                //   await authStore.login(widget.mobileNumber);
                                //   startOtpTimer();
                                // }
                              },
                            style: TextStyle(
                                color: emailCountdownOver == false
                                    ? inactiveColor
                                    : primaryColor,
                                fontFamily: Fonts.semiBold,
                                fontSize: Dimens.fontSize_14)),
                      ],
                    ),
                  ),
                  const Expanded(child: SizedBox()),
                  if (!emailCountdownOver)
                    Padding(
                      padding: EdgeInsets.all(Dimens.padding_20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircularPercentIndicator(
                            radius: Dimens.radius_20,
                            lineWidth: 25.0,
                            percent: getPercent(emailStart),
                            animation: true,
                            animationDuration: 1,
                            animateFromLastPercent: true,
                            progressColor: progressColor,
                            backgroundColor: inactiveColor,
                          ),
                          SizedBox(
                            width: Dimens.width_10,
                          ),
                          SizedBox(
                            width: Dimens.width_70,
                            child: Text(
                              "00:${getSecond(emailStart)} ${Constants.left}",
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: textColor,
                                  fontSize: Dimens.fontSize_14,
                                  fontFamily: Fonts.regular),
                            ),
                          )
                        ],
                      ),
                    ),
                ],
              ),
            ),
            LoadingWithBackground(authStore.isLoading)
          ],
        );
      }),
    );
  }

  String getSecond(int val) {
    if (val > 9) {
      return val.toString();
    } else {
      return "0$val";
    }
  }

  double getPercent(int val) {
    double total = (59 - val) / 59;
    return total;
  }
}

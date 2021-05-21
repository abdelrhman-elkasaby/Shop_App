import 'package:bot_toast/bot_toast.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:shop_app2/my_info/resources/MyColors.dart';
import 'package:shop_app2/my_info/utils/Utils.dart';


class AlertsServices {
  showAlertMessage({String title, bool isSuccess}) {
    return BotToast.showNotification(
      trailing: (cancel) {
        return GestureDetector(
          onTap: cancel,
          child: const Icon(
            Icons.clear,
            color: Colors.black,
          ),
        );
      },
      title: (_) => Text(
        "$title",
        textAlign:
            Utils().pref().userLocal == 'en' ? TextAlign.end : TextAlign.start,
        style: TextStyle(
          color: Colors.black,
          fontSize: 16.5,
          fontWeight: FontWeight.w600,
        ),
        textDirection: TextDirection.rtl,
      ),
      leading: (_) => Icon(
        isSuccess ? Icons.check_circle_rounded : Icons.error_rounded,
        color: isSuccess ? Colors.green : Colors.red,
        size: 37,
      ),
      backgroundColor: Colors.white,
      crossPage: true,
      backButtonBehavior: BackButtonBehavior.close,
      animationDuration: const Duration(milliseconds: 500),
      animationReverseDuration: const Duration(milliseconds: 500),
      duration: const Duration(seconds: 4),
      onlyOne: true,
      enableSlideOff: true,
      borderRadius: 12,
      enableKeyboardSafeArea: true,
      contentPadding: const EdgeInsets.symmetric(vertical: 6, horizontal: 20),
    );
  }

  void showLoadingDialog(BuildContext context) {
    EasyLoading.show(
      maskType: EasyLoadingMaskType.black,
      status: "pleaseWait",
      indicator: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      ),
    );
  }

  void showLoadingDialogWithProgress({String progress}) {
    EasyLoading.show(
      maskType: EasyLoadingMaskType.clear,
      dismissOnTap: true,
      status: progress,
      indicator: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
      ),
    );
  }

  Center showLoadingView(BuildContext context) {
    return const Center(
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(
          MyColors.primaryColor,
        ),
      ),
    );
  }

  Future showConfirmDialog({
    @required BuildContext context,
    @required String title,
    @required Function confirm,
  }) {
    return showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return _alertDialog(
          title,
          confirm,
          context,
          "confirm",
        );
      },
    );
  }

  Widget _alertDialog(
      String title, Function confirm, BuildContext context, String okText) {
    return CupertinoAlertDialog(
      title: Text(
        title,
        style: TextStyle(
          color: const Color(0xff313135),
          fontFamily: 'almarai',
        ),
      ),
      // content: MyText(title: title,size: 12,color: MyColors.blackOpacity,),
      actions: [
        CupertinoDialogAction(
          child: Text(
            "cancel",
            style: TextStyle(color: Color(0xff313135), fontFamily: 'almarai'),
          ),
          onPressed: () => Navigator.pop(context),
        ),
        CupertinoDialogAction(
          child: Text(
            okText,
            style: TextStyle(color: Color(0xff313135), fontFamily: 'almarai'),
          ),
          onPressed: confirm,
        ),
      ],
    );
  }

  // Future showAuthDialog({@required BuildContext context}) {
  //   return showCupertinoDialog(
  //     context: context,
  //     builder: (BuildContext context) {
  //       return _alertDialog(
  //         "قم بتسجيل الدخول للمتابعة",
  //         () => ExtendedNavigator.of(context)
  //             .pushAndRemoveUntil(Routes.forgetPassword, (route) => false),
  //         context,
  //         "دخول",
  //       );
  //     },
  //   );
  // }

  Future showCustomDialog({
    @required BuildContext context,
    @required Widget child,
  }) {
    return showCupertinoModalPopup(
      context: context,
      builder: (BuildContext context) {
        return Dialog(backgroundColor: MyColors.whiteColor, child: child);
      },
    );
  }

  // Widget currentActionSheet({String phone, BuildContext context}) {
  //   return phone == null
  //       ? SizedBox()
  //       : CupertinoActionSheetAction(
  //           child: Text(
  //             phone,
  //             style: const TextStyle(
  //               color: MyColors.blackColor,
  //             ),
  //           ),
  //           onPressed: () {
  //             ExtendedNavigator.of(context).pop();
  //             Future.delayed(
  //               Duration(milliseconds: 200),
  //               () {
  //                 Utils().launcher().callPhone(phone: phone);
  //               },
  //             );
  //           },
  //         );
  // }

  // void showIosPicker({
  //   BuildContext context,
  //   String phone,
  //   phone2,
  //   mobile1,
  //   mobile2,
  //   hotLine,
  // }) {
  //   showCupertinoModalPopup(
  //     context: context,
  //     builder: (_) {
  //       return CupertinoActionSheet(
  //         title: Text(
  //           'phoneServices'.localize(context),
  //           style: const TextStyle(
  //             fontSize: 20,
  //             color: MyColors.blackColor,
  //             fontFamily: 'almarai',
  //             fontWeight: FontWeight.bold,
  //           ),
  //         ),
  //         cancelButton: CupertinoActionSheetAction(
  //           isDestructiveAction: true,
  //           child: Text(
  //             'cancel'.localize(context),
  //             style: const TextStyle(
  //               fontFamily: 'almarai',
  //             ),
  //           ),
  //           onPressed: ExtendedNavigator.of(context).pop,
  //         ),
  //         actions: [
  //           currentActionSheet(phone: phone, context: context),
  //           currentActionSheet(phone: phone2, context: context),
  //           currentActionSheet(phone: mobile1, context: context),
  //           currentActionSheet(phone: mobile2, context: context),
  //           currentActionSheet(phone: hotLine, context: context),
  //         ],
  //       );
  //     },
  //   );
  // }

  void showDropDown({
    BuildContext context,
    Widget child,
    bool withNoBackgroundObactity = false,
  }) {
    if (withNoBackgroundObactity) {
      showCupertinoModalPopup<Future>(
        context: context,
        useRootNavigator: true,
        builder: (BuildContext context) {
          return Dismissible(
            key: Key('1'),
            direction: DismissDirection.vertical,
            onDismissed: (value){
              Navigator.of(context).pop();
            },
            movementDuration: const Duration(milliseconds: 200),
            child: Container(
              decoration: const BoxDecoration(
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
                color: Colors.white,
              ),
              width: MediaQuery.of(context).size.width,
              child: child,
            ),
          );
        },
      );
    } else {
      showModalBottomSheet<Future>(
        context: context,
        useRootNavigator: true,
        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(25),
            topRight: Radius.circular(25),
          ),
        ),
        builder: (BuildContext context) {
          return Container(
            decoration: const BoxDecoration(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25),
                topRight: Radius.circular(25),
              ),
              color: Colors.white,
            ),
            width: MediaQuery.of(context).size.width,
            child: child,
          );
        },
      );
    }
  }
}

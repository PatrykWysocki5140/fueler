import 'dart:developer';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fueler/routes/UI/user_screen/widgets/deleteUser_dialog.dart';
import 'package:fueler/routes/UI/user_screen/widgets/logout_dialog.dart';
import 'package:fueler/routes/UI/user_screen/widgets/price_entries_list_widget.dart';
import 'package:fueler/routes/UI/user_screen/widgets/veryfication_widget.dart';
import 'package:fueler/settings/Get_colors.dart';

import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../model/API_Model/User.dart';
import '../../../model/API_Model/UserPrivilegeLevel.dart';
import '../../../notifiers/APINotifier.dart';
import '../../../settings/Get_colors.dart';
import '../../../settings/validator.dart';

class UserScreen extends StatefulWidget {
  static String id = "user_screen";
  const UserScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<UserScreen> createState() => _UserScreenState();
}

class _UserScreenState extends State<UserScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController veryfiCodeController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController newemailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController currentpasswordController =
      TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController userPrivilegeLevelController =
      TextEditingController();

  final TextEditingController firstpasswordController = TextEditingController();
  final TextEditingController secondpasswordController =
      TextEditingController();

  bool _loadUserData = true;
  bool _showPassword = true;
  bool _newPassword = false;
  bool _newEmail = false;

  Future<void> UpdatePassword() async {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(AppLocalizations.of(context)!.procesing),
        backgroundColor: GetColors.warning,
      ));
      Response? _response = await Provider.of<Api>(context, listen: false)
          .updatePassword(currentpasswordController.text,
              firstpasswordController.text, context);

      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      if (_response?.statusCode == 204) {
        _showPassword = false;
        firstpasswordController.clear();
        secondpasswordController.clear();
        currentpasswordController.clear();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(AppLocalizations.of(context)!.success),
          backgroundColor: GetColors.success,
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(AppLocalizations.of(context)!.error),
          backgroundColor: GetColors.error,
        ));
      }
    }
  }

  Future<void> UpdateEmail() async {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(AppLocalizations.of(context)!.procesing),
        backgroundColor: GetColors.warning,
      ));
      emailController.text = newemailController.text;
      Response? _response = await Provider.of<Api>(context, listen: false)
          .updateUserData(nameController.text, phoneNumberController.text,
              emailController.text, context);
      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      if (_response?.statusCode == 204) {
        _newEmail = false;
        newemailController.clear();
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(AppLocalizations.of(context)!.success),
          backgroundColor: GetColors.success,
        ));
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(AppLocalizations.of(context)!.error),
          backgroundColor: GetColors.error,
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    if (_loadUserData) {
      nameController.text = Provider.of<Api>(context).user.name.toString();
      phoneNumberController.text =
          Provider.of<Api>(context).user.phoneNumber.toString();
      emailController.text = Provider.of<Api>(context).user.email.toString();
      newemailController.text = Provider.of<Api>(context).user.email.toString();
      userPrivilegeLevelController.text =
          Provider.of<Api>(context).user.userPrivilegeLevel.toString();
      _loadUserData = !_loadUserData;
      passwordController.text =
          Provider.of<Api>(context).user.password.toString();
    }

    var size = MediaQuery.of(context).size;
    if (Provider.of<Api>(context).user.id != null) {
      Provider.of<Api>(context).getMyPriceEntries();
    }
    return Scaffold(
      //appBar: AppBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            SizedBox(height: size.height * 0.15),
            if (Provider.of<Api>(context).user.id != null)
              Container(
                child: Form(
                  key: _formKey,
                  child: SizedBox(
                    //width: size.width,
                    //height: size.height,
                    child: Align(
                      alignment: Alignment.center,
                      child: Container(
                        width: size.width * 0.85,
                        //padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: <Widget>[
                            Center(
                              child: Text(
                                AppLocalizations.of(context)!.hello +
                                    ", " +
                                    Provider.of<Api>(context)
                                        .user
                                        .name
                                        .toString(),
                                style: const TextStyle(
                                  fontSize: 30,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                            SizedBox(height: size.height * 0.06),
                            if (Provider.of<Api>(context).user.isConfirmed ==
                                false)
                              Center(
                                // margin: EdgeInsets.all(10),
                                // padding: EdgeInsets.all(5),
                                //color: GetColors.mainColorLight,
/*
                                decoration: BoxDecoration(
                                    color: GetColors.warning,
                                    border: Border.all(
                                      color: GetColors.error,
                                      width: 5,
                                    )),
                                    */
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  crossAxisAlignment: CrossAxisAlignment.end,
                                  children: [
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            Provider.of<Api>(context)
                                                    .user
                                                    .name
                                                    .toString() +
                                                ", " +
                                                AppLocalizations.of(context)!
                                                    .userisnotconfirmed,
                                            style: TextStyle(
                                              color: GetColors.error,
                                              fontSize: 30,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    /*
                                    SizedBox(height: size.height * 0.01),
                                    Row(
                                      children: [
                                        Expanded(
                                          child: Text(
                                            AppLocalizations.of(context)!
                                                .enterconfirmcode,
                                            style: const TextStyle(
                                              fontSize: 15,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),*/
                                    /*
                                    Row(
                                      children: [
                                        Container(
                                          //margin: EdgeInsets.all(10),
                                          // padding: EdgeInsets.all(5),
                                          child: Expanded(
                                            child: TextFormField(
                                              //showCursor: false,
                                              //readOnly: true,
                                              //enableInteractiveSelection: false,
                                              //focusNode: FocusNode(),
                                              validator: (value) => Validator
                                                  .validateVeryficationCode(
                                                      value ?? "", context),
                                              controller: veryfiCodeController,
                                              keyboardType:
                                                  TextInputType.number,
                                              decoration: InputDecoration(
                                                hintText: AppLocalizations.of(
                                                        context)!
                                                    .veryfiCode,
                                                isDense: true,
                                              ),
                                              onTap: () {},
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),*/
                                    SizedBox(height: size.height * 0.01),
                                    SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton(
                                        /*
                                        onPressed: () {
                                          Navigator.of(context).pushNamed(
                                              "/profile/verification");
                                              if (val == true)
                                              setState(() {
                                                
                                              });
                                        },*/
                                        onPressed: (() async {
                                          bool? val = await showDialog<bool>(
                                              context: context,
                                              builder: (BuildContext context) =>
                                                  const PinCodeVerificationScreen());
                                          log("PinCodeVerificationScreen " +
                                              val.toString());
                                          if (val == true) {
                                            setState(() {
                                              Provider.of<Api>(context,
                                                      listen: false)
                                                  .user
                                                  .SetConfirm(true);
                                            });
                                          }
                                        }),
                                        child: Text(
                                          AppLocalizations.of(context)!.veryfi,
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(height: size.height * 0.06),
                                  ],
                                ),
                              ),
                            Text(AppLocalizations.of(context)!.phonenumber),
                            TextFormField(
                              showCursor: false,
                              readOnly: true,
                              //enableInteractiveSelection: false,
                              focusNode: FocusNode(),
                              validator: (value) =>
                                  Validator.validatePhoneNumber(
                                      value ?? "", context),
                              controller: phoneNumberController,
                              keyboardType: TextInputType.phone,
                              decoration: InputDecoration(
                                hintText:
                                    AppLocalizations.of(context)!.phonenumber,
                                isDense: true,
                              ),
                              onTap: () {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(AppLocalizations.of(context)!
                                      .noteditable),
                                  backgroundColor: GetColors.warning,
                                ));
                              },
                            ),
                            SizedBox(height: size.height * 0.03),
                            Text("Email"),
                            TextFormField(
                              showCursor: false,
                              readOnly: true,
                              enableInteractiveSelection: false,
                              focusNode: FocusNode(),
                              validator: (value) =>
                                  Validator.validateEmail(value ?? "", context),
                              controller: emailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      if (_newEmail) {
                                        //emailController.text = "";
                                        newemailController.text = "";
                                      } else {
                                        emailController.text = Provider.of<Api>(
                                                context,
                                                listen: false)
                                            .user
                                            .email
                                            .toString();
                                        newemailController.text =
                                            Provider.of<Api>(context,
                                                    listen: false)
                                                .user
                                                .email
                                                .toString();
                                      }
                                      _newEmail = !_newEmail;
                                    });
                                  },
                                  child: Icon(
                                    _newEmail
                                        ? Icons.cancel
                                        : Icons.mode_edit_outline,
                                  ),
                                ),
                                hintText: "Email",
                                isDense: true,
                              ),
                            ),
                            if (_newEmail)
                              Container(
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(height: size.height * 0.01),
                                    Text(
                                        AppLocalizations.of(context)!.newemail),
                                    TextFormField(
                                      //obscureText: _newEmail,
                                      validator: (value) =>
                                          Validator.validateEmail(
                                              value ?? "", context),
                                      controller: newemailController,
                                      keyboardType: TextInputType.emailAddress,
                                      decoration: InputDecoration(
                                        hintText: AppLocalizations.of(context)!
                                            .newemail,
                                        isDense: true,
                                      ),
                                    ),
                                    SizedBox(height: size.height * 0.01),
                                    SizedBox(
                                      width: double.infinity,
                                      child: ElevatedButton(
                                        style: ButtonStyle(
                                            backgroundColor:
                                                MaterialStatePropertyAll<Color>(
                                                    (emailController.text !=
                                                            newemailController
                                                                .text)
                                                        ? GetColors.red
                                                        : GetColors.gray)),
                                        onPressed: () {
                                          if (emailController.text !=
                                              newemailController.text) {
                                            UpdateEmail();
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    content: Text(
                                                        AppLocalizations.of(
                                                                context)!
                                                            .setnewemail),
                                                    backgroundColor:
                                                        GetColors.warning));
                                          }
                                        },
                                        child: Text(
                                          AppLocalizations.of(context)!
                                              .updateEmail,
                                          style: const TextStyle(
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold,
                                          ),
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            SizedBox(height: size.height * 0.03),
                            Text(AppLocalizations.of(context)!.password),
                            TextFormField(
                              showCursor: false,
                              readOnly: true,
                              enableInteractiveSelection: false,
                              focusNode: FocusNode(),
                              obscureText: true,
                              validator: (value) => Validator.validatePassword(
                                  value ?? "", context),
                              controller: passwordController,
                              keyboardType: TextInputType.visiblePassword,
                              decoration: InputDecoration(
                                hintText:
                                    AppLocalizations.of(context)!.password,
                                suffixIcon: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      _showPassword = !_showPassword;
                                      _newPassword = !_newPassword;
                                    });
                                  },
                                  child: Icon(
                                    !_showPassword
                                        ? Icons.cancel
                                        : Icons.mode_edit_outline,
                                  ),
                                ),
                                isDense: true,
                              ),
                            ),
                            if (_newPassword) //////////////////// hasło
                              Container(
                                  child: Column(
                                children: [
                                  SizedBox(height: size.height * 0.01),
                                  TextFormField(
                                    obscureText: _showPassword,
                                    controller: currentpasswordController,
                                    keyboardType: TextInputType.visiblePassword,
                                    decoration: InputDecoration(
                                      hintText: AppLocalizations.of(context)!
                                          .currentpassword,
                                      isDense: true,
                                    ),
                                  ),
                                  SizedBox(height: size.height * 0.01),
                                  TextFormField(
                                    obscureText: _showPassword,
                                    validator: (value) =>
                                        Validator.validatePasswordRegister(
                                            value ?? "",
                                            secondpasswordController.text,
                                            context),
                                    controller: firstpasswordController,
                                    keyboardType: TextInputType.visiblePassword,
                                    decoration: InputDecoration(
                                      hintText: AppLocalizations.of(context)!
                                          .newpassword,
                                      isDense: true,
                                    ),
                                  ),
                                  SizedBox(height: size.height * 0.01),
                                  TextFormField(
                                    obscureText: _showPassword,
                                    validator: (value) =>
                                        Validator.validatePasswordRegister(
                                            value ?? "",
                                            firstpasswordController.text,
                                            context),
                                    controller: secondpasswordController,
                                    keyboardType: TextInputType.visiblePassword,
                                    decoration: InputDecoration(
                                      hintText: AppLocalizations.of(context)!
                                          .newpasswordrepeat,
                                      isDense: true,
                                    ),
                                  ),
                                  SizedBox(height: size.height * 0.01),
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      style: ButtonStyle(
                                          backgroundColor:
                                              MaterialStatePropertyAll<
                                                  Color>((firstpasswordController
                                                          .text.isNotEmpty &&
                                                      secondpasswordController
                                                          .text.isNotEmpty &&
                                                      currentpasswordController
                                                          .text.isNotEmpty)
                                                  ? GetColors.red
                                                  : GetColors.gray)),
                                      onPressed: () {
                                        if (firstpasswordController
                                                .text.isNotEmpty &&
                                            secondpasswordController
                                                .text.isNotEmpty &&
                                            currentpasswordController
                                                .text.isNotEmpty) {
                                          UpdatePassword();
                                        } else {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content: Text(
                                                      currentpasswordController.text
                                                              .isNotEmpty
                                                          ? AppLocalizations.of(
                                                                  context)!
                                                              .setnewpassword
                                                          : AppLocalizations.of(
                                                                  context)!
                                                              .setcurrentpassword),
                                                  backgroundColor:
                                                      GetColors.warning));
                                        }
                                      },
                                      child: Text(
                                        AppLocalizations.of(context)!
                                            .updatePassword,
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              )),
                            SizedBox(
                              width: size.width * 0.85,
                              child: Column(
                                children: [
                                  SizedBox(height: size.height * 0.03),
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      //style: ButtonStyle(backgroundColor:MaterialStatePropertyAll<Color>(GetColors.red)),
                                      onPressed: (() async {
                                        bool? val = await showDialog<bool>(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                const LogOutDialog());
                                        if (val == true) {
                                          Navigator.of(context)
                                              .pushNamed("/profile");
                                        }
                                      }),
                                      child: Text(
                                        AppLocalizations.of(context)!.logout,
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: size.height * 0.03),
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      //style: ButtonStyle(backgroundColor:MaterialStatePropertyAll<Color>(GetColors.red)),
                                      onPressed: (() async {
                                        bool? val = await showDialog<bool>(
                                            context: context,
                                            builder: (BuildContext context) =>
                                                const DeleteUserDialog());
                                        if (val == true) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                            content: Text(
                                                AppLocalizations.of(context)!
                                                    .deleteaccountfinish),
                                            backgroundColor: GetColors.success,
                                          ));
                                          Navigator.of(context)
                                              .pushNamed("/profile");
                                        }
                                      }),
                                      child: Text(
                                        AppLocalizations.of(context)!
                                            .deleteaccount,
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: size.height * 0.03),
                                  SizedBox(
                                    width: double.infinity,
                                    child: ElevatedButton(
                                      onPressed: () {
                                        Navigator.of(context).pushNamed(
                                            "/profile/mypriceentries");
                                      },
                                      child: Text(
                                        AppLocalizations.of(context)!.history,
                                        style: const TextStyle(
                                          fontSize: 20,
                                          fontWeight: FontWeight.bold,
                                        ),
                                      ),
                                    ),
                                  ),
                                  SizedBox(height: size.height * 0.03),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              )
            else
              Center(child: Text(AppLocalizations.of(context)!.nulluser)),
          ],
        ),
      ),
    );
  }
}

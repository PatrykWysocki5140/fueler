import 'dart:developer';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fueler/routes/UI/user_admin_screen/widgets/deleteUser_dialog.dart';
import 'package:fueler/routes/UI/user_admin_screen/widgets/logout_dialog.dart';
import 'package:fueler/settings/Get_colors.dart';

import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../model/API_Model/User.dart';
import '../../../model/API_Model/UserPrivilegeLevel.dart';
import '../../../notifiers/APINotifier.dart';
import '../../../settings/Get_colors.dart';
import '../../../settings/validator.dart';

class AdminScreen extends StatefulWidget {
  static String id = "user_screen";
  const AdminScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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

    return Scaffold(
      body: Form(
        key: _formKey,
        child: SizedBox(
          width: size.width,
          height: size.height,
          child: Align(
            alignment: Alignment.center,
            child: Container(
              width: size.width * 0.85,
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Center(
                      child: Text(
                        AppLocalizations.of(context)!.hello +
                            ", " +
                            Provider.of<Api>(context).user.name.toString(),
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.06),
                    Text(AppLocalizations.of(context)!.phonenumber),
                    TextFormField(
                      showCursor: false,
                      readOnly: true,
                      //enableInteractiveSelection: false,
                      focusNode: FocusNode(),
                      validator: (value) =>
                          Validator.validatePhoneNumber(value ?? "", context),
                      controller: phoneNumberController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)!.phonenumber,
                        isDense: true,
                      ),
                      onTap: () {
                        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                          content:
                              Text(AppLocalizations.of(context)!.noteditable),
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
                                emailController.text =
                                    Provider.of<Api>(context, listen: false)
                                        .user
                                        .email
                                        .toString();
                                newemailController.text =
                                    Provider.of<Api>(context, listen: false)
                                        .user
                                        .email
                                        .toString();
                              }
                              _newEmail = !_newEmail;
                            });
                          },
                          child: Icon(
                            _newEmail ? Icons.cancel : Icons.mode_edit_outline,
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
                            Text(AppLocalizations.of(context)!.newemail),
                            TextFormField(
                              //obscureText: _newEmail,
                              validator: (value) =>
                                  Validator.validateEmail(value ?? "", context),
                              controller: newemailController,
                              keyboardType: TextInputType.emailAddress,
                              decoration: InputDecoration(
                                hintText:
                                    AppLocalizations.of(context)!.newemail,
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
                                                    newemailController.text)
                                                ? GetColors.red
                                                : GetColors.gray)),
                                onPressed: () {
                                  if (emailController.text !=
                                      newemailController.text) {
                                    UpdateEmail();
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                        SnackBar(
                                            content: Text(
                                                AppLocalizations.of(context)!
                                                    .setnewemail),
                                            backgroundColor:
                                                GetColors.warning));
                                  }
                                },
                                child: Text(
                                  AppLocalizations.of(context)!.updateEmail,
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
                      validator: (value) =>
                          Validator.validatePassword(value ?? "", context),
                      controller: passwordController,
                      keyboardType: TextInputType.visiblePassword,
                      decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)!.password,
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
                              hintText:
                                  AppLocalizations.of(context)!.currentpassword,
                              isDense: true,
                            ),
                          ),
                          SizedBox(height: size.height * 0.01),
                          TextFormField(
                            obscureText: _showPassword,
                            validator: (value) =>
                                Validator.validatePasswordRegister(value ?? "",
                                    secondpasswordController.text, context),
                            controller: firstpasswordController,
                            keyboardType: TextInputType.visiblePassword,
                            decoration: InputDecoration(
                              hintText:
                                  AppLocalizations.of(context)!.newpassword,
                              isDense: true,
                            ),
                          ),
                          SizedBox(height: size.height * 0.01),
                          TextFormField(
                            obscureText: _showPassword,
                            validator: (value) =>
                                Validator.validatePasswordRegister(value ?? "",
                                    firstpasswordController.text, context),
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
                                      MaterialStatePropertyAll<Color>(
                                          (firstpasswordController
                                                      .text.isNotEmpty &&
                                                  secondpasswordController
                                                      .text.isNotEmpty &&
                                                  currentpasswordController
                                                      .text.isNotEmpty)
                                              ? GetColors.red
                                              : GetColors.gray)),
                              onPressed: () {
                                if (firstpasswordController.text.isNotEmpty &&
                                    secondpasswordController.text.isNotEmpty &&
                                    currentpasswordController.text.isNotEmpty) {
                                  UpdatePassword();
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              currentpasswordController
                                                      .text.isNotEmpty
                                                  ? AppLocalizations.of(
                                                          context)!
                                                      .setnewpassword
                                                  : AppLocalizations.of(
                                                          context)!
                                                      .setcurrentpassword),
                                          backgroundColor: GetColors.warning));
                                }
                              },
                              child: Text(
                                AppLocalizations.of(context)!.updatePassword,
                                style: const TextStyle(
                                  fontSize: 20,
                                  fontWeight: FontWeight.bold,
                                ),
                              ),
                            ),
                          ),
                        ],
                      )),
                    SizedBox(height: size.height * 0.03),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          //width: double.infinity,
                          child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll<Color>(
                                        GetColors.red)),
                            onPressed: (() async {
                              bool? val = await showDialog<bool>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      const LogOutDialog());
                              if (val == true) {
                                Navigator.of(context).pushNamed("/profile");
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
                      ],
                    ),
                    SizedBox(height: size.height * 0.01),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        SizedBox(
                          //width: double.infinity,
                          child: ElevatedButton(
                            style: ButtonStyle(
                                backgroundColor:
                                    MaterialStatePropertyAll<Color>(
                                        GetColors.red)),
                            onPressed: (() async {
                              bool? val = await showDialog<bool>(
                                  context: context,
                                  builder: (BuildContext context) =>
                                      const DeleteUserDialog());
                              if (val == true) {
                                ScaffoldMessenger.of(context)
                                    .showSnackBar(SnackBar(
                                  content: Text(AppLocalizations.of(context)!
                                      .deleteaccountfinish),
                                  backgroundColor: GetColors.success,
                                ));
                                Navigator.of(context).pushNamed("/profile");
                              }
                            }),
                            child: Text(
                              AppLocalizations.of(context)!.deleteaccount,
                              style: const TextStyle(
                                fontSize: 20,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

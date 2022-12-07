import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fueler/routes/UI/user_screen/widgets/logout_dialog.dart';
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
  const AdminScreen({Key? key}) : super(key: key);

  @override
  State<AdminScreen> createState() => _AdminScreenState();
}

class _AdminScreenState extends State<AdminScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController newemailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController userPrivilegeLevelController =
      TextEditingController();

  final TextEditingController firstpasswordController = TextEditingController();
  final TextEditingController secondpasswordController =
      TextEditingController();
  //final ApiClient _apiClient = Provider.of<Api>(context, listen: true);
  bool _loadUserData = true;
  bool _showPassword = true;
  bool _newPassword = false;
  bool _newEmail = false;

  Future<void> UpdatePassword() async {
    if (_formKey.currentState!.validate()) {
      User _newUserPassword = Provider.of<Api>(context, listen: false).user;
      passwordController.text = firstpasswordController.text;

      _newUserPassword.SetNewPassword(passwordController.text);
      User? _user = await Provider.of<Api>(context, listen: false)
          .UpdateUser(_newUserPassword, context);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(AppLocalizations.of(context)!.procesing),
        backgroundColor: GetColors.success,
      ));
      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      if (_user?.password == _newUserPassword.password) {
        _showPassword = false;
        firstpasswordController.clear();
        secondpasswordController.clear();
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
      User _newUserEmail = Provider.of<Api>(context, listen: false).user;
      emailController.text = newemailController.text;

      _newUserEmail.SetNewEmail(emailController.text);
      User? _user = await Provider.of<Api>(context, listen: false)
          .UpdateUser(_newUserEmail, context);

      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(AppLocalizations.of(context)!.procesing),
        backgroundColor: GetColors.success,
      ));
      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      if (_user?.email == _newUserEmail.email) {
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
                      obscureText: _showPassword,
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
                                                      .text.isNotEmpty)
                                              ? GetColors.red
                                              : GetColors.gray)),
                              onPressed: () {
                                if (firstpasswordController.text.isNotEmpty &&
                                    secondpasswordController.text.isNotEmpty) {
                                  UpdatePassword();
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                          content: Text(
                                              AppLocalizations.of(context)!
                                                  .setnewpassword),
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
                            onPressed: () => showDialog<String>(
                                context: context,
                                builder: (BuildContext context) =>
                                    const LogOutDialog()),
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

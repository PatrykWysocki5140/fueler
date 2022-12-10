import 'dart:developer';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fueler/settings/Get_colors.dart';

import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../model/API_Model/User.dart';
import '../../../model/API_Model/UserPrivilegeLevel.dart';
import '../../../notifiers/APINotifier.dart';
import '../../../settings/validator.dart';

class LoginScreen extends StatefulWidget {
  static String id = "login_screen";
  const LoginScreen({Key? key}) : super(key: key);

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController loginController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  //final ApiClient _apiClient = Provider.of<Api>(context, listen: true);
  bool _showPassword = true;

  Future<void> loginUser() async {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(AppLocalizations.of(context)!.procesing),
        backgroundColor: GetColors.warning, //Colors.green.shade300,
      ));

      Response? _response = await Provider.of<Api>(context, listen: false)
          .login(loginController.text, passwordController.text);
      //.LogIn(numberController.text, passwordController.text);

      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      // ignore: unnecessary_null_comparison
      if (_response?.statusCode == 200) {
        //Navigator.push(context,MaterialPageRoute(builder: (context) => const LoginScreen()));
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('${AppLocalizations.of(context)!.success}'),
          backgroundColor: GetColors.success, //Colors.red.shade300,
        ));
        Navigator.of(context).pushNamed("/profile");
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('${AppLocalizations.of(context)!.error}'),
          backgroundColor: GetColors.error, //Colors.red.shade300,
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    //loginController.text = "Adam";
    //passwordController.text = "TEST";
    var size = MediaQuery.of(context).size;
    return Scaffold(
      //backgroundColor: Colors.blueGrey[200],
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
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    //   SizedBox(height: size.height * 0.08),
                    Center(
                      child: Text(
                        AppLocalizations.of(context)!.login,
                        style: const TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.05),

                    SizedBox(height: size.height * 0.03),
                    TextFormField(
                      validator: (value) =>
                          Validator.validateName(value ?? "", context),
                      controller: loginController,
                      keyboardType: TextInputType.name,
                      decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)!.username,
                        isDense: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.03),
                    TextFormField(
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
                            });
                          },
                          child: Icon(
                            _showPassword
                                ? Icons.visibility
                                : Icons.visibility_off,
                            //color: Colors.grey,
                          ),
                        ),
                        isDense: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.06),
                    SizedBox(
                      width: double.infinity,
                      child: ElevatedButton(
                        onPressed: loginUser,
                        child: Text(
                          AppLocalizations.of(context)!.login,
                          style: const TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ),

                    SizedBox(
                      width: double.infinity,
                      child: TextButton(
                          onPressed: () => Navigator.of(context).pushNamed(
                              "/profile/register"), //Navigator.push(context,MaterialPageRoute(builder: (context) => const LoginScreen())),
                          child: Text(AppLocalizations.of(context)!.register)),
                    )
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

import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:fueler/settings/Get_colors.dart';

import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../model/API_Model/User.dart';
import '../../../model/API_Model/UserPrivilegeLevel.dart';
import '../../../notifiers/APINotifier.dart';
import '../../../settings/validator.dart';

class RegisterScreen extends StatefulWidget {
  static String id = "register_screen";
  const RegisterScreen({Key? key}) : super(key: key);

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  //final ApiClient _apiClient = Provider.of<Api>(context, listen: true);
  bool _showPassword = false;

  Future<void> registerUsers() async {
    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(AppLocalizations.of(context)!.procesing),
        backgroundColor: GetColors.success, //Colors.green.shade300,
      ));
/*
      Map<String, dynamic> userData = {
        "Email": [
          {
            "Type": "Primary",
            "Value": emailController.text,
          }
        ],
        "Password": passwordController.text,
        "About": 'I am a new user :smile:',
        "FirstName": "Test",
        "LastName": "Account",
        "FullName": "Test Account",
        "BirthDate": "10-12-1985",
        "Gender": "M",
      };*/
      User user = User(
        id: 0,
        name: "name",
        password: passwordController.text,
        phoneNumber: "phoneNumber",
        email: emailController.text,
        created: null,
        isConfirmed: null,
        isBanned: null,
        userPrivilegeLevel: UserPrivilegeLevel.USER,
      );

      User _user = await Provider.of<Api>(context, listen: true)
          .api
          .registerUser(user.toJson()); //_apiClient.registerUser(userData);

      ScaffoldMessenger.of(context).hideCurrentSnackBar();

      // ignore: unnecessary_null_comparison
      if (_user != null) {
        //Navigator.push(context,MaterialPageRoute(builder: (context) => const LoginScreen()));
        Navigator.of(context).pushNamed("/home/inner");
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text('${AppLocalizations.of(context)!.error}: ${_user.name}'),
          backgroundColor: GetColors.error,//Colors.red.shade300,
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    var size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: Colors.blueGrey[200],
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
                        AppLocalizations.of(context)!.register,
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
                          Validator.validateEmail(value ?? ""),
                      controller: emailController,
                      keyboardType: TextInputType.emailAddress,
                      decoration: InputDecoration(
                        hintText: "Email",
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
                          Validator.validatePassword(value ?? ""),
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
                            color: Colors.grey,
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
                        onPressed: registerUsers,
                        style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10)),
                            padding: const EdgeInsets.symmetric(
                                horizontal: 40, vertical: 15)),
                        child:  Text(
                          AppLocalizations.of(context)!.register,
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
                              "/home/inner"), //Navigator.push(context,MaterialPageRoute(builder: (context) => const LoginScreen())),
                          child: Text(AppLocalizations.of(context)!.login)),
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

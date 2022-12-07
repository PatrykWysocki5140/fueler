import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:fueler/settings/Get_colors.dart';
import 'package:provider/provider.dart';

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
  final TextEditingController nameController = TextEditingController();
  final TextEditingController firstpasswordController = TextEditingController();
  final TextEditingController secondpasswordController =
      TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController emailController = TextEditingController();

  //final ApiClient _apiClient = Provider.of<Api>(context, listen: true);
  bool _showPassword = true;

  Future<void> registerUsers() async {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();

    if (_formKey.currentState!.validate()) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(AppLocalizations.of(context)!.procesing),
        backgroundColor: GetColors.success, //Colors.green.shade300,
      ));

      ScaffoldMessenger.of(context).hideCurrentSnackBar();
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
        password: firstpasswordController.text,
        phoneNumber: "phoneNumber",
        email: emailController.text,
        created: null,
        isConfirmed: null,
        isBanned: null,
        userPrivilegeLevel: UserPrivilegeLevel.USER,
      );

      User? _user =
          await Provider.of<Api>(context, listen: false).RegisterUser(user);
      //_apiClient.registerUser(userData);

      // ignore: unnecessary_null_comparison
      if (_user != null) {
        //Navigator.push(context,MaterialPageRoute(builder: (context) => const LoginScreen()));
        Navigator.of(context).pushNamed("/home/inner");
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(
              '${AppLocalizations.of(context)!.error}: ${AppLocalizations.of(context)!.userCreationError}'),
          backgroundColor: GetColors.error, //Colors.red.shade300,
        ));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
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
                    SizedBox(height: size.height * 0.08),
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
                          Validator.validateName(value ?? "", context),
                      controller: nameController,
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
                      validator: (value) =>
                          Validator.validatePhoneNumber(value ?? "", context),
                      controller: phoneController,
                      keyboardType: TextInputType.phone,
                      decoration: InputDecoration(
                        hintText: AppLocalizations.of(context)!.phonenumber,
                        isDense: true,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                    SizedBox(height: size.height * 0.03),
                    TextFormField(
                      validator: (value) =>
                          Validator.validateEmail(value ?? "", context),
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
                      validator: (value) => Validator.validatePasswordRegister(
                          value ?? "", secondpasswordController.text, context),
                      controller: firstpasswordController,
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
                    SizedBox(height: size.height * 0.03),
                    TextFormField(
                      obscureText: _showPassword,
                      validator: (value) => Validator.validatePasswordRegister(
                          value ?? "", firstpasswordController.text, context),
                      controller: secondpasswordController,
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
                        onPressed: registerUsers,
                        child: Text(
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
                          onPressed: () =>
                              Navigator.of(context).pushNamed("/profile/login"),
                          //Navigator.push(context,MaterialPageRoute(builder: (context) => const LoginScreen())),
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

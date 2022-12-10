import 'dart:developer';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'package:fueler/settings/Get_colors.dart';

import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../../../model/API_Model/User.dart';
import '../../../../model/API_Model/UserPrivilegeLevel.dart';
import '../../../../notifiers/APINotifier.dart';
import '../../../../settings/Get_colors.dart';
import '../../../../settings/validator.dart';

class UserListScreen extends StatefulWidget {
  static String id = "user_screen";
  const UserListScreen({
    Key? key,
  }) : super(key: key);

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  bool _showPassword = false;
  //String _searchString = "";
  TextEditingController _searchString = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    log(_searchString.text);
    final List<User> objects = Provider.of<Api>(context).users;
    var size = MediaQuery.of(context).size;
    //Provider.of<Api>(context).getAllUsers();
    return Column(
      children: [
        SizedBox(height: size.height * 0.03),
        TextField(
          decoration: InputDecoration(
            hintText: AppLocalizations.of(context)!.search,
            suffixIcon: IconButton(
              onPressed: _searchString.clear,
              icon: const Icon(Icons.search),
            ),
          ),
          onChanged: (String value) {
            setState(() {
              // Aktualizacja listy po wpisaniu frazy
              log(_searchString.text);
              _searchString.text = value;
            });
          },
        ),
        Expanded(
          child: ListView.builder(
              // the number of items in the list
              itemCount: objects.length,
              shrinkWrap: false,
              scrollDirection: Axis.vertical,
              //physics: NeverScrollableScrollPhysics(),
              // display each item of the product list
              itemBuilder: (context, index) {
                return GestureDetector(
                  onTap: () {
                    showDialog(
                      context: context,
                      builder: (context) {
                        UserPrivilegeLevel _up = UserPrivilegeLevel.USER;
                        bool _isConfirmed = true;
                        bool _isBanned = false;
                        final TextEditingController idController =
                            TextEditingController();
                        final TextEditingController phoneNumberController =
                            TextEditingController();
                        final TextEditingController nameController =
                            TextEditingController();
                        final TextEditingController firstpasswordController =
                            TextEditingController();
                        final TextEditingController emailController =
                            TextEditingController();

                        _up = Provider.of<Api>(context)
                            .user
                            .getUserPrivilegeLevel(
                                objects[index].userPrivilegeLevel.toString());
                        idController.text = objects[index].id.toString();
                        nameController.text = objects[index].name.toString();
                        phoneNumberController.text =
                            objects[index].phoneNumber.toString();
                        firstpasswordController.text =
                            objects[index].password.toString();
                        emailController.text = objects[index].email.toString();
                        //_isConfirmed = objects[index].isConfirmed!;
                        //log(_isConfirmed.toString());

                        return Scaffold(
                          appBar: AppBar(
                            leading: IconButton(
                              icon: const Icon(
                                Icons.arrow_back,
                              ),
                              onPressed: () => {
                                idController.clear(),
                                nameController.clear(),
                                phoneNumberController.clear(),
                                firstpasswordController.clear(),
                                emailController.clear(),
                                //_isConfirmed = false,
                                _isBanned = false,
                                Navigator.of(context).pop(),
                              },
                            ),
                            title: Text(AppLocalizations.of(context)!.account +
                                ": " +
                                objects[index].name.toString() +
                                " ID:" +
                                objects[index].id.toString()),
                            centerTitle: true,
                          ),
                          body: SingleChildScrollView(
                            child: Container(
                                //width: size.width * 0.85,
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20, vertical: 30),
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(60),
                                ),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        ElevatedButton(
                                          /*
                                              style: ButtonStyle(
                                                  backgroundColor:
                                                      MaterialStatePropertyAll<Color>(
                                                          GetColors.warning)),*/
                                          onPressed: updateUsers,
                                          child: Text(
                                            AppLocalizations.of(context)!
                                                .update,
                                            style: const TextStyle(
                                              fontSize: 20,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    Form(
                                        child: Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(height: size.height * 0.03),
                                        Text(AppLocalizations.of(context)!
                                            .username),
                                        TextFormField(
                                          validator: (value) =>
                                              Validator.validateName(
                                                  value ?? "", context),
                                          controller: nameController,
                                          keyboardType: TextInputType.name,
                                          decoration: InputDecoration(
                                            hintText:
                                                AppLocalizations.of(context)!
                                                    .username,
                                            isDense: true,
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: size.height * 0.01),
                                        Text(AppLocalizations.of(context)!
                                            .phonenumber),
                                        TextFormField(
                                          validator: (value) =>
                                              Validator.validatePhoneNumber(
                                                  value ?? "", context),
                                          controller: phoneNumberController,
                                          keyboardType: TextInputType.phone,
                                          decoration: InputDecoration(
                                            hintText:
                                                AppLocalizations.of(context)!
                                                    .phonenumber,
                                            isDense: true,
                                          ),
                                          onTap: () {},
                                        ),
                                        SizedBox(height: size.height * 0.01),
                                        Text("email"),
                                        TextFormField(
                                          validator: (value) =>
                                              Validator.validateEmail(
                                                  value ?? "", context),
                                          controller: emailController,
                                          keyboardType:
                                              TextInputType.emailAddress,
                                          decoration: InputDecoration(
                                            hintText: "Email",
                                            isDense: true,
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                        ),
                                        SizedBox(height: size.height * 0.01),
                                        Text(AppLocalizations.of(context)!
                                            .password),
                                        TextFormField(
                                          showCursor: false,
                                          readOnly: true,
                                          enableInteractiveSelection: false,
                                          focusNode: FocusNode(),
                                          obscureText: _showPassword,
                                          controller: firstpasswordController,
                                          keyboardType:
                                              TextInputType.visiblePassword,
                                          decoration: InputDecoration(
                                            hintText:
                                                AppLocalizations.of(context)!
                                                    .password,
                                            isDense: true,
                                            border: OutlineInputBorder(
                                              borderRadius:
                                                  BorderRadius.circular(10),
                                            ),
                                          ),
                                          onTap: () {
                                            showDialog(
                                              context: context,
                                              builder: (context) {
                                                return AlertDialog(
                                                  icon: Icon(Icons.error),
                                                  iconColor: GetColors.error,
                                                  content: Row(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment
                                                            .center,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .center,
                                                    children: [
                                                      Text(AppLocalizations.of(
                                                              context)!
                                                          .updatePasswordError),
                                                    ],
                                                  ),
                                                );
                                              },
                                            );
                                          },
                                        ),
                                        //!_isConfirmed
                                        Column(
                                          children: [
                                            SizedBox(
                                                height: size.height * 0.01),
                                            Text(
                                              objects[index].isBanned == true
                                                  ? AppLocalizations.of(
                                                          context)!
                                                      .banusertrue
                                                  : AppLocalizations.of(
                                                          context)!
                                                      .banuserfalse,
                                              style: const TextStyle(
                                                fontSize: 30,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                            SizedBox(
                                                height: size.height * 0.01),
                                            SizedBox(
                                              width: double.infinity,
                                              child: ElevatedButton(
                                                onPressed: () {
                                                  banUser(!objects[index]
                                                      .isBanned!);
                                                },
                                                child: Text(
                                                  objects[index].isBanned ==
                                                          true
                                                      ? AppLocalizations.of(
                                                              context)!
                                                          .banuserfalseinfo
                                                      : AppLocalizations.of(
                                                              context)!
                                                          .banusertrueinfo,
                                                  style: const TextStyle(
                                                    fontSize: 20,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        if (objects[index].isConfirmed != true)
                                          Column(
                                            children: [
                                              SizedBox(
                                                  height: size.height * 0.03),
                                              SizedBox(
                                                width: double.infinity,
                                                child: ElevatedButton(
                                                  onPressed: confirmUsers,
                                                  child: Text(
                                                    AppLocalizations.of(
                                                            context)!
                                                        .confirmuser,
                                                    style: const TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          )
                                        else
                                          Row(
                                            children: [
                                              SizedBox(
                                                  height: size.height * 0.03),
                                              Center(
                                                child: Text(
                                                  AppLocalizations.of(context)!
                                                      .confirmuserinto,
                                                  style: const TextStyle(
                                                    fontSize: 30,
                                                    fontWeight: FontWeight.bold,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),

                                        SizedBox(height: size.height * 0.01),
                                        if (objects[index].userPrivilegeLevel !=
                                            UserPrivilegeLevel.ADMINISTRATOR)
                                          Column(
                                            children: [
                                              SizedBox(
                                                  height: size.height * 0.01),
                                              SizedBox(
                                                width: double.infinity,
                                                child: ElevatedButton(
                                                  onPressed: () {
                                                    setAdminUser();
                                                  },
                                                  child: Text(
                                                    AppLocalizations.of(
                                                            context)!
                                                        .setadmin,
                                                    style: const TextStyle(
                                                      fontSize: 20,
                                                      fontWeight:
                                                          FontWeight.bold,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),

                                        SizedBox(height: size.height * 0.01),
                                      ],
                                    ))
                                  ],
                                )),
                          ),
                        );

                        //return Text("gggg");
                      },
                    );
                  },
                  child: Card(
                    // In many cases, the key isn't mandatory
                    key: ValueKey(objects[index]),
                    //margin: const EdgeInsets.symmetric(vertical: 5, horizontal: 15),
                    child: Padding(
                        padding: const EdgeInsets.all(15),
                        child: Text(objects[index].name.toString() +
                            " " +
                            objects[index].email.toString())),
                  ),
                );
              }),
        ),
      ],
    );
/*
    return Scaffold(
      body: ListView.builder(
          itemCount: objects.length,
          itemBuilder: (context, index) {
            return ListTile(
              title: Text(objects[index]),
              // Po kliknięciu w element listy wyświetl szczegóły obiektu
              onTap: () {
                showDialog(
                  context: context,
                  builder: (context) {
                    return AlertDialog(
                      content: Text(objects[index]['phoneNumber']),
                    );
                  },
                );
              },
            );
          },
        ),
      );*/
  }

  void registerUsers() {}

  void confirmUsers() {}

  void updateUsers() {}

  void banUser(bool bool) {
    bool = !bool;
  }

  void setAdminUser() {}
}

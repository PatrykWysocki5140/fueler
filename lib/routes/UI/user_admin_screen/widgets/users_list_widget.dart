import 'dart:developer';
import 'dart:ffi';
import 'dart:ui';

import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';

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
  bool firstload = true;
  final bool _showPassword = true;
  //String _searchString = "";
  final TextEditingController _searchString = TextEditingController();
  List<User> objects = List.empty(growable: true);

  Future<User?> updateUserListObject(String _uId, int _i) async {
    User _u;
    Response? _response =
        await Provider.of<Api>(context, listen: false).getUserById(_uId);
    if (_response?.statusCode == 200) {
      _u = User.fromJson(await _response?.data);
      objects[_i].name = _u.name.toString();
      objects[_i].phoneNumber = _u.phoneNumber.toString();
      objects[_i].email = _u.email.toString();
      objects[_i].name = _u.name.toString();

      return _u;
    } else {
      return null;
    }
  }

  Future<bool> showResponse(Response _response) async {
    firstload = false;
    if (_response.statusCode == 204) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(AppLocalizations.of(context)!.success),
        backgroundColor: GetColors.success,
      ));
      return true;
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(AppLocalizations.of(context)!.error),
        backgroundColor: GetColors.error,
      ));
      return false;
    }
  }

  Future<bool> setAdminUser(User _u) async {
    _u.setUserPrivilegeLevel("ADMINISTRATOR");
    Response? _response =
        await Provider.of<Api>(context, listen: false).updateUserById(_u);
    return showResponse(_response!);
  }

  Future<bool> confirmUsers(User _u) async {
    _u.SetConfirm(true);
    Response? _response =
        await Provider.of<Api>(context, listen: false).updateUserById(_u);
    return showResponse(_response!);
  }

  Future<bool> banUser(User _u) async {
    _u.SetBann(!_u.isBanned!);
    Response? _response =
        await Provider.of<Api>(context, listen: false).updateUserById(_u);
    return showResponse(_response!);
  }

  Future<bool> deleteUser(User _u) async {
    Response? _response =
        await Provider.of<Api>(context, listen: false).deleteUserById(_u);
    return showResponse(_response!);
  }

  Future<bool> updateUser(
    User _u,
    String _newname,
    String _newphoneNumber,
    String _newemail,
  ) async {
    _u.SetNewName(_newname);
    _u.SetNewPhoneNumber(_newphoneNumber);
    _u.SetNewEmail(_newemail);
    Response? _response =
        await Provider.of<Api>(context, listen: false).updateUserById(_u);
    return showResponse(_response!);
  }

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    if (Provider.of<Api>(context).user.userPrivilegeLevel ==
        UserPrivilegeLevel.ADMINISTRATOR) {
      Provider.of<Api>(context).getAllUsers();
    }
    List<User> _usersToSearch = Provider.of<Api>(context).users;
    _searchString.text = _searchString.text.replaceAll(" ", "");
    log("_searchString: '" + _searchString.text + "'");
    if (_searchString.text == "") {
      objects = Provider.of<Api>(context).users;
    } else {
      Iterable<User> _users = _usersToSearch.where((element) =>
          element.name!
              .toLowerCase()
              .contains(_searchString.text.toLowerCase()) ||
          element.phoneNumber!
              .toLowerCase()
              .contains(_searchString.text.toLowerCase()) ||
          element.email!
              .toLowerCase()
              .contains(_searchString.text.toLowerCase()) ||
          element.userPrivilegeLevel
              .toString()
              .toLowerCase()
              .contains(_searchString.text.toLowerCase()));
      objects = List.empty(growable: true);

      for (User obj in _users) {
        log("find user: " + obj.name.toString());
        objects.add(obj);
      }
    }
    //final List<User> objects = Provider.of<Api>(context).users;
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

                        //// update list object
                        if (firstload == false) {
                          Future<User?> _u = updateUserListObject(
                              objects[index].id.toString(), index);
                        }

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
                                    SingleChildScrollView(
                                      scrollDirection: Axis.horizontal,
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          ElevatedButton(
                                            onPressed: () async {
                                              if (await updateUser(
                                                  objects[index],
                                                  nameController.text,
                                                  phoneNumberController.text,
                                                  emailController.text)) {
                                                _isBanned = !_isBanned;
                                              }
                                            },
                                            child: Text(
                                              AppLocalizations.of(context)!
                                                  .update,
                                              style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                          ElevatedButton(
                                            /*
                                                style: ButtonStyle(
                                                    backgroundColor:
                                                        MaterialStatePropertyAll<Color>(
                                                            GetColors.warning)),*/
                                            onPressed: () async {
                                              if (await deleteUser(
                                                objects[index],
                                              )) {
                                                objects[index].Clear();
                                                //objects.removeAt(index);
                                                Navigator.of(context).pop();
                                              }
                                            },
                                            child: Text(
                                              AppLocalizations.of(context)!
                                                  .deleteaccount,
                                              style: const TextStyle(
                                                fontSize: 20,
                                                fontWeight: FontWeight.bold,
                                              ),
                                            ),
                                          ),
                                        ],
                                      ),
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
                                                onPressed: () async {
                                                  if (await banUser(
                                                      objects[index])) {
                                                    _isBanned = !_isBanned;
                                                  }
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
                                                  onPressed: () async {
                                                    if (await confirmUsers(
                                                        objects[index])) {
                                                      _isConfirmed = true;
                                                    }
                                                  },
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
                                                  onPressed: () async {
                                                    if (await setAdminUser(
                                                        objects[index])) {
                                                      _up = UserPrivilegeLevel
                                                          .ADMINISTRATOR;
                                                    } else {}
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
                      child: Text(
                          "${AppLocalizations.of(context)!.username}: ${objects[index].name.toString()}\nEmail: ${objects[index].email.toString()}\n${AppLocalizations.of(context)!.phonenumber}: ${objects[index].phoneNumber.toString()}\n${AppLocalizations.of(context)!.type}: ${objects[index].getUserPrivilegeLevel(objects[index].userPrivilegeLevel.toString()).name}"),
                    ),
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
}



/*
_up 
_isConfirmed
_isBanned
idController 
phoneNumberController 
 nameController
 firstpasswordController 
emailController 
*/

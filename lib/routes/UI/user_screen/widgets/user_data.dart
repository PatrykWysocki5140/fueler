import 'package:flutter/material.dart';

import '../../../../settings/Get_colors.dart';
import '../../../../settings/validator.dart';

class UserData extends StatelessWidget {
  const UserData(
      {required this.height,
      required this.phoneNumberController,
      required this.textFormTitle,
      Key? key})
      : super(key: key);

  final double height;
  final TextEditingController phoneNumberController;
  final String textFormTitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: height * 0.03),
        Text(textFormTitle),
        TextFormField(
          validator: (value) =>
              Validator.validatePhoneNumber(value ?? "", context),
          controller: phoneNumberController,
          keyboardType: TextInputType.phone,
          decoration: const InputDecoration(
            isDense: true,
          ),
        ),
      ],
    );
  }
}

import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:green_plant/helper/constance.dart';

class CustomTextFormField extends StatelessWidget {
  final String text;

  final String hint;

  final Function onSave;
  final Function validator;
  final Function autoFill;
  final TextEditingController controller;

  CustomTextFormField({
    this.text,
    this.hint,
    this.onSave,
    this.validator,
    this.autoFill,
    this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(horizontal: 30),
      child: Column(
        children: [
          Container(
            alignment: Alignment.center,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.tealAccent[100].withOpacity(.3),
            ),
            child: TextFormField(
              controller: controller,
              onSaved: onSave,
              validator: validator,
              cursorColor: primaryColor,
              decoration: InputDecoration(
                suffixIcon: IconButton(
                  icon: defaultTargetPlatform == TargetPlatform.iOS
                      ? Container()
                      : Icon(
                          Icons.auto_fix_high,
                          color: primaryColor,
                        ),
                  onPressed: defaultTargetPlatform == TargetPlatform.iOS
                      ? null
                      : autoFill,
                ),
                hintText: hint,
                hintStyle: TextStyle(
                  color: Colors.black,
                ),
                focusColor: Colors.grey,
                errorStyle: TextStyle(color: Colors.red),
                border: InputBorder.none,
                focusedBorder: InputBorder.none,
                enabledBorder: InputBorder.none,
                errorBorder: InputBorder.none,
                disabledBorder: InputBorder.none,
                contentPadding: EdgeInsets.all(15),
              ),
            ),
          )
        ],
      ),
    );
  }
}

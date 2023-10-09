import 'package:flutter/material.dart';

import '../../../../core/constants/colors_managers.dart';

textFormFields({
  required String valueKey,
  required TextEditingController controller,
  required bool enabled,
  required Function fct,
  required int maxLength,
}) {
  return Padding(
    padding: const EdgeInsets.all(8.0),
    child: InkWell(
      onTap: () {
        fct();
      },
      child: TextFormField(
        controller: controller,
        validator: (value) {
          if (value!.isEmpty) {
            return 'Field is missing';
          }
          return null;
        },
        enabled: enabled,
        key: ValueKey(valueKey),
        style: TextStyle(
          color: MyColors.ddarkindego,
          fontWeight: FontWeight.bold,
          fontSize: 18,
          fontStyle: FontStyle.italic,
        ),
        maxLines: valueKey == 'TaskDescription' ? 3 : 1,
        maxLength: maxLength,
        keyboardType: TextInputType.text,
        decoration: InputDecoration(
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15.0),
          ),
          filled: true,
          fillColor: Colors.blue[100],
          enabledBorder: OutlineInputBorder(
            borderSide:  BorderSide(
              color: MyColors.blue,
              width: 1.0,
            ),
            borderRadius: BorderRadius.circular(10.0),
          ),
          errorBorder: const OutlineInputBorder(
            borderSide: BorderSide(color: Colors.red),
          ),
          focusedBorder: UnderlineInputBorder(
            borderSide: BorderSide(color: Colors.pink.shade800),
          ),
        ),
      ),
    ),
  );
}


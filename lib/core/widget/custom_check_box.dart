import 'package:flutter/material.dart';


class CustomCheckBox extends StatelessWidget {
   CustomCheckBox({super.key, required this.onChanged,required this.value});
  final bool value ;
  final Function (bool?) onChanged;

  @override
  Widget build(BuildContext context) {
    return Checkbox(
      activeColor: Color(0xFF15B86C),
      value: value,
      ///عايز هنا bool true false
      onChanged: (bool? value) => onChanged(value)
      // shape: RoundedRectangleBorder(
      //   borderRadius: BorderRadius.circular(4),
      //
      // ),
    );
  }

}

//Checkbox(value: true, onChanged:(bool? value){});
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CustomTextFormeField extends StatelessWidget {
  CustomTextFormeField({
    super.key,
    required this.controle,
    this.maxLine,
    required this.hintText,
    this.validator,
    required this.title,
  });

  TextEditingController controle = TextEditingController();
  final int? maxLine;

  final String hintText;

  Function(String?)? validator;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          title,
          style: Theme.of(
            context,
          ).textTheme.displaySmall!.copyWith(fontSize: 16),
        ),
        SizedBox(height: 8),
        TextFormField(
          validator: validator != null
              ? (String? value) {
                  return validator!(value);
                }
              : null,
          maxLines: maxLine,
          controller: controle,
          // cursorColor: Colors.white,
          style: Theme.of(context).textTheme.labelMedium,
          decoration: InputDecoration(
            hintText: hintText,
            // filled: true,
            // fillColor: Color(0xFF282828),
            // border: OutlineInputBorder(
            //   borderSide: BorderSide.none,
            //   borderRadius: BorderRadius.circular(20),
            // ),
            // hintStyle: TextStyle(
            //   color: Color(0xFF6D6D6D),
            //   fontSize: 16,
            //   fontWeight: FontWeight.w400,
            // ),
          ),
        ),
      ],
    );
  }
}

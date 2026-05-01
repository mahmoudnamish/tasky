import 'package:flutter/material.dart';

class CustomElevatedButtom extends StatelessWidget {
   CustomElevatedButtom({super.key,required this.titel,required this.onPressed});
  final String titel ;
  final  Function () onPressed ;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          fixedSize: Size(MediaQuery.of(context).size.width, 40),
          // backgroundColor: Color(0xFF15B86C),
          // foregroundColor: Color(0xFFFFFCFC),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadiusGeometry.circular(100),
          ),
          padding: EdgeInsets.zero,
        ),
        child: Text(
          titel,
          style: TextStyle(fontWeight: FontWeight.w500),
        ),
      ),
    );
  }
}

// () async {
// //control.text.trim().isNotEmpty
// ///trim     اللغي المسافات علشان ميشغلش دماغه
// if (_key.currentState?.validate() ?? false)
// ///مش شغال معني السطر ده
// {
// final pref = await SharedPreferences.getInstance();
// await pref.setString('username', control.value.text);
// /// String? username = pref.getString('username');
// Navigator.push(
// context,
// MaterialPageRoute(
// builder: (BuildContext context) {
// return MainScreen();
// },
// ),
// );
// } else {
// ///TODO:snackbar
// }
// },

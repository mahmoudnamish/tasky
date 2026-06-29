import 'package:flutter/material.dart';
import 'package:tasky/constants/storage_key.dart';
import 'package:tasky/core/services/preferences_manager.dart';
import 'package:tasky/core/widget/custom_Elevated_Buttom.dart';
import 'package:tasky/core/widget/custom_svg_picture.dart';
import 'package:tasky/core/widget/custom_text_forme_field.dart';

import 'package:tasky/features/navigation/main_screen.dart';

class WelcomeScreen extends StatelessWidget {
  WelcomeScreen({super.key});

  //String name = "";
  final TextEditingController control = TextEditingController();

  /// List<String> x = [];
  final GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    ///print(MediaQuery.of(context).size);
    return Scaffold(
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Form(
              key: _key,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomSvgPicture.withoutColor(
                        path: "assets/images/Vector (1).svg",
                        height: 42,
                        width: 42,
                      ),

                      Padding(
                        padding: EdgeInsets.only(left: 16, top: 9, bottom: 9),
                        child: Text(
                          "Tasky",
                          style: Theme.of(context).textTheme.displayMedium,
                          textAlign: TextAlign.center,
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 108),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Welcome To Tasky ",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.displaySmall,
                        // style: TextStyle(
                        //   fontSize: 24,
                        //   fontWeight: FontWeight.w400,
                        //   color: Color(0xFFFFFCFC),
                        // ),
                      ),
                      SizedBox(width: 8),
                      CustomSvgPicture.withoutColor(
                        path:
                            "assets/images/waving-hand-medium-light-skin-tone-svgrepo-com 1.svg",
                        width: 28,
                        height: 28,
                      ),
                    ],
                  ),
                  SizedBox(height: 8),
                  Text(
                    "Your productivity journey starts here.",
                    textAlign: TextAlign.center,
                    style: Theme.of(
                      context,
                    ).textTheme.displaySmall!.copyWith(fontSize: 16),
                    // style: TextStyle(
                    //   fontWeight: FontWeight.w400,
                    //   fontSize: 16,
                    //   color: Color(0xFFFFFCFC),
                    // ),
                  ),
                  SizedBox(height: 24),
                  CustomSvgPicture.withoutColor(
                    path: "assets/images/pana.svg",
                    width: 218,
                    height: 204.39,
                  ),
                  SizedBox(height: 28),
                  Container(
                    margin: EdgeInsets.symmetric(horizontal: 16),
                    width: double.infinity,
                    //   child: Text(
                    //     "Full Name",
                    //     textAlign: TextAlign.start,
                    //     style: TextStyle(
                    //       fontSize: 16,
                    //       fontWeight: FontWeight.w400,
                    //       color: Color(0xFFFFFCFC),
                    //     ),
                    //   ),
                    // ),
                    // SizedBox(height: 8),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: CustomTextFormeField(
                        validator: (String? value) {
                          //  if(value == null || value.trim().isEmpty)
                          if (value?.trim().isEmpty ?? false) {
                            return "Please Enter Your Full Name";
                          }
                          return null;
                        },
                        controle: control,
                        hintText: "e.g. Sarah Khalid",
                        title: "Full Name",
                      ),
                      // child: TextFormField(
                      //   validator: (String? value) {
                      //     //  if(value == null || value.trim().isEmpty)
                      //     if (value
                      //             ?.trim()
                      //             .isEmpty /*  لو القيمه دي بي null قلي القيمه بي false*/ ??
                      //         false) {
                      //       return "Please Enter Your Full Name";
                      //     }
                      //     return null;
                      //   },
                      //   controller: control,
                      //   style: TextStyle(color: Colors.white),
                      //   cursorColor: Colors.white,
                      //   decoration: InputDecoration(
                      //     hintText: "e.g. Sarah Khalid",
                      //     filled: true,
                      //     fillColor: Color(0xFF282828),
                      //     hintStyle: TextStyle(color: Color(0xFF6D6D6D)),
                      //     border: OutlineInputBorder(
                      //       borderRadius: BorderRadius.circular(16),
                      //       borderSide: BorderSide.none,
                      //     ),
                      //   ),
                      // ),
                    ),
                  ),
                  SizedBox(height: 24),
                  CustomElevatedButtom(
                    titel: "Let’s Get Started",
                    onPressed: () async {
                      //control.text.trim().isNotEmpty
                      ///trim     اللغي المسافات علشان ميشغلش دماغه
                      if (_key.currentState?.validate() ?? false) {
                        ///مش شغال معني السطر ده {
                        // final pref = await SharedPreferences.getInstance();
                        //  await pref.setString('username', control.value.text);
                        await PreferencesManager().setString(
                          StorageKey.username,
                          control.value.text,
                        );

                        /// String? username = pref.getString('username');
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (BuildContext context) {
                              return MainScreen();
                            },
                          ),
                        );
                      } else {
                        ///TODO:snackbar
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text("Please Enter Your Full Name"),
                          ),
                        );
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

//     style: ElevatedButton.styleFrom(
//       fixedSize: Size(MediaQuery.of(context).size.width, 40),
//       backgroundColor: Color(0xFF15B86C),
//       foregroundColor: Color(0xFFFFFCFC),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadiusGeometry.circular(100),
//       ),
//       padding: EdgeInsets.zero,
//     ),
//     child: Text(
//       "Let’s Get Started",
//       style: TextStyle(fontWeight: FontWeight.w500),
//     ),
//   ),
// ),)
// Padding(
//   padding: EdgeInsets.symmetric(horizontal: 16),
//   child: ElevatedButton(
//     onPressed: () async {
//       //control.text.trim().isNotEmpty
//       ///trim     اللغي المسافات علشان ميشغلش دماغه
//       if (_key.currentState?.validate() ?? false)
//       ///مش شغال معني السطر ده
//       {
//         final pref = await SharedPreferences.getInstance();
//         await pref.setString('username', control.value.text);
//        /// String? username = pref.getString('username');
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (BuildContext context) {
//               return MainScreen();
//             },
//           ),
//         );
//       } else {
//         ///TODO:snackbar
//       }
//     },
//     style: ElevatedButton.styleFrom(
//       fixedSize: Size(MediaQuery.of(context).size.width, 40),
//       backgroundColor: Color(0xFF15B86C),
//       foregroundColor: Color(0xFFFFFCFC),
//       shape: RoundedRectangleBorder(
//         borderRadius: BorderRadiusGeometry.circular(100),
//       ),
//       padding: EdgeInsets.zero,
//     ),
//     child: Text(
//       "Let’s Get Started",
//       style: TextStyle(fontWeight: FontWeight.w500),
//     ),
//   ),
// ),

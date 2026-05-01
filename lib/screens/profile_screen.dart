import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:tasky/core/theme/theme_controller.dart';
import 'package:tasky/core/widget/custom_svg_picture.dart';
import 'package:tasky/screens/user_details_screen.dart';
import 'package:tasky/screens/welcome_screen.dart';
import '../core/services/preferences_manager.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  late String username;
  late String motivation;
  String? userImagePath;
  bool isLoading = true;

  // bool isDarkMode = true;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _loadData();
  }

  void _loadData() async {
    setState(() {
      username = PreferencesManager().getString('username') ?? '';
      motivation = PreferencesManager().getString('motivation_guote') ?? "One task at a time. One step closer.";
      userImagePath = PreferencesManager().getString('user_image');
      // isDarkMode = PreferencesManager().getBool('theme') ?? true;
      isLoading = false;
    });
  }

  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 17),
      child: isLoading
          ? Center(child: CircularProgressIndicator())
          : Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  "My Profile",
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                SizedBox(height: 16),
                Center(
                  child: Column(
                    children: [
                      Stack(
                        alignment: Alignment.bottomRight,
                        children: [
                          CircleAvatar(
                            backgroundImage: userImagePath == null
                                ? AssetImage(
                                    "assets/images/Leading element.png",
                                  )
                                : FileImage(File(userImagePath!)),
                            radius: 60,
                            backgroundColor: Colors.transparent,
                          ),
                          GestureDetector(
                            child: Container(
                              width: 45,
                              height: 45,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Theme.of(
                                  context,
                                ).colorScheme.primaryContainer,
                              ),
                              child: Icon(
                                Icons.camera_alt_outlined,
                                color: ThemeController.isDark()
                                    ? Color(0xFFFFFCFC)
                                    : Color(0xFF161F1B),
                                size: 26,
                              ),
                            ),
                          ),
                          GestureDetector(
                            child: Container(
                              width: 45,
                              height: 45,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(100),
                                color: Theme.of(
                                  context,
                                ).colorScheme.primaryContainer,
                              ),
                              child: Icon(
                                Icons.camera_alt_outlined,
                                color: ThemeController.isDark()
                                    ? Color(0xFFFFFCFC)
                                    : Color(0xFF161F1B),
                                size: 26,
                              ),
                            ),
                            onTap: () async {
                              showImageSourceDialog(
                                context: context,
                                selectedFile: (XFile file) {
                                  _saveImage(file);
                                  setState(() {
                                    userImagePath = file.path;
                                  });
                                },
                              );
                              ///TODO:Image Piker
                              // XFile? image = await ImagePicker().pickImage(
                              //   source: ImageSource.gallery,
                              // );
                              // if (image != null) {
                              //   setState(() {
                              //     _selectedImage = File(image.path);
                              //   });
                              // }
                            },
                          ),
                        ],
                      ),
                      SizedBox(height: 8),
                      Text(
                        username,
                        style: Theme.of(context).textTheme.labelSmall,
                      ),
                      Text(
                        motivation,
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 24),
                Text(
                  "Profile Info",
                  style: Theme.of(context).textTheme.labelSmall,
                ),
                SizedBox(height: 24),
                ListTile(
                  onTap: () async {
                    final bool? resuilt = await Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return UserDetailsScreen(
                            userName: username,
                            motivationQuote: motivation,
                          );
                        },
                      ),
                    );
                    if (resuilt != null && resuilt == true) {
                      _loadData();
                    }
                  },
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    "User Details",
                    //style: Theme.of(context).textTheme.titleMedium,
                  ),
                  leading: CustomSvgPicture(path: "assets/images/Icon (3).svg"),
                  trailing: GestureDetector(
                    child: CustomSvgPicture(
                      path: "assets/images/Trailing element.svg",
                    ),
                  ),
                ),
                Divider(thickness: 1),
                ListTile(
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    "Dark Mode",
                    //  style: Theme.of(context).textTheme.titleMedium,
                  ),
                  leading: CustomSvgPicture(path: "assets/images/Icon.svg"),

                  trailing: ValueListenableBuilder(
                    valueListenable: ThemeController.themeNotifier,
                    builder: (BuildContext context, ThemeMode value, Widget? child) {
                      return Switch(
                        activeTrackColor: Color(0xFF15B86C),
                        //    value: ThemeController.themeNotifier.value == ThemeMode.dark , ///كدا هيرجعلي صح او غلط
                        value: value == ThemeMode.dark,
                        onChanged: (bool value) {
                          ThemeController.toggleTheme();

                          ///TODO:ThemeChange
                          // setState(() {
                          //   isDarkMode = value;
                          //   if (!isDarkMode) {
                          //     themeNotifier.value = ThemeMode.light;
                          //   } else {
                          //     themeNotifier.value = ThemeMode.dark;
                          //   }
                          // });
                          // await PreferencesManager().setBool("theme", value);
                        },
                      );
                    },
                  ),
                ),
                Divider(thickness: 1),
                ListTile(
                  onTap: () async {
                    // final pref = await SharedPreferences.getInstance();
                    await PreferencesManager().remove("username");
                    await PreferencesManager().remove("motivation_guote");
                    await PreferencesManager().remove("tasks");
                    // pref.remove("username");
                    // pref.remove("motivation_guote");
                    // pref.remove("tasks");
                    Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(
                        builder: (BuildContext context) {
                          return WelcomeScreen();
                        },
                      ),
                      (Route<dynamic> route) => false,
                    );
                  },
                  contentPadding: EdgeInsets.zero,
                  title: Text(
                    "Log Out",
                    //style: Theme.of(context).textTheme.titleMedium,
                  ),
                  leading: CustomSvgPicture(
                    path: "assets/images/log-out-01.svg",
                  ),
                  trailing: GestureDetector(
                    child: CustomSvgPicture(
                      path: 'assets/images/Trailing element.svg',
                    ),
                  ),
                ),
              ],
            ),
    );
  }

  showImageSourceDialog({context, required Function(XFile) selectedFile}) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        ///TODO:context my own of build widget call back fn
        return SimpleDialog(
          title: Text(
            "Choose Image Source",
            style: Theme.of(context).textTheme.titleMedium,
          ),
          children: [
            SimpleDialogOption(
              padding: EdgeInsets.all(16),
              onPressed: () async {
                Navigator.pop(context);
                XFile? image = await ImagePicker().pickImage(
                  source: ImageSource.camera,
                );
                if (image != null) {
                  selectedFile(image);
                }
              },
              child: Row(
                children: [
                  Icon(Icons.camera),
                  SizedBox(width: 8),
                  Text('Camera'),
                ],
              ),
            ),
            SimpleDialogOption(
              padding: EdgeInsets.all(16),
              onPressed: () async {
                Navigator.pop(context);
                XFile? image = await ImagePicker().pickImage(
                  source: ImageSource.gallery,
                );
                if (image != null) {
                  selectedFile(image);
                }
              },
              child: Row(
                children: [
                  Icon(Icons.photo_library),
                  SizedBox(width: 8),
                  Text('Gallery'),
                ],
              ),
            ),
          ],
        );
      },
    );
  }

  void _saveImage(XFile file) async {
    final appDir = await getApplicationDocumentsDirectory();
    final newFile = await File(file.path).copy("${appDir.path}/${file.name}");
    await PreferencesManager().setString('user_image', newFile.path);
  }
}

//   Future<DateTime?> _ShowTimePaker(context) async {
//     final result = await showDatePicker(
//       context: context,
//       initialDate: DateTime.now(),
//       firstDate: DateTime(1998),
//       lastDate: DateTime.now().add(Duration(days: 360)),
//     );
//     print(result);
//
//     showTimePicker(context: context, initialTime: TimeOfDay.now());
//   }
// }
///ListLite  بس بطريقه طويله
// Row(
//   children: [
//     SvgPicture.asset("assets/images/Icon (3).svg"),
//     SizedBox(width: 16),
//     Expanded(
//       child: Text(
//         "User Details",
//         style: TextStyle(
//           fontWeight: FontWeight.w400,
//           fontSize: 16,
//           color: Color(0xFFFFFCFC),
//         ),
//       ),
//     ),
//     GestureDetector(child: SvgPicture.asset("assets/images/Trailing element.svg")),
//   ],
// ),
// SizedBox(height: 8),
// Divider(color: Color(0xFFCAC4D0)),
//--------------------------------------------------------
// SizedBox(height: 10),
// Row(
//   children: [
//     SvgPicture.asset("assets/images/Icon.svg"),
//     SizedBox(width: 16),
//     Expanded(
//       child: Text(
//         "Dark Mode",
//         style: TextStyle(
//           fontWeight: FontWeight.w400,
//           fontSize: 16,
//           color: Color(0xFFFFFCFC),
//         ),
//       ),
//     ),
//     Switch(
//       activeTrackColor: Color(0xFF15B86C),
//       value: switcher,
//       onChanged: (bool value) {
//         setState(() {
//           switcher = value;
//         });
//       },
//     ),
//   ],
// ),
// SizedBox(height: 8),
// Divider(color: Color(0xFFCAC4D0)),
//------------------------------------------------------------------
// SizedBox(height: 10),
// Row(
//   children: [
//     SvgPicture.asset("assets/images/log-out-01.svg"),
//     SizedBox(width: 16),
//     Expanded(
//       child: Text(
//         "Log Out",
//         style: TextStyle(
//           fontWeight: FontWeight.w400,
//           fontSize: 16,
//           color: Color(0xFFFFFCFC),
//         ),
//       ),
//     ),
//     GestureDetector(child: SvgPicture.asset("assets/images/Trailing element.svg")),
//   ],
// ),

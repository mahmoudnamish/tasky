import 'package:flutter/material.dart';
import 'package:tasky/core/services/preferences_manager.dart';

// import 'package:shared_preferences/shared_preferences.dart';
import 'package:tasky/core/widget/custom_Elevated_Buttom.dart';
import 'package:tasky/core/widget/custom_text_forme_field.dart';

class UserDetailsScreen extends StatefulWidget {
  const UserDetailsScreen({
    super.key,
    required this.userName,
    required this.motivationQuote,
  });

  final String userName;
  final String motivationQuote;

  @override
  State<UserDetailsScreen> createState() => _UserDetailsScreenState();
}

class _UserDetailsScreenState extends State<UserDetailsScreen> {
  TextEditingController userNameController = TextEditingController();

  TextEditingController motivationQuoteController = TextEditingController();

  GlobalKey<FormState> _key = GlobalKey<FormState>();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // userNameController = TextEditingController(text: widget.userName);  بس تشيل الانشليز بتاعه من فوق
    userNameController.text = widget.userName;
    //userNameController.value = TextEditingController(text:  widget.userName) as TextEditingValue;
    motivationQuoteController.text = widget.motivationQuote;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('User Details')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _key,
          child: Column(
            children: [
              CustomTextFormeField(
                validator: (String? value) {
                  if (value?.trim().isEmpty ?? false) {
                    return "please Enter the User Name";
                  }
                  return null;
                },
                controle: userNameController,
                hintText: "Eng.Mahmoud Nameish",
                title: "User Name",
              ),
              SizedBox(height: 20),
              CustomTextFormeField(
                maxLine: 5,
                controle: motivationQuoteController,
                hintText: "One task at a time. One step closer.",
                title: "Motivation Quote",
              ),
              Spacer(),
              CustomElevatedButtom(
                titel: 'Save Changes',
                onPressed: () async {
                  if (_key.currentState?.validate() ?? false) {
                    // final pref = await SharedPreferences.getInstance();
                    // await pref.setString('username', userNameController.value.text,);
                    // await pref.setString('motivation_guote', motivationQuoteController.value.text,);
                    await PreferencesManager().setString(
                      'username',
                      userNameController.value.text,
                    );
                    await PreferencesManager().setString(
                      'motivation_guote',
                      motivationQuoteController.value.text,
                    );
                    Navigator.of(context).pop(true);
                  }
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}

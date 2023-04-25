import 'package:flutter/material.dart';
import 'package:projecttest/constants.dart';
import 'package:projecttest/login_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';






class GetProfileInfo extends StatefulWidget {
  final String email;
  const GetProfileInfo({super.key, required this.email});

  @override
  State<GetProfileInfo> createState() => _GetProfileInfoState();
}





class _GetProfileInfoState extends State<GetProfileInfo> {
  TextEditingController _nameController = TextEditingController();
  TextEditingController _phoneController = TextEditingController();
  TextEditingController _emailController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    _emailController.text = widget.email.toString();
    Size _size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Column(

            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                "Complete Profile",
                style: AppBarFont,
              ),
              SizedBox(
                height: _size.height * 0.06,
              ),
              Container(
                height: _size.height * 0.18,
                decoration: BoxDecoration(
                    color: Colors.greenAccent, shape: BoxShape.circle),
                alignment: Alignment.center,
                child: Icon(
                  Icons.person,
                  size: _size.height * 0.12,
                ),
              ),
              SizedBox(
                height: _size.height * 0.02,
              ),
              Text(
                "Entre your name",
                style: style1,
              ),
              SizedBox(
                height: _size.height * 0.02,
              ),
              TeextField.textField(
                  size: _size, controller: _nameController, hideText: false),
              Text(
                "Entre your email",
                style: style1,
              ),
              SizedBox(
                height: _size.height * 0.02,
              ),
              TeextField.textField(
                  size: _size, controller: _emailController, hideText: false),
              SizedBox(
                height: _size.height * 0.02,
              ),
              Text(
                "Entre your Phone",
                style: style1,
              ),
              SizedBox(
                height: _size.height * 0.02,
              ),
              TeextField.textField(
                  size: _size, controller: _phoneController, hideText: false),
              SizedBox(
                height: _size.height * 0.01,
              ),
              LoginButton.loginButton(
                  size: _size,
                  onPressed: () {
                    print("object");
                    SaveData(
                        context: context,
                        email: _emailController.text,
                        name: _nameController.text,
                        phoneno: _phoneController.text);
                  },
                  txt: "Proceed"),
            ],
          ),
        ),
      ),
    );
  }

  void SaveData(
      {required String email,
      required String phoneno,
      required String name,
      required BuildContext context}) async {
    print("hey");

    final SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('name', name);
    await prefs.setString('email', email);
    await prefs.setString('pno', phoneno);
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }
}

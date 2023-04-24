import 'package:flutter/material.dart';
import 'package:projecttest/constants.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({super.key});

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  void initState() {
    FetchData();
  }

  String? name;
  String? email;
  String? phoneNo;
  bool Loading = true;

  void FetchData() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    name = await prefs.getString('name');
    email = await prefs.getString('email');
    phoneNo = await prefs.getString('pno');
    Loading = false;
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    Size _size = MediaQuery.of(context).size;

    return SafeArea(
      child: Scaffold(
        body: Loading
            ? Container()
            : Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
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
                    decoration: const BoxDecoration(
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
                  Row(
                    children: [
                      Text(
                        "Name :- ",
                        style: style1,
                      ),
                      Text(
                        name!,
                        style: style1,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: _size.height * 0.02,
                  ),
                  Row(
                    children: [
                      Text(
                        "Email :- ",
                        style: style1,
                      ),
                      Text(
                        email!,
                        style: style1,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: _size.height * 0.02,
                  ),
                  Row(
                    children: [
                      Text(
                        "Phone No :- ",
                        style: style1,
                      ),
                      Text(
                        phoneNo!,
                        style: style1,
                      ),
                    ],
                  ),
                  SizedBox(
                    height: _size.height * 0.01,
                  ),
                ],
              ),
      ),
    );
  }
}

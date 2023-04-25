import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class AnaPage extends StatefulWidget
{
  String csymbol;
  AnaPage({required this.csymbol});
  @override
  State<StatefulWidget> createState() {
    return AnaState(csymbol: csymbol);
  }
}
class AnaState extends State<AnaPage>
{
  String csymbol;
  AnaState({required this.csymbol});
  bool loading = false;

  @override
  void initState() {
    getData();
    super.initState();
  }

  Future<void> getData() async{

    // connection code write here

      //final response = await http.get(Uri.parse("https://pkgstore.datahub.io/core/nasdaq-listings/nasdaq-listed-symbols_json/data/5c10087ff8d283899b99f1c126361fa7/nasdaq-listed-symbols_json.json"));
      // if(response.statusCode == 200){
      //   setState(() {
      //    // loading = false;
      //   });
      // }

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Data"),
      ),
      body: Column(
        children: <Widget>[
          loading ? CircularProgressIndicator() :
              Image.network(""),

        ],
      ),
    );
  }
}
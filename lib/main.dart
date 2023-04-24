import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:autocomplete_textfield/autocomplete_textfield.dart';
import 'package:http/http.dart' as http;
import 'package:projecttest/candleStickPage.dart';
import 'package:projecttest/login_screen.dart';
import 'package:projecttest/profile_page.dart';
import 'dart:convert';
import 'constants.dart';
import 'symbols.dart';
import 'AnalysisPage.dart';
import 'package:google_fonts/google_fonts.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Stock Visualization',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      home: LoginScreen(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({key, required this.title}) : super(key: key);

  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  //https://pkgstore.datahub.io/core/nasdaq-listings/nasdaq-listed-symbols_json/data/5c10087ff8d283899b99f1c126361fa7/nasdaq-listed-symbols_json.json
  bool loading = true;
  static List<Company> companies = <Company>[];
  late AutoCompleteTextField searchTextField;
  GlobalKey<AutoCompleteTextFieldState<Company>> key = new GlobalKey();
  List _customcompanies = [
    {"Company Name": "Reliance Industries", "Symbol": "reliance"},
    {"Company Name": "Tata Steel", "Symbol": "tatasteel"},
    {"Company Name": "JPMorgan Chase & Co.", "Symbol": "JPM"},
    {"Company Name": "HDFC Bank Limited", "Symbol": "HDB"},
    {"Company Name": "Nifty 50", "Symbol": "NSEI"},
    {"Company Name": "State Bank of India", "Symbol": "SBIN.NS"},
    {"Company Name": "Maruti Suzuki India Limited", "Symbol": "MARUTI.NS"},
    {"Company Name": "NVIDIA Corporation", "Symbol": "NVDA"},
    {"Company Name": "Amazon.com, Inc.", "Symbol": "AMZN"},
  ];

  void getData() async {
    try {
      String url =
          "https://pkgstore.datahub.io/core/nasdaq-listings/nasdaq-listed-symbols_json/data/5c10087ff8d283899b99f1c126361fa7/nasdaq-listed-symbols_json.json";
      final resp = await http.get(Uri.parse(url));
      print(resp.statusCode);
      if (resp.statusCode == 200) {
        // resp.body = jsonEncode([{"Company Name": "Reliance Industries", "Symbol": "reliance"},{"Company Name": "Tata Steel", "Symbol": "tatasteel"},{"Company Name": "Nifty 50", "Symbol": "nifty50"}]) ;
        companies = getCompanies(jsonEncode(_customcompanies));
        print('Companies: ${companies.length}');
        setState(() {
          loading = false;
        });
      } else {
        print("Error getting data");
      }
    } catch (e) {
      print("Error getting data");
    }
  }

  static List<Company> getCompanies(String jsonS) {
    final parsed = json.decode(jsonS).cast<Map<String, dynamic>>();
    return parsed.map<Company>((json) => Company.fromJson(json)).toList();
  }

  @override
  void initState() {
    getData();
    super.initState();
  }


  Widget row(Company c) {
    
    return InkWell(
        onTap: () {
          Navigator.of(context).push(MaterialPageRoute(builder: (context) {
            return CandleStick(Loading: true, name: c.symbol);
          }));
        },
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: <Widget>[
            Text(
              c.symbol,
              style: GoogleFonts.openSans(
                  textStyle: TextStyle(
                fontSize: 24.0,
                fontWeight: FontWeight.bold,
              )),
            ),
            Flexible(
              child: Text(
                c.name,
                style: GoogleFonts.openSans(
                    textStyle:
                        TextStyle(fontSize: 12.0, color: Colors.black45)),
                overflow: TextOverflow.ellipsis,
              ),
            )
          ],
        ));
  }

  @override
  Widget build(BuildContext contexts) {
    Size _size = MediaQuery.of(context).size;
    return Scaffold(
      drawer: Drawer(
        width: _size.width * 0.75,
        child: SafeArea(
          child: ListView(
            children: [
              Container(
                decoration: BoxDecoration(
                    gradient: LinearGradient(colors: [
                  Color(0xFF06C30E),
                  Color(0xFF66E016),
                  Color(0xFFE9E744)
                ])),
                width: _size.width * 0.75,
                height: _size.height * 0.2,
                alignment: Alignment.centerLeft,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 20,
                    ),
                    Container(
                      height: _size.width * 0.25,
                      width: _size.width * 0.25,
                      decoration: BoxDecoration(
                          border: Border.all(width: 1, color: Colors.black54),
                          borderRadius: BorderRadius.circular(100)),
                      child: ClipRRect(
                          child: Image.network(
                            "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT9dhsgngaIotfIragwT1RmXC5iodXHGcknYw&usqp=CAU",
                            fit: BoxFit.fill,
                          ),
                          borderRadius: BorderRadius.circular(100)),
                    ),
                    SizedBox(
                      width: 15,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "Company name",
                          style: style1,
                        ),
                        Text(
                          "Company user id",
                          style: style1,
                        ),
                      ],
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => ProfilePage()
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      SizedBox(
                        width: _size.width * 0.03,
                      ),
                      Icon(Icons.person),
                      SizedBox(
                        width: _size.width * 0.03,
                      ),
                      Text(
                        "Profile Page",
                        style: style1,
                      ),
                    ],
                  ),
                ),
              ),




              Padding(
                padding: const EdgeInsets.all(8.0),
                child: GestureDetector(
                  onTap: () {
                    Navigator.pushReplacement<void, void>(
                      context,
                      MaterialPageRoute<void>(
                        builder: (BuildContext context) => LoginScreen(
                          
                        ),
                      ),
                    );
                  },
                  child: Row(
                    children: [
                      SizedBox(
                        width: _size.width * 0.03,
                      ),
                      Icon(Icons.login),
                      SizedBox(
                        width: _size.width * 0.03,
                      ),
                      Text(
                        "Logout",
                        style: style1,
                      ),
                    ],
                  ),
                ),
              )
            ],
          ),
        ),
      ),
      appBar: AppBar(
        centerTitle: true,
        title: Text(widget.title),
      ),
      body: loading
          ? Center(child: CircularProgressIndicator())
          : Column(
              children: <Widget>[
                Container(
                  decoration: BoxDecoration(
                    color: Colors.greenAccent,
                  ),
                  child: searchTextField = AutoCompleteTextField<Company>(
                    key: key,
                    clearOnSubmit: false,
                    suggestions: companies,
                    style: TextStyle(color: Colors.black, fontSize: 16.0),
                    decoration: InputDecoration(
                        enabledBorder: InputBorder.none,
                        border: InputBorder.none,
                        hintText: "Search for stock symbols to predict",
                        hintStyle: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w400)),
                    itemFilter: (item, query) {
                      return item.symbol
                          .toLowerCase()
                          .startsWith(query.toLowerCase());
                    },
                    itemSorter: (a, b) {
                      return a.symbol.compareTo(b.symbol);
                    },
                    itemSubmitted: (item) {
                      setState(() {
                        searchTextField.textField?.controller?.text =
                            item.symbol;
                      });
                    },
                    itemBuilder: (context, item) {
                      return row(item);
                    },
                  ),
                ),

                ////// NIche se likhna Chalu kar
              ],
            ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}

import 'dart:convert';

import 'package:candlesticks/candlesticks.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CandleStick extends StatefulWidget {
  CandleStick({super.key, required this.Loading, required this.name});
  bool Loading;
  String name;
  @override
  State<CandleStick> createState() => _CandleStickState();
}

class _CandleStickState extends State<CandleStick> {
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    GetData(name: widget.name);
  }

  List<Candle> candle = [];
  GetData({required String name}) async {
    http.Response res;
    res = await http.get(Uri.parse(
        "https://query1.finance.yahoo.com/v8/finance/chart/$name.ns?interval=1d&range=6mo"));
    Map m = jsonDecode(res.body);
    Map a = m["chart"];
    List b = a["result"];

    List TimeStamp = b[0]["timestamp"];
    m = b[0]["indicators"];
    b = m["quote"];
    List close = b[0]["close"];
    List open = b[0]["open"];
    List high = b[0]["high"];
    List low = b[0]["low"];
    List volume = b[0]["volume"];

    for (int i = 0; i < TimeStamp.length; i++) {
      DateTime date = new DateTime.fromMicrosecondsSinceEpoch(TimeStamp[i]);

      candle.add(Candle(
        date: date,
        high: high[i],
        low: low[i],
        open: open[i],
        close: close[i],
        volume: 0.1,
      ));
    }
    setState(() {
      widget.Loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      body: widget.Loading
          ? Container()
          : SafeArea(
              child: Candlesticks(
                candles: candle,
              ),
            ),
    );
  }
}

import 'package:crypto_karami/coin_list_screen.dart';
import 'package:crypto_karami/data/constant/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';

import 'data/model/crypto.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  void initState() {
    getDataCrypto();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: blackColor,
        body: SafeArea(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image(
                image: AssetImage('assets/images/logo.png'),
              ),
              SpinKitRing(
                color: Colors.white,
                size: 30.0,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<List<Crypto>?> getDataCrypto() async {
    var response = await Dio().get('https://api.coincap.io/v2/assets');

    List<Crypto> cryptos = response.data['data']
        .map<Crypto>((data) => Crypto.fromJson(data))
        .toList();

    print(cryptos);

    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (context) => CoinListScreen(
          cryptoes: cryptos,
        ),
      ),
    );

    return cryptos;
  }
}

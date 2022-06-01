import 'package:crypto_karami/data/constant/constants.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

import 'data/model/crypto.dart';

class CoinListScreen extends StatefulWidget {
  CoinListScreen({Key? key, this.cryptoes}) : super(key: key);
  List<Crypto>? cryptoes;

  @override
  State<CoinListScreen> createState() => _CoinListScreenState();
}

class _CoinListScreenState extends State<CoinListScreen> {
  List<Crypto>? cryptos;

  @override
  void initState() {
//
    cryptos = widget.cryptoes;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'karami  crypto',
          style: TextStyle(fontFamily: 'omidfont'),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        backgroundColor: blackColor,
      ),
      backgroundColor: blackColor,
      body: SafeArea(
        child: RefreshIndicator(
            color: blackColor,
            backgroundColor: greenColor,
            onRefresh: () async {
              List<Crypto>? freshData = await getDataCrypto();

              setState(() {
                cryptos = freshData;
              });
            },
            child: getListView()),
      ),
    );
  }

  Widget getListView() {
    return ListView.builder(
      itemBuilder: (context, index) {
        var change = cryptos![index].changePercent24Hr;
        var twonum = cryptos![index].priceUsd.toString();

        double changeper = double.parse(change!);
        double priceUsdDouble = double.parse(twonum);
        return ListTile(
          title: Text(
            '${cryptos![index].name}',
            style: TextStyle(color: greenColor),
          ),
          subtitle: Text(
            '${cryptos![index].symbol}',
            style: TextStyle(color: greyColor),
          ),
          leading: SizedBox(
            width: 30,
            child: Center(
              child: Text(
                '${cryptos![index].rank.toString()}',
                style: TextStyle(color: greyColor),
              ),
            ),
          ),
          trailing: SizedBox(
            width: 150,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      '${priceUsdDouble.toStringAsFixed(2)}',
                      style: TextStyle(color: greyColor, fontSize: 18),
                    ),
                    Text(
                      '${changeper.toStringAsFixed(2)}',
                      style: TextStyle(color: getColorChangePercent(changeper)),
                    )
                  ],
                ),
                SizedBox(
                    width: 50,
                    child: Center(child: getIconChangePercent(changeper))),
              ],
            ),
          ),
        );
      },
      itemCount: cryptos!.length,
    );
  }

  Widget getIconChangePercent(double percentChange) {
    return percentChange <= 0
        ? Icon(
            Icons.trending_down,
            color: redColor,
            size: 24,
          )
        : Icon(
            Icons.trending_up,
            size: 24,
            color: greenColor,
          );
  }

  Color getColorChangePercent(double percentChange) {
    return percentChange <= 0 ? redColor : greenColor;
  }

  Future<List<Crypto>?> getDataCrypto() async {
    var response = await Dio().get('https://api.coincap.io/v2/assets');

    List<Crypto> cryptos = response.data['data']
        .map<Crypto>((data) => Crypto.fromJson(data))
        .toList();

    return cryptos;
  }
}

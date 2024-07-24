

import 'package:borsatakibim/ConstValues/ConstValues.dart';
import 'package:borsatakibim/CustomWidgets.dart';
import 'package:borsatakibim/Models.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';

class CryptoDetail extends StatelessWidget {
  CryptoDetail({super.key, this.crypto});
  Crypto? crypto;

  final headerStyle =
      TextStyle(color: ConstValues.purple, fontSize: Get.size.width / 10);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
            top: Get.size.height / 20,
            left: Get.size.width / 20,
            right: Get.size.width / 20),
        child: Column(
          children: [
            Row(
              children: [
                Image.network(
                    "https://s2.coinmarketcap.com/static/img/coins/64x64/${crypto!.id}.png"),
                SizedBox(
                  width: Get.size.width / 20,
                ),
                Text(crypto!.cryptoName!, style: headerStyle),
                SizedBox(
                  width: Get.size.width / 20,
                ),
                
              ],
            ),
            Text(
                  crypto!.symbol!,
                  style: TextStyle(
                      color: Colors.black, fontSize: Get.size.width / 20),
                ),
            SizedBox(
              height: Get.size.height / 15,
            ),Row(children: [const Text("24H"),
                Icon(FontAwesomeIcons.percent,
                    color: crypto!.isStonks! ? Colors.green : Colors.red),],),
            Row(
              children: [
                Text(
                  crypto!.price!.toStringAsFixed(4),
                  style: TextStyle(fontSize: Get.size.width / 11),
                ),
              const  Icon(FontAwesomeIcons.dollarSign),
              SizedBox(width: Get.size.width/5,),
               
                Text(
                  crypto!.percentChange24h!.toStringAsFixed(3),
                  style: TextStyle(
                      fontSize: Get.size.width / 15,
                      color:
                          crypto!.isStonks! ? Colors.green : Colors.redAccent),
                )
              ],
            ),
            SizedBox(height: Get.size.height/20,),
            PriceChangeChart(crypto: crypto,),
            
          
          //  Column(children: [Container(width: Get.size.width*0.6,child: ElevatedButton(style: ElevatedButton.styleFrom(backgroundColor: ConstValues.purple),onPressed: (){}, child:  Text("Takibe Ekle",style: TextStyle(fontSize: Get.size.width /17,color: Colors.white),)))],)
          ],
        ),
      ),
    );
  }
}


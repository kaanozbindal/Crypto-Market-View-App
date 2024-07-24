import 'package:borsatakibim/ConstValues/ConstValues.dart';
import 'package:borsatakibim/Controllers.dart';
import 'package:borsatakibim/CustomWidgets.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class HomePage extends StatelessWidget{
  final controller = Get.find<MainController>();
  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return Scaffold(body: FutureBuilder(future: controller.getData(controller.cryptoList), builder: (context,snapshot){
     
      switch (snapshot.connectionState) {
        case ConnectionState.waiting:
          return Center(child: CircularProgressIndicator(color: ConstValues.purple,),);
        case ConnectionState.done:
          return ListView.builder(itemCount: controller.cryptoList.length,itemBuilder: (context,item){
            return CryptoWidget(crypto: controller.cryptoList[item],);
          });  
        default:
         return Text("bir hata var");
      }
      
    }));
  }
    
}
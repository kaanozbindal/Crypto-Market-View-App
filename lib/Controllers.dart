import 'dart:convert';

import 'package:borsatakibim/Models.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:http/http.dart' as http ;
class MainController extends GetxController{
  var cryptoList = RxList<Crypto>([]);
  @override
  void onInit()async{
   await getData(cryptoList);
    super.onInit();
  }

Future getData(RxList<Crypto> list)async{
  String url = "https://pro-api.coinmarketcap.com/v1/cryptocurrency/listings/latest";
  
  Uri uri = Uri.parse(url);
  String yourAPIKEY = "YOUR COINMARKET KEY API";
  var response = await http.get(uri,headers: {"X-CMC_PRO_API_KEY":yourAPIKEY});
  
  print(response);

  if (response.statusCode == 200) {
   var respoenseJson = jsonDecode(response.body);
  
   var data = respoenseJson["data"] as List<dynamic>;
  print(data);
  data.map((item) => list.add(Crypto.fromJson(item)));
  for (var element in data) {
    list.add(Crypto.fromJson(element));
  }
  print(list[0].cryptoName);

  }
  // print(list[0].cryptoName);
 //  print(list.length.toString()+"rxlist dizinin uzunlugu");
} 


}




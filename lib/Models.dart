class Crypto{
  String? cryptoName;
  String? symbol;
  int? maxSupply;
  double? price;
  double? volume24h;
  String? id;
  double? percentChange24h;
  bool? isStonks;
  double? marketCap;
  double? yesterDayPrice;
  Crypto({this.id,this.cryptoName,this.symbol,this.maxSupply,this.price,this.volume24h,this.marketCap,this.percentChange24h,this.isStonks,this.yesterDayPrice});

  factory Crypto.fromJson(Map<String,dynamic> json){
    double percentChange = json["quote"]["USD"]["percent_change_24h"];
    bool isStonks = percentChange > 0;
    double price = json["quote"]["USD"]["price"].toDouble();
    double yesterDayPrice;
    double change = (price * percentChange)/100;
    if (isStonks) {
      
      yesterDayPrice = price + change;
      
    } else {
      yesterDayPrice = price + change;
    }
    print("dunun fiyati"+ yesterDayPrice.toString());
    return Crypto(id: json["id"].toString(),cryptoName: json["name"],symbol: json["symbol"],percentChange24h: json["quote"]["USD"]["percent_change_24h"],maxSupply: json["max_supply"],price: json["quote"]["USD"]["price"].toDouble(),volume24h: json["quote"]["USD"]["volume_24h"].toDouble(),marketCap: json["quote"]["USD"]["market_cap"].toDouble(),isStonks: isStonks,yesterDayPrice: yesterDayPrice);
  }
}
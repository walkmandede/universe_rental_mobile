import 'package:universe_rental/constants/app_functions.dart';

class CurrencyModel{
  String id;
  String name;
  String abbr;
  String sign;

  CurrencyModel({
    required this.id,
    required this.name,
    required this.abbr,
    required this.sign
  });

  factory CurrencyModel.fromApi({required Map<String,dynamic> data}){
    return CurrencyModel(
      id: data["id"].toString(),
      name: data["name"].toString(),
      sign: data["sign"].toString(),
      abbr: data["abbr"].toString()
    );
  }

}
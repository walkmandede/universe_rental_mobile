
import 'package:universe_rental/web_data_entry/currency/m_currency_model.dart';

class NightFeeModel{

  double perNightFee;
  CurrencyModel currencyModel;

  NightFeeModel({
    required this.perNightFee,
    required this.currencyModel,
  });
  
  factory NightFeeModel.fromMap({required Map<String,dynamic> data}){
    return NightFeeModel(
      perNightFee: double.tryParse(data["amount"].toString())??0,
      currencyModel: CurrencyModel.fromApi(data: data)
    );
  }

}
import 'package:flutter/material.dart';
import 'package:shoppingmall/states/authen.dart';
import 'package:shoppingmall/states/buyer_service.dart';
import 'package:shoppingmall/states/create_account.dart';
import 'package:shoppingmall/states/rider_service.dart';
import 'package:shoppingmall/states/seler_service.dart';
import 'package:shoppingmall/utility/my_constant.dart';

final Map<String, WidgetBuilder> map ={
  '/authen': (BuildContext context) => Authen(),
  '/createAccount': (BuildContext context)=> CreateAccount(),
  'buyerService': (BuildContext context)=> BuyerService(),
  'selerService': (BuildContext context)=> SalerService(),
  'riderService': (BuildContext context)=> RiderService()
};

String? initialRoute;

void main(){
  initialRoute = MyConstant.rountAuthen;
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: MyConstant.appName,
      routes: map,
      initialRoute: initialRoute,
    );
  }
}

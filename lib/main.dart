import 'package:flutter/material.dart'; // นำเข้าแพ็คเกจที่ใช้สร้าง UI สำหรับแอปพลิเคชัน
import 'package:shoppingmall/states/authen.dart'; // นำเข้าหน้าจอการตรวจสอบสิทธิ์ (Authen)
import 'package:shoppingmall/states/buyer_service.dart'; // นำเข้าหน้าจอการบริการสำหรับผู้ซื้อ (BuyerService)
import 'package:shoppingmall/states/create_account.dart'; // นำเข้าหน้าจอการสร้างบัญชี (CreateAccount)
import 'package:shoppingmall/states/rider_service.dart'; // นำเข้าหน้าจอการบริการสำหรับผู้ส่งของ (RiderService)
import 'package:shoppingmall/states/seler_service.dart'; // นำเข้าหน้าจอการบริการสำหรับผู้ขาย (SalerService)
import 'package:shoppingmall/utility/my_constant.dart'; // นำเข้าไฟล์ที่มีค่าคงที่ที่ใช้ในแอป

// สร้างแผนที่ (Map) ที่เก็บเส้นทางและหน้าจอที่เกี่ยวข้อง
final Map<String, WidgetBuilder> map ={
  '/authen': (BuildContext context) => Authen(), // เส้นทางสำหรับหน้า Authen
  '/createAccount': (BuildContext context) => CreateAccount(), // เส้นทางสำหรับหน้า CreateAccount
  '/buyerService': (BuildContext context) => BuyerService(), // เส้นทางสำหรับหน้า BuyerService
  '/selerService': (BuildContext context) => SalerService(), // เส้นทางสำหรับหน้า SalerService
  '/riderService': (BuildContext context) => RiderService(), // เส้นทางสำหรับหน้า RiderService
};

// สร้างตัวแปร String ที่เป็นเส้นทางเริ่มต้นของแอป
String? initialRoute;

void main() {
  initialRoute = MyConstant.rountAuthen; // กำหนดเส้นทางเริ่มต้นเป็นหน้า Authen
  runApp(MyApp()); // รันแอปพลิเคชันโดยเรียกใช้งาน MyApp
}

// สร้างคลาส MyApp ที่เป็น StatelessWidget เพื่อสร้างแอปพลิเคชันหลัก
class MyApp extends StatelessWidget {
  const MyApp({super.key}); // คอนสตรัคเตอร์ที่เรียกใช้ super.key เพื่อเก็บคีย์ของ widget

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: MyConstant.appName, // กำหนดชื่อแอปจาก MyConstant
      routes: map, // กำหนดเส้นทางการนำทางจากแผนที่ (map)
      initialRoute: initialRoute, // กำหนดเส้นทางเริ่มต้นของแอป
    );
  }
}

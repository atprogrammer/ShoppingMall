import 'package:flutter/material.dart';

class MyConstant {
  // General
  static const String appName =
      'Shopping Mall'; // ชื่อของแอปพลิเคชันที่ใช้ทั่วทั้งแอป

  static String domain = 'http://192.168.1.37'; // โดเมนของเซิร์ฟเวอร์

  // Route
  static const String rountAuthen = '/authen'; // เส้นทางสำหรับหน้า Authen
  static const String rountCreateAccount =
      '/createAccount'; // เส้นทางสำหรับหน้า CreateAccount
  static const String rountBuyerService =
      '/buyerService'; // เส้นทางสำหรับหน้า BuyerService
  static const String rountSalerService =
      '/selerService'; // เส้นทางสำหรับหน้า SalerService
  static const String rountRiderService =
      '/riderService'; // เส้นทางสำหรับหน้า RiderService

  // Images
  static const String image1 = 'images/image1.png'; // ที่อยู่ไฟล์ของภาพ image1
  static const String image2 = 'images/image2.png'; // ที่อยู่ไฟล์ของภาพ image2
  static const String image3 = 'images/image3.png'; // ที่อยู่ไฟล์ของภาพ image3
  static const String image4 = 'images/image4.png'; // ที่อยู่ไฟล์ของภาพ image4
  static const String avatar = 'images/avatar.png'; // ที่อยู่ไฟล์ของภาพ avatar

  // Color
  static const Color primary = Color(0xff87861d); // สีหลักที่ใช้ในแอป
  static const Color dark = Color(0xff575900); // สีเข้มที่ใช้ในแอป
  static const Color light = Color(0xffb9b64e); // สีอ่อนที่ใช้ในแอป

  // Style
  // กำหนดรูปแบบตัวอักษรสำหรับหัวข้อระดับ 1 (ขนาด 24, หนา, สีเข้ม)
  TextStyle h1Style() => TextStyle(
        fontSize: 24,
        fontWeight: FontWeight.bold,
        color: dark,
      );

  // กำหนดรูปแบบตัวอักษรสำหรับหัวข้อระดับ 2 (ขนาด 18, หนาพอสมควร, สีเข้ม)
  TextStyle h2Style() => TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.w700,
        color: dark,
      );

  // กำหนดรูปแบบตัวอักษรสำหรับหัวข้อระดับ 3 (ขนาด 14, น้ำหนักปกติ, สีเข้ม)
  TextStyle h3Style() => TextStyle(
        fontSize: 14,
        fontWeight: FontWeight.normal,
        color: dark,
      );

  //Button
  ButtonStyle myButtonStyle() => ElevatedButton.styleFrom(
        backgroundColor: MyConstant.primary, // เปลี่ยนสีพื้นหลังของปุ่ม
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30), // กำหนดความโค้งมนของมุมปุ่ม
        ),
        foregroundColor: Colors.white, // กำหนดสีข้อความในปุ่มเป็นสีขาว
      );
}

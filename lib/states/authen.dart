import 'package:flutter/material.dart'; // นำเข้าแพ็คเกจที่ใช้สร้าง UI สำหรับแอปพลิเคชัน
import 'package:shoppingmall/utility/my_constant.dart'; // นำเข้าไฟล์ที่มีตัวแปรคงที่ที่ใช้ในแอป
import 'package:shoppingmall/widgets/show_image.dart'; // นำเข้าไฟล์ที่ใช้แสดงภาพ

// คลาส Authen เป็นคลาส StatefulWidget ที่จะสร้างหน้า UI สำหรับการตรวจสอบสิทธิ์
class Authen extends StatefulWidget {
  const Authen({super.key}); // คอนสตรัคเตอร์ที่เรียกใช้ super.key เพื่อเก็บคีย์ของ widget

  @override
  State<Authen> createState() => _AuthenState(); // สร้าง State ของหน้า Authen
}

// คลาส _AuthenState เป็นคลาสย่อยของ State ที่ใช้ควบคุมหน้า Authen
class _AuthenState extends State<Authen> {
  @override
  Widget build(BuildContext context) { // เมธอด build ใช้ในการสร้าง UI ของหน้า
    double size = MediaQuery.of(context).size.width; // เก็บความกว้างของหน้าจอในตัวแปร size
    return Scaffold(
      body: SafeArea(
        child: Container(
          width: size * 0.6, // กำหนดความกว้างของ Container เป็น 60% ของความกว้างหน้าจอ
          child: ShowImage(path: MyConstant.image1), // แสดงภาพจาก ShowImage โดยใช้ path จาก MyConstant
        ),
      ),
    );
  }
}

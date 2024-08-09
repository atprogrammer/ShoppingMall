import 'package:flutter/material.dart'; // นำเข้าแพ็คเกจที่ใช้สร้าง UI สำหรับแอปพลิเคชัน
import 'package:shoppingmall/utility/my_constant.dart'; // นำเข้าไฟล์ที่มีตัวแปรคงที่ที่ใช้ในแอป
import 'package:shoppingmall/widgets/show_image.dart'; // นำเข้าไฟล์ที่ใช้แสดงภาพ
import 'package:shoppingmall/widgets/show_title.dart'; // นำเข้าไฟล์ที่ใช้แสดงข้อความหรือหัวข้อ

// คลาส Authen เป็นคลาส StatefulWidget ที่จะสร้างหน้า UI สำหรับการตรวจสอบสิทธิ์
class Authen extends StatefulWidget {
  const Authen(
      {super.key}); // คอนสตรัคเตอร์ที่เรียกใช้ super.key เพื่อเก็บคีย์ของ widget

  @override
  State<Authen> createState() => _AuthenState(); // สร้าง State ของหน้า Authen
}

// คลาส _AuthenState เป็นคลาสย่อยของ State ที่ใช้ควบคุมหน้า Authen
class _AuthenState extends State<Authen> {
  @override
  Widget build(BuildContext context) {
    // เมธอด build ใช้ในการสร้าง UI ของหน้า
    double size = MediaQuery.of(context)
        .size
        .width; // เก็บความกว้างของหน้าจอในตัวแปร size
    return Scaffold(
      body: SafeArea(
        child: ListView(
          // ใช้ ListView เพื่อแสดงเนื้อหาหลายๆ ส่วนแบบเลื่อนขึ้นลงได้
          children: [
            buildImage(
                size), // เรียกใช้ฟังก์ชัน buildImage เพื่อแสดงภาพในหน้า UI
            buildAppName(), // เรียกใช้ฟังก์ชัน buildAppName เพื่อแสดงชื่อแอปในหน้า UI
          ],
        ),
      ),
    );
  }

  // ฟังก์ชัน buildAppName สร้างแถว (Row) ที่มีการจัดเรียงชื่อแอปให้อยู่กึ่งกลางของหน้าจอ
  Row buildAppName() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center, // จัดตำแหน่ง Row ให้อยู่กึ่งกลางแนวนอน
      children: [
        ShowTitle(
          title: MyConstant.appName, // แสดงชื่อแอปโดยใช้ค่า appName จาก MyConstant
          testStyle: MyConstant().h1Style(), // ใช้รูปแบบข้อความจากฟังก์ชัน h1Style ใน MyConstant
        ),
      ],
    );
  }

  // ฟังก์ชัน buildImage สร้างแถว (Row) ที่มีการจัดเรียงภาพให้อยู่กึ่งกลางของหน้าจอ
  Row buildImage(double size) {
    return Row(
      mainAxisAlignment:
          MainAxisAlignment.center, // จัดตำแหน่ง Row ให้อยู่กึ่งกลางแนวนอน
      children: [
        Container(
          width: size *
              0.6, // กำหนดความกว้างของ Container เป็น 60% ของความกว้างหน้าจอ
          child: ShowImage(
              path: MyConstant
                  .image1), // แสดงภาพจาก ShowImage โดยใช้ path จาก MyConstant
        ),
      ],
    );
  }
}

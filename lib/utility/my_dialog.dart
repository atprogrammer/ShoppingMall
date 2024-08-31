import 'dart:io'; // นำเข้าห้องสมุดสำหรับการทำงานกับระบบไฟล์และการจัดการไฟล์ในแอปพลิเคชัน

import 'package:flutter/material.dart'; // นำเข้าแพ็กเกจ Material Design เพื่อสร้าง UI ในแอป
import 'package:geolocator/geolocator.dart'; // นำเข้าแพ็กเกจ Geolocator เพื่อจัดการและเข้าถึงข้อมูลตำแหน่ง GPS
import 'package:shoppingmall/utility/my_constant.dart'; // นำเข้าไฟล์คอนสแตนต์ที่กำหนดค่าคงที่ต่าง ๆ ที่ใช้ในแอป
import 'package:shoppingmall/widgets/show_image.dart'; // นำเข้า widget สำหรับแสดงรูปภาพที่กำหนดเอง
import 'package:shoppingmall/widgets/show_title.dart'; // นำเข้า widget สำหรับแสดงข้อความพร้อมการจัดสไตล์ที่กำหนดเอง

class MyDialog {
  // คลาส MyDialog ใช้สำหรับแสดง dialog ที่ปรับแต่งได้ตามต้องการในแอปพลิเคชัน

  Future<Null> alertLocationService(BuildContext context, String title, String message) async {
    // ฟังก์ชัน alertLocationService ใช้สำหรับแสดง AlertDialog เมื่อ Location Service ถูกปิด
    // รับพารามิเตอร์ context สำหรับการกำหนดบริบทของหน้าจอ, title สำหรับหัวข้อของ AlertDialog, และ message สำหรับข้อความย่อย

    showDialog(
      context: context, // กำหนดบริบทของหน้าจอปัจจุบันที่ใช้แสดง AlertDialog
      builder: (context) => AlertDialog(
        // สร้าง AlertDialog พร้อมกับการกำหนดรูปร่างหน้าตา

        title: ListTile(
          // ส่วนหัวของ AlertDialog ใช้ ListTile เพื่อแสดงรูปภาพและข้อความ

          leading: ShowImage(path: MyConstant.image4), // แสดงรูปภาพที่ระบุใน MyConstant.image4 ทางด้านซ้ายของ ListTile
          title: ShowTitle(
              title: title,
              testStyle: MyConstant().h2Style()), // แสดงข้อความหัวเรื่องที่รับเข้ามาและใช้สไตล์ที่กำหนดใน MyConstant
          subtitle: ShowTitle(
              title: message,
              testStyle: MyConstant().h3Style()), // แสดงข้อความย่อยที่รับเข้ามาและใช้สไตล์ที่กำหนดใน MyConstant
        ),
        actions: [
          // กำหนดปุ่ม Action สำหรับ AlertDialog
          TextButton(
              onPressed: () async {
                // เมื่อผู้ใช้กดปุ่ม OK จะทำการเปิดการตั้งค่าตำแหน่งที่ตั้งของอุปกรณ์
                await Geolocator.openLocationSettings(); // เปิดหน้าต่างการตั้งค่าตำแหน่งที่ตั้งของอุปกรณ์
                exit(0); // ปิดแอปพลิเคชันหลังจากเปิดการตั้งค่าเรียบร้อยแล้ว
              },
              child: Text('OK')) // แสดงปุ่ม OK ที่เมื่อกดแล้วจะปิด AlertDialog และทำการเปิดการตั้งค่าตำแหน่งที่ตั้ง
        ],
      ),
    );
  }
}
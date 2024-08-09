import 'package:flutter/material.dart'; // นำเข้าแพ็คเกจที่ใช้สร้าง UI สำหรับแอปพลิเคชัน

// สร้างคลาส ShowImage ที่เป็น StatelessWidget เพื่อแสดงภาพจากแหล่งที่มา
class ShowImage extends StatelessWidget {
  final String path; // ประกาศตัวแปร path ที่จะเก็บตำแหน่งไฟล์ของภาพ
  const ShowImage({super.key, required this.path}); // คอนสตรัคเตอร์ที่รับค่า path และกำหนดคีย์ของ widget

  @override
  Widget build(BuildContext context) {
    return Image.asset(path); // สร้างวิดเจ็ต Image และแสดงภาพจากตำแหน่งที่ระบุใน path
  }
}
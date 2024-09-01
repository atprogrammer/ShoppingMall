import 'package:flutter/material.dart';

// คลาส ShowProgress ที่สืบทอดจาก StatefulWidget เพื่อสร้าง UI ที่แสดงการโหลดข้อมูล
class ShowProgress extends StatefulWidget {
  const ShowProgress({Key? key}) : super(key: key);

  @override
  _ShowProgressState createState() => _ShowProgressState();
}

// คลาส _ShowProgressState ที่ใช้ควบคุมสถานะของ ShowProgress
class _ShowProgressState extends State<ShowProgress> {
  @override
  Widget build(BuildContext context) {
    // สร้าง UI โดยแสดง CircularProgressIndicator อยู่ตรงกลางของหน้าจอ
    return Center(child: CircularProgressIndicator());
  }
}
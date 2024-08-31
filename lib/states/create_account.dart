import 'dart:async'; // นำเข้าไลบรารีสำหรับการใช้งาน Asynchronous (async/await) และ Future
import 'dart:io'; // นำเข้าไลบรารีสำหรับการจัดการไฟล์และการทำงานกับระบบไฟล์

import 'package:flutter/material.dart'; // นำเข้าแพ็กเกจ Material Design สำหรับการสร้าง UI
import 'package:image_picker/image_picker.dart'; // นำเข้าแพ็กเกจ ImagePicker สำหรับการเลือกรูปภาพจากกล้องหรือแกลเลอรี
import 'package:geolocator/geolocator.dart'; // นำเข้าแพ็กเกจ Geolocator สำหรับการจัดการตำแหน่งที่ตั้ง GPS
import 'package:shoppingmall/utility/my_constant.dart'; // นำเข้าไฟล์คอนสแตนต์ที่กำหนดค่าต่าง ๆ ของแอป
import 'package:shoppingmall/utility/my_dialog.dart'; // นำเข้า MyDialog ซึ่งเป็นคลาสสำหรับแสดง Dialog แบบกำหนดเอง
import 'package:shoppingmall/widgets/show_image.dart'; // นำเข้า widget สำหรับแสดงรูปภาพ
import 'package:shoppingmall/widgets/show_title.dart'; // นำเข้า widget สำหรับแสดงข้อความที่มีสไตล์

class CreateAccount extends StatefulWidget {
  // สร้างคลาส CreateAccount ซึ่งเป็น StatefulWidget สำหรับการสร้างหน้าสมัครบัญชีใหม่
  const CreateAccount({super.key}); // คอนสตรัคเตอร์ที่ใช้ key เป็น super key

  @override
  State<CreateAccount> createState() => _CreateAccountState();
  // กำหนด State ของ StatefulWidget โดยใช้ _CreateAccountState
}

class _CreateAccountState extends State<CreateAccount> {
  // คลาส _CreateAccountState เป็น State ของ CreateAccount
  String?
      typeUser; // ประกาศตัวแปรชนิด String สำหรับเก็บประเภทของผู้ใช้ (ผู้ซื้อ, ผู้ขาย, ผู้ส่ง) ซึ่งอาจเป็น null
  File?
      file; // ประกาศตัวแปรชนิด File สำหรับเก็บไฟล์รูปภาพที่ผู้ใช้เลือก ซึ่งอาจเป็น null

  @override
  void initState() {
    super
        .initState(); // เรียกใช้เมธอด initState ของคลาสแม่ (StatefulWidget) เพื่อทำการตั้งค่าเริ่มต้นเมื่อ Widget ถูกสร้างขึ้นครั้งแรก
    checkPermission(); // เรียกใช้เมธอด checkPermission
  }

Future<Null> checkPermission() async {
  // ฟังก์ชัน checkPermission ใช้ตรวจสอบและขออนุญาตเข้าถึงตำแหน่งที่ตั้ง
  // ผลลัพธ์เป็นแบบ Future<Null> เพราะจะทำงานแบบ asynchronous

  bool locationService;
  // ตัวแปร locationService ใช้เก็บสถานะของบริการตำแหน่งที่ตั้ง (เปิด/ปิด)

  LocationPermission locationPermission;
  // ตัวแปร locationPermission ใช้เก็บสถานะของการอนุญาตให้เข้าถึงตำแหน่งที่ตั้ง

  locationService = await Geolocator.isLocationServiceEnabled();
  // ตรวจสอบว่าบริการตำแหน่งที่ตั้งเปิดอยู่หรือไม่และเก็บผลลัพธ์ในตัวแปร locationService

  if (locationService) {
    // ถ้าบริการตำแหน่งที่ตั้งเปิดอยู่

    locationPermission = await Geolocator.checkPermission();
    // ตรวจสอบสถานะการอนุญาตให้เข้าถึงตำแหน่งที่ตั้งและเก็บในตัวแปร locationPermission

    if (locationPermission == LocationPermission.denied) {
      // ถ้าสถานะการอนุญาตถูกปฏิเสธ

      locationPermission = await Geolocator.requestPermission();
      // ขออนุญาตเข้าถึงตำแหน่งที่ตั้งจากผู้ใช้

      if (locationPermission == LocationPermission.deniedForever) {
        // ถ้าผู้ใช้ปฏิเสธการอนุญาตแบบถาวร

        MyDialog().alertLocationService(
            context, 'ไม่อนุญาติแชร์ Location', 'โปรดแชร์ Location');
        // แสดง AlertDialog เพื่อแจ้งว่าผู้ใช้ปฏิเสธการแชร์ตำแหน่ง
      } else {
        // ถ้าผู้ใช้ยินยอมให้การอนุญาต

        //Find LatLng
        // สามารถเริ่มค้นหาตำแหน่งละติจูดและลองจิจูดได้
      }
    } else {
      // ถ้าสถานะการอนุญาตไม่ถูกปฏิเสธ

      if (locationPermission == LocationPermission.deniedForever) {
        // ถ้าผู้ใช้ปฏิเสธการอนุญาตแบบถาวร

        MyDialog().alertLocationService(
            context, 'ไม่อนุญาติแชร์ Location', 'โปรดแชร์ Location');
        // แสดง AlertDialog เพื่อแจ้งว่าผู้ใช้ปฏิเสธการแชร์ตำแหน่ง
      } else {
        // ถ้าผู้ใช้ยินยอมให้การอนุญาต

        //Find LatLng
        // สามารถเริ่มค้นหาตำแหน่งละติจูดและลองจิจูดได้
      }
    }
  } else {
    // ถ้าบริการตำแหน่งที่ตั้งปิดอยู่

    MyDialog().alertLocationService(context, 'Location Service ปิดอยู่',
        'กรุณาเปิด Location Service ด้วยครับ');
    // แสดง AlertDialog เพื่อแจ้งว่าบริการตำแหน่งที่ตั้งปิดอยู่และขอให้ผู้ใช้เปิด
  }
}

  Widget build(BuildContext context) {
    // เมธอด build ใช้ในการสร้าง UI ของหน้า
    double size = MediaQuery.of(context)
        .size
        .width; // เก็บความกว้างของหน้าจอในตัวแปร size
    return Scaffold(
      appBar: AppBar(
        title: Text('Create New account'), // แสดงชื่อแถบด้านบนของแอป
        backgroundColor: MyConstant.primary, // กำหนดสีพื้นหลังของ AppBar
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        // เมื่อผู้ใช้แตะที่จอ ฟังก์ชันนี้จะทำการยกเลิกการโฟกัสของ TextFormField หรือคีย์บอร์ด
        behavior: HitTestBehavior.opaque,
        // กำหนดพฤติกรรมของ GestureDetector ให้สามารถตรวจจับการแตะที่จอได้ทั่วพื้นที่
        child: ListView(
          padding: EdgeInsets.all(
              16), // กำหนด Padding รอบ ๆ เนื้อหาใน ListView เป็น 16 พิกเซล
          children: [
            buidTitle(
                'ข้อมูลทั่วไป :'), // เรียกใช้ Widget สำหรับแสดง Title "ข้อมูลทั่วไป"
            buildName(size), // เรียกใช้ Widget สำหรับสร้างช่องกรอกชื่อ
            buidTitle(
                'ชนิดของ User :'), // เรียกใช้ Widget สำหรับแสดง Title "ชนิดของ User"
            buildRadioBuyer(
                size), // เรียกใช้ Widget สำหรับสร้าง RadioButton สำหรับ Buyer
            buildRadioSeller(
                size), // เรียกใช้ Widget สำหรับสร้าง RadioButton สำหรับ Seller
            buildRadioRider(
                size), // เรียกใช้ Widget สำหรับสร้าง RadioButton สำหรับ Rider
            buidTitle(
                'ข้อมูลพื้นฐาน :'), // เรียกใช้ Widget สำหรับแสดง Title "ข้อมูลพื้นฐาน"
            buildAddress(size), // เรียกใช้ Widget สำหรับสร้างช่องกรอกที่อยู่
            buildPhone(
                size), // เรียกใช้ Widget สำหรับสร้างช่องกรอกหมายเลขโทรศัพท์
            buildUser(size), // เรียกใช้ Widget สำหรับสร้างช่องกรอกชื่อผู้ใช้
            buildPassword(size), // เรียกใช้ Widget สำหรับสร้างช่องกรอกรหัสผ่าน
            buidTitle('รูปภาพ :'), // เรียกใช้ Widget สำหรับแสดง Title "รูปภาพ"
            buildSubTitle(), // เรียกใช้ Widget สำหรับแสดงคำอธิบายสั้น ๆ เกี่ยวกับรูปภาพ
            buildAvatar(
                size) // เรียกใช้ Widget สำหรับสร้าง UI เพื่อเลือกรูปภาพ Avatar
          ],
        ),
      ),
    );
  }

  // ฟังก์ชันเลือกภาพจากแหล่งที่มา (กล้องหรือแกลเลอรี)
  Future<Null> chooseImage(ImageSource source) async {
    try {
      // รอให้ผู้ใช้เลือกภาพและจำกัดความกว้างและความสูงของภาพ
      var result = await ImagePicker()
          .pickImage(source: source, maxWidth: 800, maxHeight: 800);
      setState(() {
        // เก็บไฟล์ภาพที่ผู้ใช้เลือกลงในตัวแปร file
        file = File(result!.path);
      });
    } catch (e) {
      // ถ้ามีข้อผิดพลาดเกิดขึ้น จะทำให้โปรแกรมไม่ล้ม
    }
  }

  // สร้าง UI สำหรับการเลือกและแสดงภาพ Avatar
  Row buildAvatar(double size) {
    return Row(
      crossAxisAlignment:
          CrossAxisAlignment.end, // จัดเรียง widget ให้แนบกับด้านล่างของ Row
      mainAxisAlignment: MainAxisAlignment
          .spaceBetween, // กระจาย widget ให้มีพื้นที่เท่ากันในแนวนอน
      children: [
        // ปุ่มสำหรับเลือกภาพจากกล้อง
        IconButton(
          onPressed: () {
            chooseImage(ImageSource
                .camera); // เมื่อกดปุ่มจะเรียกฟังก์ชัน chooseImage โดยใช้แหล่งที่มาจากกล้อง
          },
          icon: Icon(
            Icons.add_a_photo, // ไอคอนกล้อง
            size: 40, // ขนาดของไอคอน
            color: MyConstant.dark, // สีของไอคอน
          ),
        ),
        // กล่องสำหรับแสดงภาพ Avatar ที่ผู้ใช้เลือก หรือแสดงภาพ Default
        Container(
          margin: EdgeInsets.symmetric(
              vertical: 25), // ระยะห่างระหว่างขอบบนและล่างของกล่อง
          width:
              size * 0.5, // ความกว้างของกล่องเป็นครึ่งหนึ่งของความกว้างหน้าจอ
          child: file == null
              ? ShowImage(
                  path: MyConstant
                      .avatar) // แสดงภาพ Default ถ้าไม่มีภาพที่ผู้ใช้เลือก
              : Image.file(file!), // แสดงภาพที่ผู้ใช้เลือก
        ),
        // ปุ่มสำหรับเลือกภาพจากแกลเลอรี
        IconButton(
          onPressed: () {
            chooseImage(ImageSource
                .gallery); // เมื่อกดปุ่มจะเรียกฟังก์ชัน chooseImage โดยใช้แหล่งที่มาจากแกลเลอรี
          },
          icon: Icon(
            Icons.add_photo_alternate, // ไอคอนแกลเลอรี
            size: 40, // ขนาดของไอคอน
            color: MyConstant.dark, // สีของไอคอน
          ),
        ),
      ],
    );
  }

  // สร้าง UI สำหรับแสดงคำอธิบายสั้น ๆ เกี่ยวกับภาพ Avatar
  ShowTitle buildSubTitle() {
    return ShowTitle(
      title:
          'เป็นรูปภาพที่แสดงความเป็นตัวตนของ User (แต่ถ้าไม่สะดวกแชร์ เราจะแสดงภาพ Default แทน)', // ข้อความคำอธิบาย
      testStyle: MyConstant().h3Style(), // สไตล์ข้อความที่ใช้จาก MyConstant
    );
  }

  // สร้าง RadioButton สำหรับเลือกประเภทของผู้ใช้เป็น Buyer (ผู้ซื้อ)
  Widget buildRadioBuyer(double size) {
    return Row(
      mainAxisAlignment:
          MainAxisAlignment.center, // จัดวาง RadioListTile ให้อยู่ตรงกลาง
      children: [
        Container(
          width:
              size * 0.6, // ความกว้างของ Container เป็น 60% ของความกว้างหน้าจอ
          child: RadioListTile(
            value: 'buyer', // กำหนดค่าของ RadioButton เป็น 'buyer'
            groupValue:
                typeUser, // กำหนดค่ากลุ่มสำหรับ RadioButton เพื่อให้สามารถเลือกได้เพียงตัวเดียว
            onChanged: (value) {
              setState(() {
                typeUser = value
                    as String; // เมื่อมีการเลือก จะตั้งค่าตัวแปร typeUser เป็นค่าใหม่
              });
            },
            title: ShowTitle(
              title: "ผู้ซื้อ (Buyer)", // ข้อความที่จะแสดงข้าง RadioButton
              testStyle:
                  MyConstant().h3Style(), // สไตล์ข้อความที่ใช้จาก MyConstant
            ),
          ),
        ),
      ],
    );
  }

  // สร้าง RadioButton สำหรับเลือกประเภทของผู้ใช้เป็น Seller (ผู้ขาย)
  Widget buildRadioSeller(double size) {
    return Row(
      mainAxisAlignment:
          MainAxisAlignment.center, // จัดวาง RadioListTile ให้อยู่ตรงกลาง
      children: [
        Container(
          width:
              size * 0.6, // ความกว้างของ Container เป็น 60% ของความกว้างหน้าจอ
          child: RadioListTile(
            value: 'seller', // กำหนดค่าของ RadioButton เป็น 'seller'
            groupValue:
                typeUser, // กำหนดค่ากลุ่มสำหรับ RadioButton เพื่อให้สามารถเลือกได้เพียงตัวเดียว
            onChanged: (value) {
              setState(() {
                typeUser = value
                    as String; // เมื่อมีการเลือก จะตั้งค่าตัวแปร typeUser เป็นค่าใหม่
              });
            },
            title: ShowTitle(
              title: "ผู้ขาย (Seller)", // ข้อความที่จะแสดงข้าง RadioButton
              testStyle:
                  MyConstant().h3Style(), // สไตล์ข้อความที่ใช้จาก MyConstant
            ),
          ),
        ),
      ],
    );
  }

  // สร้าง RadioButton สำหรับเลือกประเภทของผู้ใช้เป็น Rider (ผู้ส่ง)
  Widget buildRadioRider(double size) {
    return Row(
      mainAxisAlignment:
          MainAxisAlignment.center, // จัดวาง RadioListTile ให้อยู่ตรงกลาง
      children: [
        Container(
          width:
              size * 0.6, // ความกว้างของ Container เป็น 60% ของความกว้างหน้าจอ
          child: RadioListTile(
            value: 'rider', // กำหนดค่าของ RadioButton เป็น 'rider'
            groupValue:
                typeUser, // กำหนดค่ากลุ่มสำหรับ RadioButton เพื่อให้สามารถเลือกได้เพียงตัวเดียว
            onChanged: (value) {
              setState(() {
                typeUser = value
                    as String; // เมื่อมีการเลือก จะตั้งค่าตัวแปร typeUser เป็นค่าใหม่
              });
            },
            title: ShowTitle(
              title: "ผู้ส่ง (Rider)", // ข้อความที่จะแสดงข้าง RadioButton
              testStyle:
                  MyConstant().h3Style(), // สไตล์ข้อความที่ใช้จาก MyConstant
            ),
          ),
        ),
      ],
    );
  }

  // สร้าง Title สำหรับแต่ละส่วนของแบบฟอร์ม
  Widget buidTitle(String title) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16), // ระยะห่างบนและล่างของ Title
      child: ShowTitle(
        title: title, // ข้อความ Title ที่จะใช้แสดง
        testStyle:
            MyConstant().h2Style(), // สไตล์ข้อความ Title ที่ใช้จาก MyConstant
      ),
    );
  }

  // ฟังก์ชัน buildUser สร้างแถว (Row) ที่มีการจัดเรียงช่องกรอกชื่อผู้ใช้ให้อยู่กึ่งกลางของหน้าจอ
  Widget buildName(double size) {
    return Row(
      mainAxisAlignment:
          MainAxisAlignment.center, // จัดตำแหน่ง Row ให้อยู่กึ่งกลางแนวนอน
      children: [
        Container(
          margin: EdgeInsets.only(top: 16), // กำหนดระยะห่างด้านบนของ Container
          width: size *
              0.75, // กำหนดความกว้างของ Container เป็น 65% ของความกว้างหน้าจอ
          child: TextFormField(
            decoration: InputDecoration(
              labelStyle: MyConstant()
                  .h3Style(), // ใช้รูปแบบข้อความจากฟังก์ชัน h3Style ใน MyConstant
              labelText: 'Name :', // ป้ายชื่อสำหรับช่องกรอกข้อมูล
              prefixIcon: Icon(
                Icons.fingerprint, // ไอคอนหน้าช่องกรอกข้อมูล
                color: MyConstant.dark, // กำหนดสีของไอคอนจาก MyConstant
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: MyConstant
                        .dark), // กำหนดสีของเส้นขอบช่องกรอกข้อมูลเมื่อไม่ได้ถูกโฟกัส
                borderRadius:
                    BorderRadius.circular(30), // กำหนดความโค้งมนของมุมเส้นขอบ
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: MyConstant
                        .light), // กำหนดสีของเส้นขอบช่องกรอกข้อมูลเมื่อถูกโฟกัส
                borderRadius: BorderRadius.circular(
                    30), // กำหนดความโค้งมนของมุมเส้นขอบเมื่อถูกโฟกัส
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ฟังก์ชัน buildAddress สร้างแถว (Row) ที่มีการจัดเรียงช่องกรอกชื่อผู้ใช้ให้อยู่กึ่งกลางของหน้าจอ
  Widget buildAddress(double size) {
    return Row(
      mainAxisAlignment:
          MainAxisAlignment.center, // จัดตำแหน่ง Row ให้อยู่กึ่งกลางแนวนอน
      children: [
        Container(
          margin: EdgeInsets.only(top: 16), // กำหนดระยะห่างด้านบนของ Container
          width: size *
              0.75, // กำหนดความกว้างของ Container เป็น 65% ของความกว้างหน้าจอ
          child: TextFormField(
            maxLines: 3,
            decoration: InputDecoration(
              hintText: 'Address :',
              hintStyle: MyConstant().h3Style(),
              prefixIcon: Padding(
                padding: const EdgeInsets.fromLTRB(0, 0, 0, 60),
                child: Icon(
                  Icons.home, // ไอคอนหน้าช่องกรอกข้อมูล
                  color: MyConstant.dark, // กำหนดสีของไอคอนจาก MyConstant
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: MyConstant
                        .dark), // กำหนดสีของเส้นขอบช่องกรอกข้อมูลเมื่อไม่ได้ถูกโฟกัส
                borderRadius:
                    BorderRadius.circular(30), // กำหนดความโค้งมนของมุมเส้นขอบ
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: MyConstant
                        .light), // กำหนดสีของเส้นขอบช่องกรอกข้อมูลเมื่อถูกโฟกัส
                borderRadius: BorderRadius.circular(
                    30), // กำหนดความโค้งมนของมุมเส้นขอบเมื่อถูกโฟกัส
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ฟังก์ชัน buildPhone สร้างแถว (Row) ที่มีการจัดเรียงช่องกรอกชื่อผู้ใช้ให้อยู่กึ่งกลางของหน้าจอ
  Widget buildPhone(double size) {
    return Row(
      mainAxisAlignment:
          MainAxisAlignment.center, // จัดตำแหน่ง Row ให้อยู่กึ่งกลางแนวนอน
      children: [
        Container(
          margin: EdgeInsets.only(top: 16), // กำหนดระยะห่างด้านบนของ Container
          width: size *
              0.75, // กำหนดความกว้างของ Container เป็น 65% ของความกว้างหน้าจอ
          child: TextFormField(
            decoration: InputDecoration(
              labelStyle: MyConstant()
                  .h3Style(), // ใช้รูปแบบข้อความจากฟังก์ชัน h3Style ใน MyConstant
              labelText: 'Phone :', // ป้ายชื่อสำหรับช่องกรอกข้อมูล
              prefixIcon: Icon(
                Icons.phone, // ไอคอนหน้าช่องกรอกข้อมูล
                color: MyConstant.dark, // กำหนดสีของไอคอนจาก MyConstant
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: MyConstant
                        .dark), // กำหนดสีของเส้นขอบช่องกรอกข้อมูลเมื่อไม่ได้ถูกโฟกัส
                borderRadius:
                    BorderRadius.circular(30), // กำหนดความโค้งมนของมุมเส้นขอบ
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: MyConstant
                        .light), // กำหนดสีของเส้นขอบช่องกรอกข้อมูลเมื่อถูกโฟกัส
                borderRadius: BorderRadius.circular(
                    30), // กำหนดความโค้งมนของมุมเส้นขอบเมื่อถูกโฟกัส
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ฟังก์ชัน buildUser สร้างแถว (Row) ที่มีการจัดเรียงช่องกรอกชื่อผู้ใช้ให้อยู่กึ่งกลางของหน้าจอ
  Widget buildUser(double size) {
    return Row(
      mainAxisAlignment:
          MainAxisAlignment.center, // จัดตำแหน่ง Row ให้อยู่กึ่งกลางแนวนอน
      children: [
        Container(
          margin: EdgeInsets.only(top: 16), // กำหนดระยะห่างด้านบนของ Container
          width: size *
              0.75, // กำหนดความกว้างของ Container เป็น 65% ของความกว้างหน้าจอ
          child: TextFormField(
            decoration: InputDecoration(
              labelStyle: MyConstant()
                  .h3Style(), // ใช้รูปแบบข้อความจากฟังก์ชัน h3Style ใน MyConstant
              labelText: 'User :', // ป้ายชื่อสำหรับช่องกรอกข้อมูล
              prefixIcon: Icon(
                Icons.perm_identity, // ไอคอนหน้าช่องกรอกข้อมูล
                color: MyConstant.dark, // กำหนดสีของไอคอนจาก MyConstant
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: MyConstant
                        .dark), // กำหนดสีของเส้นขอบช่องกรอกข้อมูลเมื่อไม่ได้ถูกโฟกัส
                borderRadius:
                    BorderRadius.circular(30), // กำหนดความโค้งมนของมุมเส้นขอบ
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: MyConstant
                        .light), // กำหนดสีของเส้นขอบช่องกรอกข้อมูลเมื่อถูกโฟกัส
                borderRadius: BorderRadius.circular(
                    30), // กำหนดความโค้งมนของมุมเส้นขอบเมื่อถูกโฟกัส
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ฟังก์ชัน buildUser สร้างแถว (Row) ที่มีการจัดเรียงช่องกรอกชื่อผู้ใช้ให้อยู่กึ่งกลางของหน้าจอ
  Widget buildPassword(double size) {
    return Row(
      mainAxisAlignment:
          MainAxisAlignment.center, // จัดตำแหน่ง Row ให้อยู่กึ่งกลางแนวนอน
      children: [
        Container(
          margin: EdgeInsets.only(top: 16), // กำหนดระยะห่างด้านบนของ Container
          width: size *
              0.75, // กำหนดความกว้างของ Container เป็น 65% ของความกว้างหน้าจอ
          child: TextFormField(
            decoration: InputDecoration(
              labelStyle: MyConstant()
                  .h3Style(), // ใช้รูปแบบข้อความจากฟังก์ชัน h3Style ใน MyConstant
              labelText: 'Password :', // ป้ายชื่อสำหรับช่องกรอกข้อมูล
              prefixIcon: Icon(
                Icons.lock, // ไอคอนหน้าช่องกรอกข้อมูล
                color: MyConstant.dark, // กำหนดสีของไอคอนจาก MyConstant
              ),
              enabledBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: MyConstant
                        .dark), // กำหนดสีของเส้นขอบช่องกรอกข้อมูลเมื่อไม่ได้ถูกโฟกัส
                borderRadius:
                    BorderRadius.circular(30), // กำหนดความโค้งมนของมุมเส้นขอบ
              ),
              focusedBorder: OutlineInputBorder(
                borderSide: BorderSide(
                    color: MyConstant
                        .light), // กำหนดสีของเส้นขอบช่องกรอกข้อมูลเมื่อถูกโฟกัส
                borderRadius: BorderRadius.circular(
                    30), // กำหนดความโค้งมนของมุมเส้นขอบเมื่อถูกโฟกัส
              ),
            ),
          ),
        ),
      ],
    );
  }
}

import 'dart:async'; // นำเข้าไลบรารีสำหรับการใช้งาน Asynchronous (async/await) และ Future
import 'dart:io'; // นำเข้าไลบรารีสำหรับการจัดการไฟล์และการทำงานกับระบบไฟล์

import 'package:dio/dio.dart';
import 'package:flutter/material.dart'; // นำเข้าแพ็กเกจ Material Design สำหรับการสร้าง UI
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:image_picker/image_picker.dart'; // นำเข้าแพ็กเกจ ImagePicker สำหรับการเลือกรูปภาพจากกล้องหรือแกลเลอรี
import 'package:geolocator/geolocator.dart'; // นำเข้าแพ็กเกจ Geolocator สำหรับการจัดการตำแหน่งที่ตั้ง GPS
import 'package:shoppingmall/utility/my_constant.dart'; // นำเข้าไฟล์คอนสแตนต์ที่กำหนดค่าต่าง ๆ ของแอป
import 'package:shoppingmall/utility/my_dialog.dart'; // นำเข้า MyDialog ซึ่งเป็นคลาสสำหรับแสดง Dialog แบบกำหนดเอง
import 'package:shoppingmall/widgets/show_image.dart'; // นำเข้า widget สำหรับแสดงรูปภาพ
import 'package:shoppingmall/widgets/show_progress.dart';
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
  double? lat,
      lng; // ประกาศตัวแปรชนิด double สำหรับเก็บค่า latitude และ longitude ของผู้ใช้ ซึ่งอาจเป็น null

  final formKey = GlobalKey<
      FormState>(); // กำหนดตัวแปร FormKey สำหรับใช้กับ Form ของ CreateAccount

  TextEditingController nameController =
      TextEditingController(); // กำหนดตัวแปร TextEditingController สำหรับเก็บค่าชื่อผู้ใช้
  TextEditingController addressController =
      TextEditingController(); // กำหนดตัวแปร TextEditingController สำหรับเก็บค่าที่อยู่ผู้ใช้
  TextEditingController userController =
      TextEditingController(); // กำหนดตัวแปร TextEditingController สำหรับเก็บ User ของชื่อผู้ใช้
  TextEditingController passwordController =
      TextEditingController(); // กำหนดตัวแปร TextEditingController สำหรับเก็บ Password ของชื่อผู้ใช้
  TextEditingController phoneController =
      TextEditingController(); // กำหนดตัวแปร TextEditingController สำหรับเก็บ Phone ของชื่อผู้ใช้
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

          findLatLng(); // ค้นหา LatLng
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

          findLatLng(); // ค้นหา LatLng
        }
      }
    } else {
      // ถ้าบริการตำแหน่งที่ตั้งปิดอยู่

      MyDialog().alertLocationService(context, 'Location Service ปิดอยู่',
          'กรุณาเปิด Location Service ด้วยครับ');
      // แสดง AlertDialog เพื่อแจ้งว่าบริการตำแหน่งที่ตั้งปิดอยู่และขอให้ผู้ใช้เปิด
    }
  }

  Future<Null> findLatLng() async {
    // คำสั่ง findLocation จะทำการค้นหาตำแหน่งละติจูดและลองจิจูดของผู้ใช้
    print('find => work');
    Position? position = await findLocation();
    setState(() {
      lat = position!.latitude; // เก็บตำแหน่งละติจูดของผู้ใช้
      lng = position.longitude; // เก็บตำแหน่งลองจิจูดของผู้ใช้
    });
  }

  Future<Position?> findLocation() async {
    // คำสั่งหาตำแหน่งของผู้ใช้
    Position position;
    try {
      position =
          await Geolocator.getCurrentPosition(); // คำสั่งหาตำแหน่งของผู้ใช้
      return position;
    } catch (e) {
      return null; // ถ้าหาตำแหน่งไม่ได้จะ return null
    }
  }

  Widget build(BuildContext context) {
    // เมธอด build ใช้ในการสร้าง UI ของหน้า
    double size = MediaQuery.of(context)
        .size
        .width; // เก็บความกว้างของหน้าจอในตัวแปร size
    return Scaffold(
      appBar: AppBar(
        actions: [buildCreateNewAccount()],
        title: Text('Create New account'), // แสดงชื่อแถบด้านบนของแอป
        backgroundColor: MyConstant.primary, // กำหนดสีพื้นหลังของ AppBar
      ),
      body: GestureDetector(
        onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
        // เมื่อผู้ใช้แตะที่จอ ฟังก์ชันนี้จะทำการยกเลิกการโฟกัสของ TextFormField หรือคีย์บอร์ด
        behavior: HitTestBehavior.opaque,
        // กำหนดพฤติกรรมของ GestureDetector ให้สามารถตรวจจับการแตะที่จอได้ทั่วพื้นที่
        child: Form(
          key:
              formKey, // สร้าง Form ของแอป โดยนำ formKey มาล้อมไว้ไว้ใน Form ของแอป
          child: SingleChildScrollView(
            // สร้าง SingleChildScrollView
            child: Column(
              children: [
                buildTitle(
                    'ข้อมูลทั่วไป :'), // เรียกใช้ Widget สำหรับแสดง Title "ข้อมูลทั่วไป"
                buildName(size), // เรียกใช้ Widget สำหรับสร้างช่องกรอกชื่อ
                buildTitle(
                    'ชนิดของ User :'), // เรียกใช้ Widget สำหรับแสดง Title "ชนิดของ User"
                buildRadioBuyer(
                    size), // เรียกใช้ Widget สำหรับสร้าง RadioButton สำหรับ Buyer
                buildRadioSeller(
                    size), // เรียกใช้ Widget สำหรับสร้าง RadioButton สำหรับ Seller
                buildRadioRider(
                    size), // เรียกใช้ Widget สำหรับสร้าง RadioButton สำหรับ Rider
                buildTitle(
                    'ข้อมูลพื้นฐาน :'), // เรียกใช้ Widget สำหรับแสดง Title "ข้อมูลพื้นฐาน"
                buildAddress(
                    size), // เรียกใช้ Widget สำหรับสร้างช่องกรอกที่อยู่
                buildPhone(
                    size), // เรียกใช้ Widget สำหรับสร้างช่องกรอกหมายเลขโทรศัพท์
                buildUser(
                    size), // เรียกใช้ Widget สำหรับสร้างช่องกรอกชื่อผู้ใช้
                buildPassword(
                    size), // เรียกใช้ Widget สำหรับสร้างช่องกรอกรหัสผ่าน
                buildTitle(
                    'รูปภาพ :'), // เรียกใช้ Widget สำหรับแสดง Title "รูปภาพ"
                buildSubTitle(), // เรียกใช้ Widget สำหรับแสดงคำอธิบายสั้น ๆ เกี่ยวกับรูปภาพ
                buildAvatar(
                    size), // เรียกใช้ Widget สำหรับสร้าง UI เพื่อเลือกรูปภาพ Avatar
                buildTitle(
                    'แสดงพิกัดที่คุณอยู่'), // เรียกใช้ Widget สำหรับแสดง Title "แสดงพิกัดที่คุณอยู่"
                buildMap(), // แสดงค่าที่ได้จากการคำนวณพิกัดที่คุณอยู่
              ],
            ),
          ),
        ),
      ),
    );
  }

  IconButton buildCreateNewAccount() {
    // สร้าง Button สำหรับสร้าง Account
    return IconButton(
      onPressed: () {
        if (formKey.currentState!.validate()) {
          // ตรวจสอบว่า Form ถูกกรอกครบหรือไม่
          if (typeUser == null) {
            // ถ้ายังไม่เลือก TypeUser ให้แสดง Dialog
            MyDialog().normalDialog(context, "ยังไม่ได้เลือก TypeUser",
                "กรุณาเลือก TypeUser"); // แสดง Dialog เตือน
          } else {
            print("Process Insert to Database");
            uploadPictureAndInsertData();
          }
        }
      },
      icon: Icon(Icons.cloud_upload),
    );
  }

  Future<Null> uploadPictureAndInsertData() async{
    String name = nameController.text;
    String address = addressController.text;
    String phone = phoneController.text;
    String user = userController.text;
    String password = passwordController.text;

    //print('## name = $name, address = $address, phone = $phone, user = $user , password= $password');
    String path = '${MyConstant.domain}/shoppingmallAPI/getUserWhereUser.php?isAdd=true&user=$user';
    await Dio().get(path).then((value) => 
     print('## value ==>> $value'));
  }

  Set<Marker> setMarker() => <Marker>[
        Marker(
          markerId: MarkerId('id'), // เป็น ID ของ Marker
          position: LatLng(lat!, lng!), // เป็น LatLng ของตำแหน่งที่คุณอยู่
          infoWindow: InfoWindow(
              title: 'คุณอยู่ที่นี่', snippet: 'Lat = $lat, Lng = $lng'),
        ),
      ].toSet(); // สร้าง Set ของ Marker

  // Widget สำหรับแสดงพิกัดที่คุณอยู่
  Widget buildMap() => Container(
        width: double
            .infinity, // กำหนดให้ Container ใช้ความกว้างเต็มที่ตามที่มีอยู่
        height: 200, // กำหนดความสูงของ Container เป็น 200 พิกเซล
        child: lat == null
            ? ShowProgress() // ถ้า lat เป็น null จะแสดงตัวบอกสถานะการโหลด (ShowProgress)
            : //Text('Lat = $lat , Lng = $lng'));
            GoogleMap(
                initialCameraPosition: CameraPosition(
                  target: LatLng(lat!, lng!), // ระบุค่า LatLng ที่ต้องการแสดง
                  zoom: 16, // ระบุขนาด zoom เป็น 16 พิกเซล
                ),
                onMapCreated: (controller) => {},
                markers: setMarker(), // ระบุ Set ของ Marker
              ), // สร้าง GoogleMap โดยใช้ค่าที่ได้จากการคำนวณพิกัดที่คุณอยู่
      );
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
  Widget buildTitle(String title) {
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
            controller: nameController, // ผูกข้อมูลกับตัวแปร Controller
            validator: (value) {
              //ตรวจสอบการคียร์ข้อมูล
              if (value!.isEmpty) {
                // ถ้า TextFormField ไม่มีข้อความ
                return 'กรุณากรอก Name ด้วยครับ'; //ส่งข้อความแจ้งเตือน
              } else {}
            },
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
            controller: addressController, // ผูกข้อมูลกับตัวแปร Controller
            validator: (value) {
              //ตรวจสอบการคียร์ข้อมูล
              if (value!.isEmpty) {
                // ถ้า TextFormField ไม่มีข้อความ
                return 'กรุณากรอก Address ด้วยครับ'; //ส่งข้อความแจ้งเตือน
              } else {}
            },
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
            controller: phoneController, // ผูกข้อมูลกับตัวแปร Controller
            keyboardType:
                TextInputType.phone, // กำหนดประเภทของ Keyboard แบบตัวเลข
            validator: (value) {
              //ตรวจสอบการคียร์ข้อมูล
              if (value!.isEmpty) {
                // ถ้า TextFormField ไม่มีข้อความ
                return 'กรุณากรอก Phone ด้วยครับ'; //ส่งข้อความแจ้งเตือน
              } else {}
            },
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
            controller: userController, // ผูกข้อมูลกับตัวแปร Controller
            validator: (value) {
              //ตรวจสอบการคียร์ข้อมูล
              if (value!.isEmpty) {
                // ถ้า TextFormField ไม่มีข้อความ
                return 'กรุณากรอก Username ด้วยครับ'; //ส่งข้อความแจ้งเตือน
              } else {}
            },
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
             controller: passwordController, // ผูกข้อมูลกับตัวแปร Controller
            validator: (value) {
              //ตรวจสอบการคียร์ข้อมูล
              if (value!.isEmpty) {
                // ถ้า TextFormField ไม่มีข้อความ
                return 'กรุณากรอก Password ด้วยครับ'; //ส่งข้อความแจ้งเตือน
              } else {}
            },
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

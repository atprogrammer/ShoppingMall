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
  bool statusRedEye = true; // สถานะสำหรับการแสดงหรือซ่อนรหัสผ่าน

  @override
  Widget build(BuildContext context) {
    // เมธอด build ใช้ในการสร้าง UI ของหน้า
    double size = MediaQuery.of(context)
        .size
        .width; // เก็บความกว้างของหน้าจอในตัวแปร size
    return Scaffold(
      body: SafeArea(
        child: GestureDetector(
          onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          // เมื่อผู้ใช้แตะที่จอ ฟังก์ชันนี้จะทำการยกเลิกการโฟกัสของ TextFormField หรือคีย์บอร์ด
          behavior: HitTestBehavior.opaque,
          // กำหนดพฤติกรรมของ GestureDetector ให้สามารถตรวจจับการแตะที่จอได้ทั่วพื้นที่
          child: ListView(
            // ใช้ ListView เพื่อแสดงเนื้อหาหลายๆ ส่วนแบบเลื่อนขึ้นลงได้
            children: [
              buildImage(
                  size), // เรียกใช้ฟังก์ชัน buildImage เพื่อแสดงภาพในหน้า UI
              buildAppName(), // เรียกใช้ฟังก์ชัน buildAppName เพื่อแสดงชื่อแอปในหน้า UI
              buildUser(
                  size), // เรียกใช้ฟังก์ชัน buildUser เพื่อแสดงช่องกรอกชื่อผู้ใช้
              buildPassWord(
                  size), // เรียกใช้ฟังก์ชัน buildPassWord เพื่อแสดงช่องกรอกรหัสผ่าน
              buidLogin(
                  size), // เรียกใช้ฟังก์ชัน buildbuidLogin เพื่อแสดงปุ่มกดล๊อกอิน
              buildCreateAccount(),
            ],
          ),
        ),
      ),
    );
  }

  Row buidLogin(double size) {
    // ฟังก์ชัน buidLogin สร้างแถว (Row) ที่มีการจัดเรียงปุ่มเข้าสู่ระบบให้อยู่กึ่งกลางของหน้าจอ
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      // จัดตำแหน่ง Row ให้อยู่กึ่งกลางแนวนอน
      children: [
        Container(
          margin: EdgeInsets.symmetric(vertical: 16),
          // กำหนดระยะห่างด้านบนและล่างของ Container
          width: size * 0.65,
          // กำหนดความกว้างของ Container เป็น 65% ของความกว้างหน้าจอ
          child: ElevatedButton(
            // สร้างปุ่ม ElevatedButton
            style: MyConstant().myButtonStyle(),
            // ใช้รูปแบบปุ่มจากฟังก์ชัน myButtonStyle ใน MyConstant
            onPressed: () {},
            // ฟังก์ชันที่จะถูกเรียกเมื่อปุ่มถูกกด
            child: Text('Login'),
            // ข้อความที่แสดงบนปุ่ม
          ),
        ),
      ],
    );
  }

  // ฟังก์ชัน buildUser สร้างแถว (Row) ที่มีการจัดเรียงช่องกรอกชื่อผู้ใช้ให้อยู่กึ่งกลางของหน้าจอ
  Row buildUser(double size) {
    return Row(
      mainAxisAlignment:
          MainAxisAlignment.center, // จัดตำแหน่ง Row ให้อยู่กึ่งกลางแนวนอน
      children: [
        Container(
          margin: EdgeInsets.only(top: 16), // กำหนดระยะห่างด้านบนของ Container
          width: size *
              0.65, // กำหนดความกว้างของ Container เป็น 65% ของความกว้างหน้าจอ
          child: TextFormField(
            decoration: InputDecoration(
              labelStyle: MyConstant()
                  .h3Style(), // ใช้รูปแบบข้อความจากฟังก์ชัน h3Style ใน MyConstant
              labelText: 'User :', // ป้ายชื่อสำหรับช่องกรอกข้อมูล
              prefixIcon: Icon(
                Icons.account_circle, // ไอคอนหน้าช่องกรอกข้อมูล
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

  // ฟังก์ชัน buildPassWord สร้างแถว (Row) ที่มีการจัดเรียงช่องกรอกรหัสผ่านให้อยู่กึ่งกลางของหน้าจอ
  Row buildPassWord(double size) {
    return Row(
      mainAxisAlignment:
          MainAxisAlignment.center, // จัดตำแหน่ง Row ให้อยู่กึ่งกลางแนวนอน
      children: [
        Container(
          margin: EdgeInsets.only(top: 16), // กำหนดระยะห่างด้านบนของ Container
          width: size *
              0.65, // กำหนดความกว้างของ Container เป็น 65% ของความกว้างหน้าจอ
          child: TextFormField(
            obscureText:
                statusRedEye, // กำหนดการแสดงหรือซ่อนข้อความในช่องกรอกรหัสผ่าน
            decoration: InputDecoration(
              suffixIcon: IconButton(
                onPressed: () {
                  setState(() {
                    statusRedEye =
                        !statusRedEye; // เมื่อคลิกที่ไอคอนแสดงหรือซ่อนข้อความจะเปลี่ยนสถานะ
                  });
                },
                icon:
                    statusRedEye // ตรวจสอบค่า statusRedEye ว่ามีค่าเป็น true หรือ false เพื่อเลือกแสดงไอคอนที่เหมาะสม
                        ? Icon(
                            // ถ้า statusRedEye เป็น true จะแสดงไอคอนที่ใช้ในการแสดงรหัสผ่าน
                            Icons
                                .remove_red_eye, // ไอคอนสำหรับแสดงรหัสผ่าน (ตาเปิด)
                            color: MyConstant
                                .dark, // กำหนดสีของไอคอนตามสีใน MyConstant
                          )
                        : Icon(
                            // ถ้า statusRedEye เป็น false จะแสดงไอคอนที่ใช้ในการซ่อนรหัสผ่าน
                            Icons
                                .remove_red_eye_outlined, // ไอคอนสำหรับซ่อนรหัสผ่าน (ตาขีด)
                            color: MyConstant
                                .dark, // กำหนดสีของไอคอนตามสีใน MyConstant
                          ),
              ),
              labelStyle: MyConstant()
                  .h3Style(), // ใช้รูปแบบข้อความจากฟังก์ชัน h3Style ใน MyConstant
              labelText: 'PassWord :', // ป้ายชื่อสำหรับช่องกรอกรหัสผ่าน
              prefixIcon: Icon(
                Icons.lock, // ไอคอนหน้าช่องกรอกรหัสผ่าน
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

  // ฟังก์ชัน buildAppName สร้างแถว (Row) ที่มีการจัดเรียงชื่อแอปให้อยู่กึ่งกลางของหน้าจอ
  Row buildAppName() {
    return Row(
      mainAxisAlignment:
          MainAxisAlignment.center, // จัดตำแหน่ง Row ให้อยู่กึ่งกลางแนวนอน
      children: [
        ShowTitle(
          title:
              MyConstant.appName, // แสดงชื่อแอปโดยใช้ค่า appName จาก MyConstant
          testStyle: MyConstant()
              .h1Style(), // ใช้รูปแบบข้อความจากฟังก์ชัน h1Style ใน MyConstant
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

class buildCreateAccount extends StatelessWidget {
  const buildCreateAccount({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ShowTitle(
          title: 'Non Account ?',
          testStyle: MyConstant().h3Style(),
        ),
        TextButton(
          onPressed: () =>
              Navigator.pushNamed(context, MyConstant.rountCreateAccount),
          child: Text('Create Account'),
        ),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:shoppingmall/utility/my_constant.dart';
import 'package:shoppingmall/widgets/show_title.dart';

class CreateAccount extends StatefulWidget {
  const CreateAccount({super.key});

  @override
  State<CreateAccount> createState() => _CreateAccountState();
}

class _CreateAccountState extends State<CreateAccount> {
  String? typeUser;

  @override
  Widget build(BuildContext context) {
    // เมธอด build ใช้ในการสร้าง UI ของหน้า
    double size = MediaQuery.of(context)
        .size
        .width; // เก็บความกว้างของหน้าจอในตัวแปร size
    return Scaffold(
      appBar: AppBar(
        title: Text('Create New account'),
        backgroundColor: MyConstant.primary,
      ),
      body: GestureDetector(
           onTap: () => FocusScope.of(context).requestFocus(FocusNode()),
          // เมื่อผู้ใช้แตะที่จอ ฟังก์ชันนี้จะทำการยกเลิกการโฟกัสของ TextFormField หรือคีย์บอร์ด
          behavior: HitTestBehavior.opaque,
          // กำหนดพฤติกรรมของ GestureDetector ให้สามารถตรวจจับการแตะที่จอได้ทั่วพื้นที่
        child: ListView(
          padding: EdgeInsets.all(16),
          children: [
            buidTitle('ข้อมูลทั่วไป :'),
            buildName(size),
            buidTitle('ชนิดของ User :'),
            buildRadioBuyer(size),
            buildRadioSeller(size),
            buildRadioRider(size),
            buidTitle('ข้อมูลพื้นฐาน :'),
            buildAddress(size),
            buildPhone(size),
            buildUser(size),
            buildPassword(size)
          ],
        ),
      ),
    );
  }

  Widget buildRadioBuyer(double size) {
    return Row( mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(width: size*0.6,
          child: RadioListTile(
            value: 'buyer',
            groupValue: typeUser,
            onChanged: (value) {
              setState(() {
                typeUser = value as String;
              });
            },
            title: ShowTitle(
              title: "ผู้ซื้อ (Buyer)",
              testStyle: MyConstant().h3Style(),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildRadioSeller(double size) {
    return Row(mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(width: size*0.6,
          child: RadioListTile(
            value: 'seller',
            groupValue: typeUser,
            onChanged: (value) {
              setState(() {
                typeUser = value as String;
              });
            },
            title: ShowTitle(
              title: "ผู้ขาย (Seller)",
              testStyle: MyConstant().h3Style(),
            ),
          ),
        ),
      ],
    );
  }

  Widget buildRadioRider(double size) {
    return Row(mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(width: size*0.6,
          child: RadioListTile(
            value: 'rider',
            groupValue: typeUser,
            onChanged: (value) {
              setState(() {
                typeUser = value as String;
              });
            },
            title: ShowTitle(
              title: "ผู้ส่ง (Rider)",
              testStyle: MyConstant().h3Style(),
            ),
          ),
        ),
      ],
    );
  }

  Widget buidTitle(String title) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: 16),
      child: ShowTitle(
        title: title,
        testStyle: MyConstant().h2Style(),
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
          child: TextFormField(maxLines: 3,
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

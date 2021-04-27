import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MenuWidget extends StatefulWidget {
  final Function(String) onItemClick;

  const MenuWidget({Key key, this.onItemClick}) : super(key: key);

  @override
  _MenuWidgetState createState() => _MenuWidgetState();
}

class _MenuWidgetState extends State<MenuWidget> {
  User user = FirebaseAuth.instance.currentUser;
  var vendorData;
  @override
  void initState() {
    getVendorData();
    // TODO: implement initState
    super.initState();
  }

  Future<DocumentSnapshot> getVendorData() async {
    var result = await FirebaseFirestore.instance
        .collection('vendors')
        .doc(user.uid)
        .get();
    setState(() {
      vendorData = result;
    });
    return result;
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.white,
      padding: const EdgeInsets.only(top: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          SizedBox(
            height: 30,
          ),
          FittedBox(
            child: CircleAvatar(
              radius: 35,
              backgroundColor: Colors.grey,
              child: CircleAvatar(
                radius: 40,
                backgroundImage: NetworkImage(
                    vendorData != null ? vendorData.data()['imageUrl'] : null),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Text(
            vendorData != null ? vendorData.data()['shopName'] : 'ຊື່ຮ້ານ',
            style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 20,
                fontFamily: 'BalsamiqSans'),
          ),
          SizedBox(
            height: 20,
          ),
          Divider(),
          sliderItem('ແຜນຄວບຄຸມ', Icons.dashboard_outlined),
          sliderItem('ສີນຄ້າ', Icons.shopping_bag_outlined),
          sliderItem('ຄູ່ປ່ອງ', CupertinoIcons.gift),
          sliderItem('ສັ່ງຊື້', Icons.list_alt_outlined),
          sliderItem('ລາຍງານຜົນ', Icons.stacked_bar_chart),
          sliderItem('ຕັ້ງຄ່າຫ', Icons.settings_outlined),
          sliderItem('LogOut', Icons.arrow_back_ios)
        ],
      ),
    );
  }

  Widget sliderItem(String title, IconData icons) => InkWell(
      child: Container(
        decoration: BoxDecoration(
            border: Border(bottom: BorderSide(color: Colors.grey[300]))),
        child: SizedBox(
          height: 50,
          child: Padding(
            padding: const EdgeInsets.only(left: 20),
            child: Row(
              children: [
                Icon(
                  icons,
                  color: Colors.black54,
                  size: 20,
                ),
                SizedBox(
                  width: 10,
                ),
                Text(
                  title,
                  style: TextStyle(color: Colors.black54, fontSize: 12),
                )
              ],
            ),
          ),
        ),
      ),
      onTap: () {
        widget.onItemClick(title);
      });
}

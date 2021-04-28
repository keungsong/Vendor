import 'package:flutter/material.dart';
import 'package:vendor/Screens/add_new_product_screen.dart';

class ProductScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
          body: Column(
        children: [
          Material(
            elevation: 3,
            child: Padding(
              padding: const EdgeInsets.all(10.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(left: 10),
                    child: Container(
                      child: Row(
                        children: [
                          Text(
                            'ສີນຄ້າທັງໝົດ',
                            style: TextStyle(fontSize: 20),
                          ),
                          SizedBox(
                            width: 20,
                          ),
                          CircleAvatar(
                            backgroundColor: Colors.black54,
                            maxRadius: 20,
                            child: FittedBox(
                              child: Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Text(
                                  '200',
                                  style: TextStyle(
                                      color: Colors.white, fontSize: 30),
                                ),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ),
                  FlatButton.icon(
                    color: Theme.of(context).primaryColor,
                    icon: Icon(
                      Icons.add,
                      color: Colors.white,
                    ),
                    label: Text(
                      'ເພີ່ມສີນຄ້າ',
                      style: TextStyle(color: Colors.white),
                    ),
                    onPressed: () {
                      Navigator.pushNamed(context, AddNewProduct.id);
                    },
                  )
                ],
              ),
            ),
          ),
          TabBar(
              indicatorColor: Theme.of(context).primaryColor,
              labelColor: Theme.of(context).primaryColor,
              unselectedLabelColor: Colors.black54,
              tabs: [
                Tab(
                  text: 'ອານຸຍາດແລ້ວ',
                ),
                Tab(
                  text: 'ຍັງບໍ່ອະນຸຍາດ',
                )
              ]),
          Expanded(
            child: Container(
              child: TabBarView(children: [
                Center(
                  child: Text('ອານຸຍາດ'),
                ),
                Center(
                  child: Text('ຍັງບໍອານຸຍາດ'),
                )
              ]),
            ),
          )
        ],
      )),
    );
  }
}

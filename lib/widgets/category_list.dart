import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vendor/Provider/product_provider.dart';

import 'package:vendor/services/firebase_services.dart';

class CategoryList extends StatefulWidget {
  @override
  _CategoryListState createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  FirebaseServices _services = FirebaseServices();
  @override
  Widget build(BuildContext context) {
    var _provider = Provider.of<ProductProvider>(context);
    return Dialog(
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            color: Theme.of(context).primaryColor,
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'ເລືອກໝວດໝູ່',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.close,
                        color: Colors.white,
                      ))
                ],
              ),
            ),
          ),
          StreamBuilder(
              stream: _services.category.snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('ມີການຜີດພາບ');
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Center(
                    child: Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: CircularProgressIndicator(),
                    ),
                  );
                }
                return Expanded(
                  child: ListView(
                      children:
                          snapshot.data.docs.map((DocumentSnapshot document) {
                    return ListTile(
                      leading: CircleAvatar(
                        backgroundImage: NetworkImage(document.data()['image']),
                      ),
                      title: Text(document.data()['name']),
                      onTap: () {
                        _provider.selectCategory(document.data()['name']);
                        Navigator.pop(context);
                      },
                    );
                  }).toList()),
                );
              }),
        ],
      ),
    );
  }
}

class SubCategoryList extends StatefulWidget {
  @override
  _SubCategoryListState createState() => _SubCategoryListState();
}

class _SubCategoryListState extends State<SubCategoryList> {
  FirebaseServices _services = FirebaseServices();
  @override
  Widget build(BuildContext context) {
    var _provider = Provider.of<ProductProvider>(context);
    return Dialog(
      child: Column(
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            color: Theme.of(context).primaryColor,
            child: Padding(
              padding: const EdgeInsets.only(left: 10, right: 10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'ເລືອກໝວດໝູ່ນ້ອຍ',
                    style: TextStyle(
                        color: Colors.white, fontWeight: FontWeight.bold),
                  ),
                  IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: Icon(
                        Icons.close,
                        color: Colors.white,
                      ))
                ],
              ),
            ),
          ),
          FutureBuilder<DocumentSnapshot>(
              future: _services.category.doc(_provider.selectedCategory).get(),
              builder: (BuildContext context,
                  AsyncSnapshot<DocumentSnapshot> snapshot) {
                if (snapshot.hasError) {
                  return Text('ມີການຜີດພາບ');
                }
                if (snapshot.connectionState == ConnectionState.done) {
                  Map<String, dynamic> data = snapshot.data.data();
                  return Expanded(
                      child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Container(
                          child: Row(
                            children: [
                              Text('ໝວດໝູ່ໃຫຍ່:'),
                              SizedBox(
                                width: 10,
                              ),
                              FittedBox(
                                child: Text(
                                  _provider.selectedCategory,
                                  style: TextStyle(fontWeight: FontWeight.bold),
                                ),
                              )
                            ],
                          ),
                        ),
                      ),
                      Divider(
                        thickness: 3,
                      ),
                      Container(
                        child: Expanded(
                          child: Padding(
                            padding: const EdgeInsets.all(10.0),
                            child: ListView.builder(
                              itemBuilder: (BuildContext context, int index) {
                                return ListTile(
                                  contentPadding: EdgeInsets.zero,
                                  leading: CircleAvatar(
                                    child: Text('${index + 1}'),
                                  ),
                                  title: Text(data['subCat'][index]['name']),
                                  onTap: () {
                                    _provider.selectSubCategory(
                                        data['subCat'][index]['name']);
                                    Navigator.pop(context);
                                  },
                                );
                              },
                              itemCount: data['subCat'] == null
                                  ? 0
                                  : data['subCat'].length,
                            ),
                          ),
                        ),
                      )
                    ],
                  ));
                }
                return Center(
                  child: Padding(
                    padding: const EdgeInsets.only(top: 10),
                    child: CircularProgressIndicator(),
                  ),
                );
              }),
        ],
      ),
    );
  }
}
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_slider_drawer/flutter_slider_drawer.dart';
import 'package:vendor/Screens/dasboard_screen.dart';
import 'package:vendor/Screens/login_screen.dart';
import 'package:vendor/Screens/register_screen.dart';
import 'package:vendor/services/drawer_services.dart';
import 'package:vendor/widgets/drawer_menu_widget.dart';

class Home extends StatefulWidget {
  static const String id = 'home-screen';
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  DrawerServices _services = DrawerServices();
  GlobalKey<SliderMenuContainerState> _key =
      new GlobalKey<SliderMenuContainerState>();
  String title;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SliderMenuContainer(
          appBarColor: Colors.white,
          appBarHeight: 80,
          key: _key,
          sliderMenuOpenSize: 200,
          title: Text(
            '',
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
          ),
          trailing: Row(
            children: [
              IconButton(
                  onPressed: () {
                    FirebaseAuth.instance.signOut();
                    Navigator.pushReplacementNamed(context, LoginSreen.id);
                  },
                  icon: Icon(Icons.search)),
              IconButton(onPressed: () {}, icon: Icon(CupertinoIcons.bell))
            ],
          ),
          sliderMenu: MenuWidget(
            onItemClick: (title) {
              _key.currentState.closeDrawer();
              setState(() {
                this.title = title;
              });
            },
          ),
          sliderMain: _services.drawerScreen(title)),
    );
  }
}

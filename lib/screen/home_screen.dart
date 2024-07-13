import 'dart:convert';

import 'package:card_swiper/card_swiper.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter_application_1/config/app.dart';
import 'package:flutter_application_1/service/auth_service.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<dynamic> banners = [];
  Future<void> fetchBanner() async {
    try {
      final response = await http.get(Uri.parse("$API_URL/api/banners"));
      final banners = jsonDecode(response.body);
      print(banners);
      setState(() {
        this.banners = banners;
      });
    } catch (e) {
      print(e);
    }
  }

  @override
  void initState() {
    super.initState();
    AuthService.checkLogin().then((loggedIn) => {
          if (loggedIn) {Navigator.of(context).pushReplacementNamed('/login')}
        });
    fetchBanner();
  }

  List<String> sliders = [
    "image/slider1.jpg",
    "image/slider2.jpg",
    "image/slider3.jpg",
    "image/slider4.jpg",
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.blue,
                image: DecorationImage(
                    image: AssetImage("image/2021WT1.jpg"), fit: BoxFit.cover),
              ),
              child: Text('Wetherings'),
            ),
            ListTile(
              title: Text('About Us'),
              onTap: () {},
            ),
            ListTile(
              title: Text('Contract Us'),
              onTap: () {},
            ),
          ],
        ),
      ),
      appBar: AppBar(title: Text('Home')),
      body: Container(
        child: Swiper(
            autoplay: true,
            itemCount: banners.length,
            itemBuilder: (context, index) {
              return Image.network("$API_URL/${banners[index]['imageUrl']}");
            }),
      ),
      bottomNavigationBar: BottomNavigationBar(
        showUnselectedLabels: true,
        onTap: (value) {},
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
              icon: Icon(Icons.home),
              label: 'Home',
              backgroundColor: Colors.green),
          BottomNavigationBarItem(
              icon: Icon(Icons.calculate),
              label: 'Calculate',
              backgroundColor: Colors.green),
          BottomNavigationBarItem(
              icon: Icon(Icons.person),
              label: 'Person',
              backgroundColor: Colors.green),
          BottomNavigationBarItem(
              icon: Icon(Icons.settings),
              label: 'Setting',
              backgroundColor: Colors.green),
        ],
      ),
    );
  }
}

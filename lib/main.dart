import 'package:flutter/material.dart';
import 'package:carousel_pro/carousel_pro.dart';

//ALL IMPORTS
import './components/horizontal_listview.dart';
import './components/products.dart';
import './pages/cart.dart';

void main() {
  runApp(MaterialApp(
    debugShowCheckedModeBanner: false,
    home: HomePage(),
  ));
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    //IMAGES CAROUSEL SECTION
    Widget image_carousel = new Container(
      height: 200.0,
      child: new Carousel(
        boxFit: BoxFit.cover,
        images: [
          AssetImage('images/c1.jpg'),
          AssetImage('images/m1.jpeg'),
          AssetImage('images/w3.jpeg'),
          AssetImage('images/w4.jpeg'),
          AssetImage('images/m2.jpg'),
        ],
        autoplay: false,
        animationCurve: Curves.fastLinearToSlowEaseIn,
        animationDuration: Duration(milliseconds: 1000),
        dotSize: 5.0,
        dotBgColor: Colors.pinkAccent,
        indicatorBgPadding: 8.0,
      ),
    );

    return Scaffold(
      appBar: new AppBar(
        elevation: 0.0,
        backgroundColor: Colors.red,
        title: Text("HunkyBee"),
        actions: <Widget>[
          new IconButton(
              icon: Icon(Icons.search, color: Colors.white), onPressed: () {}),
          new IconButton(
              icon: Icon(Icons.shopping_cart, color: Colors.white),
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => new Cart()));
              })
        ],
      ),
      drawer: new Drawer(
        child: new ListView(
          children: <Widget>[
            //HWADER
            new UserAccountsDrawerHeader(
              accountName: Text('Abraham William'),
              accountEmail: Text("abraham9193@gmail.com"),
              currentAccountPicture: GestureDetector(
                child: new CircleAvatar(
                  backgroundColor: Colors.grey,
                  child: Icon(Icons.person, color: Colors.white),
                ),
              ),
              decoration: new BoxDecoration(color: Colors.red),
            ),

            //BODY SECTION
            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('Home Page'),
                leading: Icon(Icons.home, color: Colors.pinkAccent),
              ),
            ),

            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('My Account'),
                leading: Icon(Icons.person, color: Colors.pinkAccent),
              ),
            ),

            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('My Orders'),
                leading: Icon(Icons.shopping_basket, color: Colors.pinkAccent),
              ),
            ),

            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('Categories'),
                leading: Icon(Icons.dashboard, color: Colors.pinkAccent),
              ),
            ),

            InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => new Cart()));
              },
              child: ListTile(
                title: Text('Shopping Cart'),
                leading: Icon(Icons.shopping_cart, color: Colors.pinkAccent),
              ),
            ),

            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('Favourites'),
                leading: Icon(Icons.favorite, color: Colors.pinkAccent),
              ),
            ),

            Divider(),

            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('Settings'),
                leading: Icon(Icons.settings, color: Colors.blue),
              ),
            ),

            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('About'),
                leading: Icon(Icons.help, color: Colors.greenAccent),
              ),
            ),

            InkWell(
              onTap: () {},
              child: ListTile(
                title: Text('Online Support'),
                leading: Icon(Icons.headset_mic, color: Colors.blueGrey),
              ),
            ),
          ],
        ),
      ),
      body: new ListView(
        children: <Widget>[
          //CAROUSEL IMAGES SLIDERS
          image_carousel,
          //PADDING WIDGET FOR CATEGORIES
          new Padding(
              padding: const EdgeInsets.all(8.0),
              child: new Text('Categories')),
          //HORIZONTAL LISTVIEW BEGINS HERE
          HorizontalList(),

          Divider(),
          //RECENT PRODUCTS
          new Padding(
              padding: const EdgeInsets.all(20.0),
              child: new Text(
                'Recent Products',
              )),

          //GRID VIEW FOR PRODUCTS
          Container(
            height: 320.0,
            child: Products(),
          )
        ],
      ),
    );
  }
}

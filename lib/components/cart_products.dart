import 'package:flutter/material.dart';

class Cart_products extends StatefulWidget {
  @override
  _Cart_productsState createState() => _Cart_productsState();
}

class _Cart_productsState extends State<Cart_products> {
  var Product_on_the_cart = [
    {
      "name": "Men Real Dress",
      "picture": "images/products/blazer1.jpeg",
      "old_price": 120,
      "price": 85,
      "size": "M",
      "color": "Red",
      "quantity": 1
    },
    {
      "name": "Red Dress",
      "picture": "images/products/dress1.jpeg",
      "old_price": 190,
      "price": 80,
      "size": "7",
      "color": "Blue",
      "quantity": 1
    }
  ];

  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
        itemCount: Product_on_the_cart.length,
        itemBuilder: (context, index) {
          return Single_cart_product(
            cart_prod_name: Product_on_the_cart[index]["name"],
            cart_prod_color: Product_on_the_cart[index]["color"],
            cart_prod_qty: Product_on_the_cart[index]["quantity"],
            cart_prod_size: Product_on_the_cart[index]["size"],
            cart_prod_price: Product_on_the_cart[index]["price"],
            cart_prod_picture: Product_on_the_cart[index]["picture"],
          );
        });
  }
}

// STATELESS WIDGET

class Single_cart_product extends StatelessWidget {
  final cart_prod_name;
  final cart_prod_picture;
  final cart_prod_price;
  final cart_prod_size;
  final cart_prod_color;
  final cart_prod_qty;

  // CONSTRUCTOR
  Single_cart_product({
    this.cart_prod_name,
    this.cart_prod_picture,
    this.cart_prod_price,
    this.cart_prod_size,
    this.cart_prod_color,
    this.cart_prod_qty,
  });

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        //=======LEADING SECTION WITH IMAGE
        leading:
            new Image.asset(cart_prod_picture, width: 100.0, height: 100.0),
        title: new Text(cart_prod_name),
        subtitle: new Column(
          children: <Widget>[
            // ROW INSIDE COLUMN
            new Row(
              children: <Widget>[
                // SIZE SECTION
                Padding(
                  padding: const EdgeInsets.all(0.0),
                  child: new Text("Size:"),
                ),
                Padding(
                  padding: const EdgeInsets.all(6.0),
                  child: new Text(cart_prod_size,
                      style: TextStyle(color: Colors.red)),
                ),

                // CART PRODUCT SECTION

                new Padding(
                  padding: const EdgeInsets.fromLTRB(20.0, 8.0, 8.0, 8.0),
                  child: new Text("Color:"),
                ),
                Padding(
                  padding: const EdgeInsets.all(4.0),
                  child: new Text(cart_prod_color,
                      style: TextStyle(color: Colors.red)),
                ),
              ],
            ),

            // ======= THIS SECTION IS FOR PRODUCT PRICE
            new Container(
                alignment: Alignment.topLeft,
                child: new Text(
                  "Price: \$${cart_prod_price}",
                  style: TextStyle(fontSize: 17.0, fontWeight: FontWeight.bold),
                ))
          ],
        ),

        trailing: FittedBox(
          fit: BoxFit.fill,
          child: new Column(
            children: <Widget>[
              new IconButton(
                icon: Icon(Icons.arrow_drop_up),
                onPressed: () {},
              ),
              new Text(
                "$cart_prod_qty",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16.0),
              ),
              new IconButton(
                icon: Icon(Icons.arrow_drop_down),
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}

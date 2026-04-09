
import 'package:flutter/material.dart';
import 'package:team_flutter_project01/Cart.dart';
import 'package:team_flutter_project01/loginpage.dart';


class Product {
  final String title;
  final String imagePath;
  final double price;

  Product({required this.title, required this.imagePath, required this.price});
}

class tvspage extends StatefulWidget {
  @override
  State<tvspage> createState() => _tvspageState();
}

class _tvspageState extends State<tvspage> {


  final List<Product> products = [
    Product(
      title: 'Samsung',
      price: 1200,
      imagePath: 'assets/images/samsung.png',
    ),
    Product(
      title: 'LG',
      price: 1400,
      imagePath: 'assets/images/lg.png',
    ),
    Product(
      title: 'Sony',
      price: 600,
      imagePath: 'assets/images/sony.png',
    ),
    Product(
      title: 'Hisense',
      price: 1400,
      imagePath: 'assets/images/hisense.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("TVs"),
      ),

      body: Padding(
        padding: EdgeInsets.all(16),
        child: GridView.builder(
          itemCount: 4,
          gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, // 2 columns
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 0.6,
          ),
          itemBuilder: (context, index) {
            final product = products[index];
            return Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
              elevation: 5,
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    Expanded(
                      child: Image.asset(
                        product.imagePath,
                        //fit: BoxFit.cover,
                      ),
                    ),


                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                      child: Text(
                        product.title,
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),

                    Padding(
                      padding: const EdgeInsets.fromLTRB(0, 0, 0, 0),
                      child: Text('\$${product.price.toStringAsFixed(2)}'),
                    ),
                    SizedBox(
                        height: 8
                    ),

                    ElevatedButton(
                      onPressed: () {
                        setState(() {
                          Cart.addItem({
                            'title': product.title,
                            'price': product.price,
                          });
                        });
                      },
                      child: Text(
                        "Add to Cart",
                        style: TextStyle(
                          fontSize: 16,
                          //color: Colors.black
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ),

    );
  }
}
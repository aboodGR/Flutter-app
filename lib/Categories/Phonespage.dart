import 'package:flutter/material.dart';
import 'package:team_flutter_project01/Cart.dart';
import 'package:team_flutter_project01/loginpage.dart';


class Product {
  final String title;
  final String imagePath;
  final double price;

  Product({required this.title, required this.imagePath, required this.price});
}

class Phonespage extends StatefulWidget {
  @override
  State<Phonespage> createState() => _PhonespageState();
}

class _PhonespageState extends State<Phonespage> {

  final List<Product> products = [
    Product(
      title: 'IPhone 16',
      price: 800,
      imagePath: 'assets/images/iphone_16.png',
    ),
    Product(
      title: 'IPhone 14',
      price: 500,
      imagePath: 'assets/images/iphone_14.png',
    ),
    Product(
      title: 'Samsung S22',
      price: 500,
      imagePath: 'assets/images/samsung_s22.png',
    ),
    Product(
      title: 'Samsung S',
      price: 400,
      imagePath: 'assets/images/samsung_s.png',
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("Phones"),
      ),

      body: Padding(
        padding: EdgeInsets.all(16),
        child: GridView.builder(
          itemCount: products.length,
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

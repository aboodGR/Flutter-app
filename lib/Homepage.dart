import 'package:flutter/material.dart';
import 'loginpage.dart';
import 'package:team_flutter_project01/Cart.dart';
import 'Categories/Conselespage.dart';
import 'Categories/Phonespage.dart';
import 'Categories/GamingPCspage.dart';
import 'Categories/laptopspage.dart';
import 'Categories/ipadspage.dart';
import 'Categories/tvspage.dart';
import 'main.dart';
import 'loginpage.dart';


class Product {
  final String title;
  final String imagePath;


  Product({required this.title, required this.imagePath});
}

class Home extends StatefulWidget {
  final String Email;
  const Home({super.key, required this.Email});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  List<Map<String, dynamic>> cart = [];
  bool isDarkMode = false;


  final List<Product> products = [
    Product(
      title: 'Consoles',
      imagePath: 'assets/images/consoles.png',
    ),
    Product(
      title: 'Gaming PCs',
      imagePath: 'assets/images/gaming_pcs.png',
    ),
    Product(
      title: 'IPads',
      imagePath: 'assets/images/ipads.png',
    ),
    Product(
      title: 'Laptops',
      imagePath: 'assets/images/laptops.png',
    ),
    Product(
      title: 'Phones',
      imagePath: 'assets/images/phones.png',
    ),
    Product(
      title: 'TVs',
      imagePath: 'assets/images/tvs.png',
    ),
  ];


  final List<Widget> pages = [
    Consolespage(),
    Gamingpcspage(),
    ipadspage(),
    laptopspage(),
    Phonespage(),
    tvspage(),
  ];


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Our Products"),
      ),
      drawer: Drawer(
        child: ListView(
          children: [
            UserAccountsDrawerHeader(
              accountName: Text(
                widget.Email.split('@')[0],
                style: TextStyle(
                  fontSize: 20,
                ),
              ),

              accountEmail: Text(
                '${widget.Email}',
                style: TextStyle(
                  fontSize: 15,
                ),
              ),

              currentAccountPicture: CircleAvatar(
                backgroundColor: Theme.of(context).colorScheme.surface,
                child: Text(
                  widget.Email[0].toUpperCase(),
                  style: TextStyle(
                    fontSize: 40,
                  ),
                ),
              ),

              decoration: BoxDecoration(
                //color: Colors.blue,
                color: Theme.of(context).colorScheme.secondary,
              ),
            ),

            SizedBox(
              height: 20,
            ),


            Positioned(
              top: 16,
              right: 16,
              child: ValueListenableBuilder<ThemeMode>(
                valueListenable: themeNotifier,
                builder: (context, mode, _) {
                  return Center(
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Icon(Icons.light_mode,),

                        SizedBox(width: 7,),
                        Switch(
                          value: mode == ThemeMode.dark,
                          activeColor: Theme.of(context).colorScheme.secondary,
                          inactiveThumbColor: Theme.of(context).colorScheme.secondary,
                          onChanged: (value) {
                            themeNotifier.value = value
                                ? ThemeMode.dark
                                : ThemeMode.light;
                          },
                        ),

                        SizedBox(width: 7,),

                        Icon(Icons.dark_mode,),
                      ],
                    ),
                  );
                },
              ),
            ),

            SizedBox(
              height: 20,
            ),


              Padding(
                padding: const EdgeInsets.fromLTRB(30, 0, 30, 0),
                child: ElevatedButton(
                  onPressed: (){
                    Navigator.pushAndRemoveUntil(context,
                      MaterialPageRoute(builder: (context) => Login()),
                          (route) => false,
                    );
                  },

                  child: Text(
                    "Log Out",
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 20,
                    ),
                  ),

                ),
              ),


          ],
        ),
      ),

      body: Padding(
        padding: EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Categories:",
              style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.bold
              ),
            ),

            SizedBox(
              height: 20,
            ),

            Expanded(
              child: GridView.builder(
                itemCount: products.length,
                gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2, // 2 columns
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 0.8,
                ),
                itemBuilder: (context, index) {
                  final product = products[index];
                  return Card(
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                    elevation: 5,
                    child: InkWell(
                      onTap: (){
                        Navigator.push(
                          context, MaterialPageRoute(
                            builder: (_) => pages[index]
                        ));
                      },
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


                            Center(
                              child: Padding(
                                padding: const EdgeInsets.fromLTRB(0, 8, 0, 8),
                                child: Text(
                                  product.title,
                                  style: TextStyle(
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),


                          ],
                        ),
                      ),
                    ),
                  );
                },
              ),
            ),
            Text("My Cart",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 30,
                  //color: isDarkMode ? Colors.white : Colors.black
                )
            ),
            SizedBox(height: 10),
            Cart.getItems().isEmpty
                ? Text("Cart is empty.",
                style: TextStyle(

                  fontSize: 18,
                ),
              )
                : Column(
              children: Cart.getItems().map((item) {
                return Padding(
                  padding: const EdgeInsets.symmetric(vertical: 4),
                  child: Text("${item['title']} - ${item['price']} \$",
                      style: TextStyle(
                      )),
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  if (Cart.getItems().isEmpty) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          "Error, please add items to your cart!!",
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            //color: Colors.black
                          ),
                        ),
                        //backgroundColor: Colors.red,
                      ),
                    );
                  }
                  Cart.clearItems();
                });
              },
              child: Text(
                  "Order Now",
                  style: TextStyle(
                    //color: Colors.black
                  )
              ),
            ),

            SizedBox(height: 50,),

          ],
        ),
      ),


    );
  }
}

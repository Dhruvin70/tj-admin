import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:jewellery_admin/controller/homeController.dart';
import 'package:jewellery_admin/pages/addProduct.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (homectrl) {
      return Scaffold(
      appBar: AppBar(
          title: const Text("Tanvi Jewellers", style: TextStyle(
            color: Colors.pink, fontWeight: FontWeight.w500, shadows: <Shadow>[
            Shadow(
              offset: Offset(-2.0, -2.0),
              blurRadius: 3.0,
              color: Colors.black26,
            ),
          ],),)
      ),
      body: ListView.builder(
        padding: const EdgeInsets.all(10),
        itemCount: homectrl.productList.length,
        itemBuilder: (context, index) {
          return Card(

              margin: const EdgeInsets.fromLTRB(0, 0, 0, 15),
              color: Colors.white,
              // Change this to your desired color
              elevation: 25,
              // Change this to your desired elevation
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(
                    5), // Change this to your desired border radius)
              ),
              child: Column(
                children: [
                  ListTile(
                    title:  Text(
                      homectrl.productList[index].name ,
                      style: const TextStyle(
                          color: Colors.deepPurple,
                          fontSize: 25,
                          fontWeight: FontWeight.bold),
                    ),
                    subtitle:  Text(
                        ("₹ ${homectrl.productList[index].price}"),

                      style: const TextStyle(color: Colors.black, fontSize: 17),
                    ),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete, color: Colors.red),
                      // Change this to your desired color
                      onPressed: () {
                        showDialog(
                          context: context,
                          builder: (BuildContext context) {
                            return AlertDialog(
                              title: const Text("Confirm Deletion"),
                              content: const Text("Are you sure you want to delete this product?"),
                              actions: [
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(); // Close the dialog
                                    // Perform the deletion
                                    homectrl.deleteproducts(homectrl.productList[index].id,homectrl.productList[index].image);
                                  },
                                  child: const Text("Yes"),
                                ),
                                TextButton(
                                  onPressed: () {
                                    Navigator.of(context).pop(); // Close the dialog
                                    // Cancel the deletion
                                  },
                                  child: const Text("No"),
                                ),
                              ],
                            );
                          },
                        );
                      },
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.fromLTRB(5, 0, 5, 0),
                    height: 300.0,
                    child: Ink.image(
                      image: NetworkImage(
                        homectrl.productList[index].imageurl,
                      ),
                      fit: BoxFit.fill
                    ),
                  ),
                  ButtonBar(
                    children: [
                      Expanded(
                        child: TextButton(
                          child: Text("${homectrl.productList[index].weight} gm"),

                          onPressed: () {},
                        ),
                      ),
                      Expanded(
                        child: TextButton(
                          child: Text(homectrl.productList[index].category),
                          onPressed: () {},
                        ),
                      ),
                      Expanded(
                        child: TextButton(
                          child: Text(homectrl.productList[index].material ),
                          onPressed: () {},
                        ),
                      ),
                    ],
                  )
                ],
              ));
        },
      ),
      floatingActionButton: FloatingActionButton(
        hoverColor: Colors.blue,
        onPressed: () {
          Get.to(const AddProduct());
        },
        child: const Icon(Icons.add),
      ),
      );
    });
  }
}

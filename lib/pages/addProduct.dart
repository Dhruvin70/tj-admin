import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jewellery_admin/controller/homeController.dart';
import 'package:jewellery_admin/widgets/dropdown.dart';

class AddProduct extends StatelessWidget {
  const AddProduct({super.key});

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(builder: (ctrl) {
      return Scaffold(
        appBar: AppBar(title: const Text('Tanvi Jewellers')),
        body: SingleChildScrollView(
          child: Container(
            margin: const EdgeInsets.all(20),
            width: double.maxFinite,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Text(
                  'Add New Product',
                  style: TextStyle(
                    fontSize: 30,
                    fontWeight: FontWeight.bold,
                    color: Colors.indigo.shade400,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                TextField(
                  controller: ctrl.productNameCtrl,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                          color: Colors.red), // Change border color here
                    ),

                    labelText:
                        'Product Name', // Changed from label to labelText
                    hintText: 'Enter Product Name',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: ctrl.productPriceCtrl,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                          color: Colors.red), // Change border color here
                    ),
                    labelText: 'Price', // Changed from label to labelText
                    hintText: 'Enter Price',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  controller: ctrl.productDescriptionCtrl,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                          color: Colors.red), // Change border color here
                    ),
                    labelText: 'Product Description',
                    // Changed from label to labelText
                    hintText: 'Enter Product Description',
                  ),
                  maxLines: 4,
                ),
                const SizedBox(
                  height: 10,
                ),
                TextField(
                  keyboardType: TextInputType.number,
                  controller: ctrl.productWeightCtrl,
                  decoration: InputDecoration(
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(10),
                      borderSide: const BorderSide(
                          color: Colors.red), // Change border color here
                    ),
                    labelText: 'Product Weight',
                    // Changed from label to labelText
                    hintText: 'Product Weight',
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                Container(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                     Column(

                        children: [
                           ElevatedButton(
                            onPressed: () async {
                              ctrl.imageFileName =
                                  ctrl.getImage(ImageSource.gallery).toString();
                              ctrl.update();
                            },
                            child: Row(children: [const Text('Select from '),Icon(Icons.image)]),
                          ),
                        ],
                      ),
                    ElevatedButton(
                      onPressed: () async {
                        ctrl.imageFileName =
                            ctrl.getImage(ImageSource.camera).toString();
                        ctrl.update();
                      },
                      child: Row(children: [const Text('Select from '),Icon(Icons.camera_alt)]),
                    ),

                  ],
                )),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  children: [
                    Flexible(
                        child: DropDownBtn(
                      items: const [
                        "AD",
                        "Marable",
                        "Copper",
                        "Brass",
                        "Gold",
                        "Silver",
                        "Platinum"
                      ],
                      selectedItemText: ctrl.material,
                      onSelected: (selectedValue) {
                        ctrl.material = selectedValue ?? "Gold";
                        ctrl.update();
                      },
                    )),
                    Flexible(
                        child: DropDownBtn(
                            items: const [
                          "Earring",
                          "Bracelets",
                          "Rings",
                          "Charms",
                          "Anklets",
                          "Necklaces",
                          "Bridal"
                        ],
                            selectedItemText: ctrl.category,
                            onSelected: (selectedValue) {
                              ctrl.category = selectedValue ?? "Body";
                              ctrl.update();
                            })),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Text('Define Offer'),
                Row(
                  children: [
                    Flexible(
                        child: DropDownBtn(
                      items: const ["YES", "NO"],
                      selectedItemText:
                          ctrl.offer.toString() == "false" ? "NO" : "YES",
                      onSelected: (selectedValue) {
                        ctrl.offer = (selectedValue == "NO" ? false : true);
                        ctrl.update();
                      },
                    )),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.deepPurpleAccent,
                        // Changing Text Color
                        foregroundColor: Colors.white),
                    onPressed: () {
                      ctrl.addProduct(ctrl.imageFileName);
                    },
                    child: const Text('Add Product'))
              ],
            ),
          ),
        ),
      );
    });


  }
}

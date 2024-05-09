import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:jewellery_admin/model/product/product.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:path/path.dart';

class HomeController extends GetxController {
  FirebaseFirestore firestore = FirebaseFirestore.instance;
  late CollectionReference productCollection;

  TextEditingController productNameCtrl = TextEditingController();
  TextEditingController productDescriptionCtrl = TextEditingController();
  TextEditingController productWeightCtrl = TextEditingController();
  TextEditingController productPriceCtrl = TextEditingController();
  String category = "Body";
  String material = "Gold";
  bool? offer = false;
  double productPrice = 0.0;
  double productWeight = 0.0;
  String imageFileName ="" ;
  String imgUrl = '';
  List<Products> productList = [];

  Future<void> getImage(ImageSource source) async {
   ImagePicker pickedFile = ImagePicker();
   XFile? file = await pickedFile.pickImage(source: source);
   print('${file?.path}');
   imageFileName = '${file?.path}';
  }

  @override
  Future<void> onInit() async {
    productCollection = firestore.collection('products');
    await fetchProducts();
    super.onInit();
  }

  testMethod() {}

  addProduct(String imageName) async {
    try {
      String fileName = basename(imageName);
      print(fileName);
      print(imageFileName);
      // Get a reference to the storage root
      Reference storageReference = FirebaseStorage.instance.ref();
      Reference referenceDirImages = storageReference.child('images');

      // Create a reference for the image to be stored
      Reference referenceImageToUpload = referenceDirImages.child(fileName);

      try {
        // Store File
        await referenceImageToUpload.putFile(File(imageName));
        print(  referenceImageToUpload.getDownloadURL());
        imgUrl = await referenceImageToUpload.getDownloadURL();
      }catch(e){
        print(e);

      }


    } catch (e) {
      throw Exception('Image upload failed: $e');
    }

    try {

      if ( basename(imageFileName).trim().isEmpty) {
        throw Exception('Please select an image');
      }


      DocumentReference doc = productCollection.doc();
      Products products = Products(
        // Provide all the required arguments when creating a new instance of Products
         doc.id,
        productNameCtrl.text,
        productDescriptionCtrl.text,
        category,
         double.parse(productPriceCtrl.text),
         double.parse(productWeightCtrl.text),
          material,
          offer!, basename(imageName).toString(),imgUrl);
      if (productNameCtrl.text.isEmpty || productDescriptionCtrl.text.isEmpty || category.isEmpty || productPriceCtrl.text.isEmpty || productWeightCtrl.text.isEmpty || material.isEmpty) {
        throw Exception('NullableException: One or more fields are null or empty');
      }



      final productJson = products.toJson();
      doc.set(productJson);
      await Get.snackbar('SUCCESS', 'PRODUCT ADDED SUCCESSFULLY', colorText: Colors.green);
      fetchProducts();
      setValueDefault();
    } catch (e) {
      Get.snackbar('Error', e.toString(), colorText: Colors.red);
      print(e);
    }
  }

/*
QuerySnapshot
|--docs (List of DocumentSnapshots)
|   |--DocumentSnapshot 1
|   |   |--id (String: Document ID)
|   |   |--exists (Boolean: Document existence)
|   |   |--data() (Function: Returns document data as Map<String, dynamic>
|   |   |--metadata (Document metadata including hasPendingWrites, is
|   |
|   |--DocumentSnapshot 2
|   |   |--id
|   |   |--exists
|   |   |--data()
|   |   |--metadata
|
|
|--docChanges (List of DocumentChange representing changes since last
|    |--DocumentChange 1
|    |  |--type (added, modified, removed)
|    |  |--doc (DocumentSnapshot of the changed document)
|    |  |--oldIndex/newIndex (indexes in the old/new query snapshot)
|
|--metadata (Query metadata including hasPendingWrites, isFromCache)
*/
  fetchProducts() async{
    try {
      QuerySnapshot productSnapshot = await productCollection.get();
      final List<Products> retrievedProducts = productSnapshot.docs.map((doc) =>
          Products.fromJson(doc.data() as Map<String, dynamic>)).toList();
      productList.clear();
      productList.assignAll(retrievedProducts);
    }catch(e){
      print(e);
    }finally{
      update();

    }
  }
  deleteproducts(String id,String img) async {
    try {
      await productCollection.doc(id).delete();

      Reference reference = FirebaseStorage.instance.ref().child("images"+Platform.pathSeparator+img);

      print("========================"+ reference.toString() + " ===================");
      await reference.delete();

      fetchProducts();
      Get.snackbar(
          'SUCCESS', 'PRODUCT DELETED SUCCESSFULLY', colorText: Colors.green);
    }
    catch (e) {
      Get.snackbar('Error', e.toString(), colorText: Colors.red);
      print(e);
    }
    finally{
      update();
    }
  }
  setValueDefault(){
    productPriceCtrl.clear();
    productDescriptionCtrl.clear();
    productNameCtrl.clear();
    productWeightCtrl.clear();
    category = "Body";
    material = "Gold";
    offer = false;
    productPrice = 0.0;
    productWeight = 0.0;
    imageFileName ="" ;
    imgUrl = '';

  }
}

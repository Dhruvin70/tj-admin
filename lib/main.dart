  import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
  import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:jewellery_admin/controller/homeController.dart';
  import 'package:jewellery_admin/pages/home.dart';
import 'package:jewellery_admin/widgets/firebaseOptions.dart';


  Future<void> main() async {
    //Calling Fire base or Initalisation

    WidgetsFlutterBinding.ensureInitialized();
    await Firebase.initializeApp(options: firebaseOptions);

    // Registering the Controllers before it starts
    Get.put(HomeController());
    runApp(const MyApp());
  }

  class MyApp extends StatelessWidget {
    const MyApp({super.key});

    // This widget is the root of your application.
    @override
    Widget build(BuildContext context) {
      return GetMaterialApp(
        title: 'Flutter Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
          useMaterial3: true,
        ),
        home: const Home(),
      );
    }
  }



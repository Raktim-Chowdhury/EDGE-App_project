import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:provider/provider.dart';
import 'package:recipe_app/upload_data.dart';
import 'Provider/favorite_provider.dart';
import 'Provider/quantity.dart';
import 'Views/app_main_screen.dart';
import 'front_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}
// This widget is the root of your application.
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        // for favorite provider
        ChangeNotifierProvider(create: (_)=>FavoriteProvider()),
        // for quantity provider
        ChangeNotifierProvider(create: (_) => QuantityProvider()),
      ],
      child:  MaterialApp(
        debugShowCheckedModeBanner: false,
        // home: UploadRecipes(),
        home: FrontPage(),
        // home: AppMainScreen(),
      ),
    );
  }
}
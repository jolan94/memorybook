import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:memorybook/controllers/diary_controller.dart';
import 'package:memorybook/firebase_options.dart';
import 'package:memorybook/views/add_entry_screen.dart';
import 'package:memorybook/views/login_screen.dart';
import 'package:memorybook/views/view_entry_screen.dart';

void main() async {
  // Initialize Firebase
  WidgetsFlutterBinding.ensureInitialized();
  await GetStorage.init();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final _diaryController = Get.put(DiaryController());

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'My Diary',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/',
      getPages: [
        GetPage(name: '/', page: () => LoginScreen()),
        GetPage(name: '/add_entry', page: () => AddEntryScreen()),
        GetPage(name: '/entry_details', page: () => EntryDetailsScreen()),
      ],
    );
  }
}

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../controllers/diary_controller.dart';

class EntryDetailsScreen extends StatelessWidget {
  final DiaryController controller = Get.find();

  EntryDetailsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final id = Get.arguments as int;
    final entry = controller.getEntryById(id);

    return Scaffold(
      appBar: AppBar(
        title: Text(entry.title),
        // actions: [
        //   IconButton(
        //     icon: Icon(Icons.edit),
        //     onPressed: () {
        //       Get.toNamed('/edit_entry', arguments: entry.id);
        //     },
        //   ),
        //   IconButton(
        //     icon: Icon(Icons.delete),
        //     onPressed: () {
        //       Get.dialog(
        //         AlertDialog(
        //           title: Text('Delete entry?'),
        //           content: Text('Are you sure you want to delete this entry?'),
        //           actions: [
        //             TextButton(
        //               child: Text('Cancel'),
        //               onPressed: () {
        //                 Get.back();
        //               },
        //             ),
        //             TextButton(
        //               child: Text('Delete'),
        //               onPressed: () {
        //                 controller.deleteEntry(entry.id);
        //                 Get.back();
        //                 Get.back();
        //               },
        //             ),
        //           ],
        //         ),
        //       );
        //     },
        //   ),
        // ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '${entry.title}',
              style: TextStyle(fontSize: 24.0, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 16.0),
            Text(
              'Date: ${entry.datetime}',
              style: TextStyle(fontSize: 18.0),
            ),
            SizedBox(height: 16.0),
            Text(
              '${entry.description}',
              style: TextStyle(fontSize: 16.0),
            ),
          ],
        ),
      ),
    );
  }
}

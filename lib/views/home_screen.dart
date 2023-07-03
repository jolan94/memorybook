import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:memorybook/components/global.dart';
import 'package:memorybook/views/profile_screen.dart';
import '../controllers/diary_controller.dart';

class HomeScreen extends StatelessWidget {
  final DiaryController controller = Get.find();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('My Diary'),
        actions: [
          IconButton(
            icon: CircleAvatar(
              backgroundImage: GlobalData.profilePhoto != null ? FileImage(GlobalData.profilePhoto!) : null,
              child: GlobalData.profilePhoto == null ? const Icon(Icons.person) : null,
            ),
            onPressed: () => Get.to(() => const ProfileScreen()),
          ),
        ],
      ),
      body: Obx(() => ListView.builder(
            itemCount: controller.entries.length,
            itemBuilder: (context, index) {
              final entry = controller.entries[index];
              final formattedDateTime = DateFormat('E, MMM d').format(entry.datetime); // Format the date time
              return Container(
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                      color: Colors.black26,
                      blurRadius: 4,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: ListTile(
                  title: Text(
                    entry.title,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  subtitle: Text(
                    entry.description,
                    style: const TextStyle(
                      color: Colors.black87,
                    ),
                  ),
                  leading: Text(
                    formattedDateTime,
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Colors.grey,
                    ),
                  ),
                  onTap: () => Get.toNamed('/entry_details', arguments: entry.id),
                ),
              );
            },
          )),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () {
          Get.toNamed('/add_entry');
          // controller.clearEntry();
        },
      ),
    );
  }
}

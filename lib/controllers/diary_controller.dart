import 'package:get/get.dart';
import 'package:memorybook/models/diary_entry.dart';
import 'package:memorybook/models/diary_repository.dart';
import 'package:memorybook/views/add_entry_screen.dart';

class DiaryController extends GetxController {
  final repository = DiaryRepository();
  RxList<DiaryEntry> entries = <DiaryEntry>[].obs;

  @override
  void onInit() async {
    super.onInit();
    entries.value = await repository.getAllEntries();
  }

  void addEntry(DiaryEntry entry) {
    repository.addEntry(entry);
    entries.add(entry);
  }

  void clearEntry() {
    repository.clearEntries();
  }

  void updateEntry(DiaryEntry entry) {
    repository.updateEntry(entry);
    final index = entries.indexWhere((e) => e.id == entry.id);
    entries[index] = entry;
  }

  void deleteEntry(int id) {
    repository.deleteEntry(id);
    entries.removeWhere((e) => e.id == id);
  }

  DiaryEntry getEntryById(int id) {
    return entries.firstWhere((e) => e.id == id);
  }
}

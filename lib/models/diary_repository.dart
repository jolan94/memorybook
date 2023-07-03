import 'package:get_storage/get_storage.dart';
import 'package:memorybook/models/diary_entry.dart';
import 'dart:convert';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';

class DiaryRepository {
  final box = GetStorage();
  final storage = FlutterSecureStorage();

  Future<List<DiaryEntry>> getAllEntries() async {
    final entriesString = await storage.read(key: 'diary_entries');
    if (entriesString == null) {
      return [];
    } else {
      final entriesJson = json.decode(entriesString) as List;
      return entriesJson.map((e) => DiaryEntry.fromJson(e)).toList();
    }
  }

  Future<void> addEntry(DiaryEntry entry) async {
    final entries = await getAllEntries();
    entries.add(entry);
    final entriesString = json.encode(entries);
    await storage.write(key: 'diary_entries', value: entriesString);
  }

  Future<void> updateEntry(DiaryEntry entry) async {
    final entries = await getAllEntries();
    final index = entries.indexWhere((e) => e.id == entry.id);
    entries[index] = entry;
    final entriesString = json.encode(entries);
    await storage.write(key: 'diary_entries', value: entriesString);
  }

  Future<void> deleteEntry(int id) async {
    final entries = await getAllEntries();
    entries.removeWhere((e) => e.id == id);
    final entriesString = json.encode(entries);
    await storage.write(key: 'diary_entries', value: entriesString);
  }

  Future<void> clearEntries() async {
    await storage.delete(key: 'diary_entries');
  }
}

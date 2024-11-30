import 'dart:io';
import 'package:flutter/services.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseHelper {
  static Database? _database;

  static Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDatabase();
    return _database!;
  }

  static Future<Database> _initDatabase() async {
    String dbPath = await getDatabasesPath();
    String path = join(dbPath, 'healthdata.db');

    if (!await databaseExists(path)) {
      ByteData data = await rootBundle.load('assets/healthdata.db');
      List<int> bytes =
          data.buffer.asUint8List(data.offsetInBytes, data.lengthInBytes);
      await File(path).writeAsBytes(bytes, flush: true);
    }

    return await openDatabase(path);
  }

  Future<int> insertDateIfNotExists(String date) async {
    final db = await database;
    final List<Map<String, dynamic>> existing = await db.query(
      'dates',
      where: 'date = ?',
      whereArgs: [date],
    );

    if (existing.isNotEmpty) {
      return existing.first['_id'];
    }

    return await db.insert('dates', {'date': date});
  }

  Future<void> insertHeartRate(String heartRate, int dateId) async {
    final db = await database;
    await db
        .insert('heart_rate_data', {'heart_rate': heartRate, '_did': dateId});
  }

  Future<void> insertPressure(String pressure, int dateId) async {
    final db = await database;
    await db.insert('pressure_data', {'pressure': pressure, '_did': dateId});
  }

  Future<void> insertSleepingHours(int hours, int dateId) async {
    final db = await database;
    await db.insert('sleeping_hours', {'hours': hours, '_did': dateId});
  }

  Future<void> insertSteps(String steps, int dateId) async {
    final db = await database;
    await db.insert('steps_data', {'steps': steps, '_did': dateId});
  }

  Future<void> insertWeight(String weight, int dateId) async {
    final db = await database;
    await db.insert('weight_data', {'weight': weight, '_did': dateId});
  }

  static Future<List<Map<String, dynamic>>> getChartData(
      String chartType) async {
    final db = await database;
    String query;

    switch (chartType) {
      case "steps":
        query = '''
        SELECT d.date, s.steps AS value 
        FROM dates d 
        JOIN steps_data s ON d._id = s._did
      ''';
        break;
      case "heart_rate":
        query = '''
        SELECT d.date, t.heart_rate AS value
        FROM dates d
        JOIN heart_rate_data t ON d._id = t._did
      ''';
        break;
      case "sleep":
        query = '''
        SELECT d.date, s.hours AS value
        FROM dates d
        JOIN sleeping_hours s ON d._id = s._did
      ''';
        break;
      case "weight":
        query = '''
        SELECT d.date, w.weight AS value
        FROM dates d
        JOIN weight_data w ON d._id = w._did
      ''';
        break;
      default:
        throw Exception("Unknown chart type: $chartType");
    }

    return await db.rawQuery(query);
  }
}

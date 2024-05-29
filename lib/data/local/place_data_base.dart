import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:flutter/services.dart';
import '../models/all_data_model.dart';

class PlacesDatabase {
  static final PlacesDatabase instance = PlacesDatabase._init();

  PlacesDatabase._init();

  factory PlacesDatabase() {
    return instance;
  }

  static Database? _database;

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('places.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    final script = await rootBundle.loadString('assets/places/regions.sql');
    final statements = script.split(';');

    for (final statement in statements) {
      if (statement.trim().isNotEmpty) {
        await db.execute(statement);
      }
    }
  }

  Future<List<Map<String, dynamic>>> executeQuery(String query) async {
    final db = await instance.database;
    return await db.rawQuery(query);
  }


  Future<List<DataModel>> getAllRegions() async {
    final db = await instance.database;
    final result = await db.query('regions');
    return result.map((json) => DataModel.fromJson(json)).toList();
  }

  Future<List<DataModel>> getAllDistricts() async {
    final db = await instance.database;
    final result = await db.query('districts');
    return result.map((json) => DataModel.fromJson(json)).toList();
  }

  Future<List<DataModel>> getAllQuarters() async {
    final db = await instance.database;
    final result = await db.query('quarters');
    return result.map((json) => DataModel.fromJson(json)).toList();
  }
}

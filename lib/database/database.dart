// // lib/utils/database_helper.dart
//
// import 'dart:async';
// import 'dart:convert';
// import 'dart:developer';
//
// import 'package:Alfalah/widgets/horizontal_Calender.dart';
// import 'package:get/get.dart';
// import 'package:intl/intl.dart';
// import 'package:path/path.dart';
// import 'package:sqflite/sqflite.dart';
//
// import '../../models/islamic_calender_model.dart';
// import '../model/calender_table_model.dart';
//
// class DatabaseHelper {
//   // var calender_key = GlobalKeys.weekCalendarKey.obs;
//   // IslamicTimesController calenderController=Get.put(IslamicTimesController());
//   static Database? _database;
//
//   Future<Database?> get database async {
//     if (_database != null) {
//       return _database;
//     }
//     _database = await initializeDatabase();
//     return _database;
//   }
//
//   Future<Database> initializeDatabase() async {
//     final String path = await getDatabasesPath();
//     final String databaseName = 'firstapp.db';
//     final String fullPath = join(path, databaseName);
//
//     _database = await openDatabase(
//       fullPath,
//       version: 1,
//       onCreate: (db, version) async {
//         await db.execute('''
//       CREATE TABLE calendar (
//
//       fajr TEXT DEFAULT NULL,
//       sunrise TEXT DEFAULT NULL,
//       dhuhr TEXT DEFAULT NULL,
//       asr TEXT DEFAULT NULL,
//       sunset TEXT DEFAULT NULL,
//       maghrib TEXT DEFAULT NULL,
//       isha TEXT DEFAULT NULL,
//       gregorian_date TEXT UNIQUE,
//       gregorian_month INTEGER DEFAULT NULL,
//       gregorian_year TEXT DEFAULT NULL,
//       hijri_date TEXT DEFAULT NULL,
//       hijri_month TEXT DEFAULT NULL,
//       hijri_year TEXT DEFAULT NULL,
//       isWeek INTEGER DEFAULT 0,
//       isSelected INTEGER DEFAULT 0,
//       holidays TEXT DEFAULT NULL
//
//       )
//     ''');
//         await db.execute('''
//       CREATE TABLE prayerTracking (
//       id INTEGER PRIMARY KEY,
//       fajr REAL DEFAULT 0,
//       dhuhr REAL DEFAULT 0,
//       asr REAL DEFAULT 0,
//       maghrib REAL DEFAULT 0,
//       isha REAL DEFAULT 0,
//       fajrTime REAL DEFAULT 0,
//       dhuhrTime REAL DEFAULT 0,
//       asrTime REAL DEFAULT 0,
//       maghribTime REAL DEFAULT 0,
//       ishaTime REAL DEFAULT 0,
//       gregorian_date TEXT UNIQUE,
//       total REAL DEFAULT 0,
//       duration REAL DEFAULT 0
//
//       )
//     ''');
//
//         try {
//           await db.transaction((txn) async {
//             await txn.execute('''
//       CREATE TRIGGER IF NOT EXISTS update_total_trigger
//       AFTER INSERT ON prayerTracking
//       BEGIN
//         UPDATE prayerTracking
//         SET total = ROUND((fajr + dhuhr + asr + maghrib + isha), 2),
//             duration = ROUND((fajrTime + dhuhrTime + asrTime + maghribTime + ishaTime), 2);
//       END;
//     ''');
//           });
//         } catch (e) {
//           print("Error creating trigger: $e");
//         }
//
//         try {
//           await db.transaction((txn) async {
//             await txn.execute('''
//       CREATE TRIGGER IF NOT EXISTS update_total_trigger_update
//       AFTER UPDATE ON prayerTracking
//       BEGIN
//         UPDATE prayerTracking
//         SET total = ROUND((fajr + dhuhr + asr + maghrib + isha), 2),
//             duration = ROUND((fajrTime + dhuhrTime + asrTime + maghribTime + ishaTime), 2)
//         WHERE id = OLD.id;
//       END;
//     ''');
//           });
//         } catch (e) {
//           print("Error creating trigger: $e");
//         }
//
//         //   await db.execute('''
//         //   CREATE TRIGGER IF NOT EXISTS update_total_trigger
//         //   AFTER INSERT ON prayerTracking
//         //   BEGIN
//         //     UPDATE prayerTracking
//         //     SET total = ROUND((fajr + dhuhr + asr + maghrib + isha),2);
//         //   END;
//         // ''');
//         //     await db.execute('''
//         //   CREATE TRIGGER IF NOT EXISTS update_total_trigger_update
//         //   AFTER UPDATE ON prayerTracking
//         //   BEGIN
//         //     UPDATE prayerTracking
//         //     SET total = ROUND((fajr + dhuhr + asr + maghrib + isha),2)
//         //     WHERE id = NEW.id;
//         //   END;
//         // ''');
//         await db.execute('''
//   CREATE TABLE IF NOT EXISTS Azkar (
//     id INTEGER PRIMARY KEY AUTOINCREMENT,
//     section_id INTEGER,
//     title TEXT,
//     lang TEXT,
//     type TEXT,
//     level TEXT,
//     child TEXT,
//     created_at TEXT DEFAULT CURRENT_TIMESTAMP,
//     updated_at TEXT DEFAULT CURRENT_TIMESTAMP
// );
//     ''');
//         await db.execute('''
// CREATE TABLE IF NOT EXISTS Child (
//     id INTEGER PRIMARY KEY AUTOINCREMENT,
//     section_id INTEGER,
//     title TEXT,
//     lang TEXT,
//     type TEXT,
//     level TEXT,
//     created_at TEXT DEFAULT CURRENT_TIMESTAMP,
//     updated_at TEXT DEFAULT CURRENT_TIMESTAMP,
//     azkar_id INTEGER,
//     FOREIGN KEY (azkar_id) REFERENCES Azkar(id)
// );
//     ''');
//         await db.execute('''
// CREATE TABLE IF NOT EXISTS Childern (
//     id INTEGER PRIMARY KEY AUTOINCREMENT,
//     section_id INTEGER,
//     title TEXT,
//     lang TEXT,
//     type TEXT,
//     level TEXT,
//     created_at TEXT DEFAULT CURRENT_TIMESTAMP,
//     updated_at TEXT DEFAULT CURRENT_TIMESTAMP,
//     child_id INTEGER,
//     FOREIGN KEY (child_id) REFERENCES Child(id)
// );
//     ''');
//         await db.execute('''
// CREATE TABLE IF NOT EXISTS Contents (
//     id INTEGER PRIMARY KEY AUTOINCREMENT,
//     section_id INTEGER,
//     content TEXT,
//     roman_arabic TEXT,
//     english_translation TEXT,
//     reference TEXT,
//     file TEXT,
//     type TEXT,
//     tags TEXT,
//     created_at TEXT DEFAULT CURRENT_TIMESTAMP,
//     updated_at TEXT DEFAULT CURRENT_TIMESTAMP
// );
//     ''');
//         await db.execute('''
// CREATE TABLE IF NOT EXISTS Notes (
//     id INTEGER PRIMARY KEY AUTOINCREMENT,
//     content TEXT UNIQUE,
//     roman_arabic TEXT,
//     english_translation TEXT,
//     reference TEXT,
//     Note TEXT
// );
//     ''');
//         await db.execute('''
// CREATE TABLE IF NOT EXISTS Quran (
//     id INTEGER,
//     code INTEGER,
//     status TEXT,
//     data TEXT
// );
//     ''');
//         await db.execute('''
// CREATE TABLE IF NOT EXISTS QuranJuz (
//     id INTEGER,
//     code INTEGER,
//     status TEXT,
//     data TEXT
// );
//     ''');
//         // Execute the ALTER TABLE statement to add the colum
//       },
//     );
//
//     return _database!;
//   }
//
//
//   Future<void> insertCalendarData(IslamicCalenderModel data) async {
//     await _database!.insert('calendar', data.toMap(),
//         conflictAlgorithm: ConflictAlgorithm.replace);
//   }
//
//   Future insertPrayerTracking(Map<String, dynamic> data) async {
//     // var data = {
//     //   "fajr": 0.2,
//     //   "dhuhr": 0.2,
//     //   "asr": 0.2,
//     //   "maghrib": 0.2,
//     //   "gregorian_date": DateTime.now().toString(),
//     //   "isha": 0,
//     //   "total": 0.8,
//     //   "duration": 0
//     // };
//     // log("this is map data ${data}");
//     var list = await _database!.query(
//       'prayerTracking',
//       where: 'gregorian_date = ?',
//       whereArgs: [data["gregorian_date"]],
//     );
//     if (list.length == 0 || list.isEmpty) {
//       await _database!.insert('prayerTracking', data,
//           conflictAlgorithm: ConflictAlgorithm.replace);
//     } else {
//       var updatedData = await _database!.update('prayerTracking', data,
//           where: "gregorian_date = ?",
//           whereArgs: [data["gregorian_date"]],
//           conflictAlgorithm: ConflictAlgorithm.replace);
//       log("this is updated data: ${updatedData}");
//     }
//   }
//
//   Future getorSetNimztracking(String date) async {
//     var list = await _database!.query(
//       'prayerTracking',
//       where: 'gregorian_date = ?',
//       whereArgs: [date],
//     );
//     if (list.length == 0 || list.isEmpty) {
//       return null;
//       // await _database!.insert('prayerTracking', data,
//       //     conflictAlgorithm: ConflictAlgorithm.replace);
//     } else {
//       // for (var i = 0;
//       //     i < calender_key.value.currentState!.tackingValue.length;
//       //     i++) {
//       //   if (calender_key.value.currentState!.tackingValue[i]
//       //           ["gregorian_date"] ==
//       //       date) {
//       //     calender_key.value.currentState!.tackingValue[i] = list[0];
//       //     calender_key.value.currentState!.tackingValue[i]["total"] =
//       //         list[0]["total"];
//       //   }
//       // }
//
//       return list[0];
//     }
//   }
//
//   Future insertWeekPrayerTracking(Map<String, dynamic> data) async {
//     // var data = {
//     //   "fajr": 0.2,
//     //   "dhuhr": 0.2,
//     //   "asr": 0.2,
//     //   "maghrib": 0.2,
//     //   "gregorian_date": DateTime.now().toString(),
//     //   "isha": 0,
//     //   "total": 0.8,
//     //   "duration": 0
//     // };
//     // log("this is map data ${data}");
//     var list = await _database!.query(
//       'prayerTracking',
//       where: 'gregorian_date = ?',
//       whereArgs: [data["gregorian_date"]],
//     );
//     if (list.length == 0 || list.isEmpty) {
//       await _database!.insert('prayerTracking', data,
//           conflictAlgorithm: ConflictAlgorithm.replace);
//       return data;
//     } else {
//       return list[0];
//       // await _database!.update('prayerTracking', data,
//       //     where: "gregorian_date = ?",
//       //     whereArgs: [data["gregorian_date"]],
//       //     conflictAlgorithm: ConflictAlgorithm.replace);
//     }
//   }
//
//   Future getPrayerTracking(String date) async {
//     var list = await _database!.query(
//       'prayerTracking',
//       where: 'gregorian_date = ?',
//       whereArgs: [date],
//     );
//     // update()
//     return list;
//   }
//
//   Future getMonthCalender(String date) async {
//     DateTime newDate = DateFormat('dd-MM-yyyy').parse(date);
//
//     // Get the weekday number from the DateTime object
//     int monthNumber = newDate.month;
//     // int monthNumber = DateTime.now().month;
//     List<Map<String, dynamic>> list = await _database!.query(
//       'calendar',
//       where: 'gregorian_month = ?',
//       whereArgs: [monthNumber],
//     );
//     return list;
//   }
//
//   Future getIslamicMonthCalender(String date) async {
//     log("this is the date of current islamic :${date}");
//     List<Map<String, dynamic>> list = await _database!.query(
//       'calendar',
//       where: 'hijri_date = ?',
//       whereArgs: [date],
//     );
//     List<Map<String, dynamic>> month = await _database!.query(
//       'calendar',
//       where: 'hijri_month = ?',
//       whereArgs: [list[0]["hijri_month"]],
//     );
//     log("this is the date of islamic:${month.length}");
//     return month;
//   }
//
//   Future updateCalenderDate(Map<String, dynamic> data) async {
//     await _database!.update('calendar', data,
//         where: "gregorian_date = ?",
//         whereArgs: [data["gregorian_date"]],
//         conflictAlgorithm: ConflictAlgorithm.replace);
//   }
//
//   Future updateIslamicCalenderDate(Map<String, dynamic> data) async {
//     await _database!.update('calendar', data,
//         where: "hijri_date = ?",
//         whereArgs: [data["hijri_date"]],
//         conflictAlgorithm: ConflictAlgorithm.replace);
//   }
//
//   Future updatePrayerTracking(Map<String, dynamic> data) async {
//     await _database!.update('prayerTracking', data,
//         where: "gregorian_date = ?",
//         whereArgs: [data["gregorian_date"]],
//         conflictAlgorithm: ConflictAlgorithm.replace);
//   }
//
//   Future<void> storeCalendarData(List calendarDataList) async {
//     print(calendarDataList.length);
//     if (calendarDataList.isEmpty) {
//       return;
//     }
//
//     try {
//       for (var calendarData in calendarDataList) {
//         // Perform null checks before accessing sub-properties
//         final timings = calendarData.timings;
//         final date = calendarData.date;
//         // final meta = calendarData.meta;
//
//         if (timings != null && date != null) {
//           await _database!.insert(
//             'calendar',
//             {
//               'fajr': timings.fajr,
//               'sunrise': timings.sunrise,
//               'dhuhr': timings.dhuhr,
//               'asr': timings.asr,
//               'sunset': timings.sunset,
//               'maghrib': timings.maghrib,
//               'isha': timings.isha,
//               'gregorian_date': date.gregorian?.date,
//               // 'gregorian_weekday': date.gregorian?.weekday?.en,
//               'gregorian_month': date.gregorian?.month?.number,
//               'gregorian_year': date.gregorian?.year,
//               'hijri_date': date.hijri?.date,
//               // 'hijri_weekday': stickyEnValues.reverse[date.hijri?.weekday?.en],
//               'hijri_month': tentacledEnValues.reverse[date.hijri?.month?.en],
//               'hijri_year': date.hijri?.year,
//               'holidays': jsonEncode(date.hijri?.holidays),
//               // 'latitude': meta.latitude,
//               // 'longitude': meta.longitude,
//             },
//             conflictAlgorithm: ConflictAlgorithm.replace,
//           );
//         }
//         print("Data Added ${calendarDataList.length - 1}");
//       }
//     } catch (e) {
//       return print("Error while inserting $e");
//     }
//   }
//   Future<void> storeUpdatedCalendarData(List calendarDataList) async {
//     print(calendarDataList.length);
//     if (calendarDataList.isEmpty) {
//       return;
//     }
//
//     try {
//       for (var calendarData in calendarDataList) {
//         // Perform null checks before accessing sub-properties
//         final timings = calendarData.timings;
//         final date = calendarData.date;
//         // final meta = calendarData.meta;
//
//         if (timings != null && date != null) {
//           await _database!.update(
//             'calendar',
//             {
//               'fajr': timings.fajr,
//               'sunrise': timings.sunrise,
//               'dhuhr': timings.dhuhr,
//               'asr': timings.asr,
//               'sunset': timings.sunset,
//               'maghrib': timings.maghrib,
//               'isha': timings.isha,
//               'gregorian_date': date.gregorian?.date,
//               // 'gregorian_weekday': date.gregorian?.weekday?.en,
//               'gregorian_month': date.gregorian?.month?.number,
//               'gregorian_year': date.gregorian?.year,
//               'hijri_date': date.hijri?.date,
//               // 'hijri_weekday': stickyEnValues.reverse[date.hijri?.weekday?.en],
//               'hijri_month': tentacledEnValues.reverse[date.hijri?.month?.en],
//               'hijri_year': date.hijri?.year,
//               'holidays': jsonEncode(date.hijri?.holidays),
//               // 'latitude': meta.latitude,
//               // 'longitude': meta.longitude,
//             },
//             conflictAlgorithm: ConflictAlgorithm.replace,
//           );
//         }
//         print("Data Added ${calendarDataList.length - 1}");
//       }
//     } catch (e) {
//       return print("Error while inserting $e");
//     }
//   }
//
//   Future<void> addInAzkar(List calendarDataList) async {
//     if (calendarDataList.isEmpty) {
//       return;
//     }
//
//     try {
//       for (int i = 0; i < calendarDataList.length; i++) {
//         await _database!.insert(
//           'Azkar',
//           {
//             'section_id': calendarDataList[i]["section_id"],
//             'title': calendarDataList[i]["title"],
//             'lang': calendarDataList[i]["lang"],
//             'type': calendarDataList[i]["type"],
//             'level': calendarDataList[i]["level"],
//             'created_at': calendarDataList[i]["created_at"],
//             'updated_at': calendarDataList[i]["updated_at"],
//             "child": calendarDataList[i]["child"].toString(),
//             // 'latitude': meta.latitude,
//             // 'longitude': meta.longitude,
//           },
//           conflictAlgorithm: ConflictAlgorithm.replace,
//         );
//       }
//     } catch (e) {
//       return print("Error while inserting $e");
//     }
//   }
//
//   Future<void> addInAzkarChild(List calendarDataList) async {
//     if (calendarDataList.isEmpty) {
//       return;
//     }
//
//     try {
//       for (int i = 0; i < calendarDataList.length; i++) {
//         await _database!.insert(
//           'Child',
//           {
//             'id': calendarDataList[i]["id"],
//             'section_id': calendarDataList[i]["section_id"],
//             'title': calendarDataList[i]["title"],
//             'lang': calendarDataList[i]["lang"],
//             'type': calendarDataList[i]["type"],
//             'level': calendarDataList[i]["level"],
//             'created_at': calendarDataList[i]["created_at"],
//             'updated_at': calendarDataList[i]["updated_at"],
//             "azkar_id": 1
//             // "child":calendarDataList[i]["child"].toString(),
//             // 'latitude': meta.latitude,
//             // 'longitude': meta.longitude,
//           },
//           conflictAlgorithm: ConflictAlgorithm.replace,
//         );
//       }
//     } catch (e) {
//       return print("Error while inserting $e");
//     }
//   }
//
//   Future<void> addChildern(List calendarDataList) async {
//     if (calendarDataList.isEmpty) {
//       return;
//     }
//
//     try {
//       for (int i = 0; i < calendarDataList.length; i++) {
//         await _database!.insert(
//           'Childern',
//           {
//             'id': calendarDataList[i]["id"],
//             'section_id': calendarDataList[i]["section_id"],
//             'title': calendarDataList[i]["title"],
//             'lang': calendarDataList[i]["lang"],
//             'type': calendarDataList[i]["type"],
//             'level': calendarDataList[i]["level"],
//             'created_at': calendarDataList[i]["created_at"],
//             'updated_at': calendarDataList[i]["updated_at"],
//             // "azkar_id":1
//             // "child":calendarDataList[i]["child"].toString(),
//             // 'latitude': meta.latitude,
//             // 'longitude': meta.longitude,
//           },
//           conflictAlgorithm: ConflictAlgorithm.replace,
//         );
//       }
//     } catch (e) {
//       return print("Error while inserting $e");
//     }
//   }
//
//   Future<void> addContents(List calendarDataList) async {
//     if (calendarDataList.isEmpty) {
//       return;
//     }
//
//     try {
//       for (int i = 0; i < calendarDataList.length; i++) {
//         await _database!.insert(
//           'Contents',
//           {
//             'id': calendarDataList[i]["id"],
//             'section_id': calendarDataList[i]["section_id"],
//             'content': calendarDataList[i]["content"].toString(),
//             'roman_arabic': calendarDataList[i]["roman_arabic"].toString(),
//             'english_translation':
//             calendarDataList[i]["english_translation"].toString(),
//             'reference': calendarDataList[i]["reference"].toString(),
//             'file': calendarDataList[i]["file"].toString(),
//             'type': calendarDataList[i]["type"].toString(),
//             'created_at': calendarDataList[i]["created_at"].toString(),
//             'updated_at': calendarDataList[i]["updated_at"].toString(),
//             'tags': calendarDataList[i]["tags"].toString()
//             // "azkar_id":1
//             // "child":calendarDataList[i]["child"].toString(),
//             // 'latitude': meta.latitude,
//             // 'longitude': meta.longitude,
//           },
//           conflictAlgorithm: ConflictAlgorithm.replace,
//         );
//       }
//     } catch (e) {
//       return print("Error while inserting $e");
//     }
//   }
//
//   Future<List<CalendarData>> getCalendarDataForDate(DateTime date) async {
//     final String formattedDate = DateFormat('dd-MM-yyyy').format(date);
//     final List<Map<String, dynamic>> maps = await _database!.query(
//       'calendar',
//       where: 'gregorian_date = ?',
//       whereArgs: [formattedDate],
//     );
//     print(maps);
//     List<CalendarData> calendarDataList = [];
//     for (var map in maps) {
//       calendarDataList.add(CalendarData.fromJson(map));
//     }
//     return calendarDataList;
//   }
//   Future getallData()async{
//     var list = await _database!.query(
//       'calendar',
//     );return list;
//   }
//   Future checkQuranAyah(int id)async{
//     try{
//
//       var list = await _database!.query(
//         'Quran',
//         where: 'id = ?',
//         whereArgs: [id],
//       );
//       if (list.length == 0 || list.isEmpty) {
//         log("this is not avaiable:");
//         return null;
//         // await _database!.insert('Quran', data,
//         //     conflictAlgorithm: ConflictAlgorithm.replace);
//       } else {
//         return list[0];
//         // var updatedData = await _database!.update('prayerTracking', data,
//         //     where: "gregorian_date = ?",
//         //     whereArgs: [data["gregorian_date"]],
//         //     conflictAlgorithm: ConflictAlgorithm.replace);
//         // log("this is updated data: ${updatedData}");
//       }
//     } catch (e) {}
//   }
//
//   Future addQuranAyah(Map<String, dynamic> data) async {
//     await _database!
//         .insert('Quran', data, conflictAlgorithm: ConflictAlgorithm.replace);
//   }
//
//   Future addQuranJuz(Map<String, dynamic> data) async {
//     await _database!
//         .insert('QuranJuz', data, conflictAlgorithm: ConflictAlgorithm.replace);
//   }
//
//   Future checkQuranJuz(int id)async{
//     try{
//
//       var list = await _database!.query(
//         'QuranJuz',
//         where: 'id = ?',
//         whereArgs: [id],
//       );
//       if (list.length == 0 || list.isEmpty) {
//         log("this is not avaiable:");
//         return null;
//         // await _database!.insert('Quran', data,
//         //     conflictAlgorithm: ConflictAlgorithm.replace);
//       } else {
//         return list[0];
//         // var updatedData = await _database!.update('prayerTracking', data,
//         //     where: "gregorian_date = ?",
//         //     whereArgs: [data["gregorian_date"]],
//         //     conflictAlgorithm: ConflictAlgorithm.replace);
//         // log("this is updated data: ${updatedData}");
//       }
//
//     }catch (e){}
//   }
//
// // Future<IslamicCalenderModel> getCalendarData() async {
// //   final List<Map<String, dynamic>> maps = await _database!.query('calendar');
// //
// //   // Assuming there's only one record in the database for simplicity
// //   if (maps.isNotEmpty) {
// //     return IslamicCalenderModel.fromMap(maps.first);
// //   } else {
// //     throw Exception('No calendar data found in the database');
// //   }
// // }
// }

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:notepad_flutter/features/controller/main_controller.dart';
import 'features/data/dao/note_dao.dart';
import 'features/data/database/database.dart';
import 'features/presentation/pages/home_screen.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  final database =
      await $FloorAppDatabase.databaseBuilder('my_database.db').build();
  final noteDao = database.noteDao;
  // await noteDao.deleteAllNotes();
  runApp(MyApp(
    noteDao: noteDao,
  ));
}

class MyApp extends StatelessWidget {
  final NoteDao noteDao;

  const MyApp({Key? key, required this.noteDao}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final m = Get.put(MainController(noteDao));
    return GetMaterialApp(
      theme: ThemeData.from(
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.amber,
        ),
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}

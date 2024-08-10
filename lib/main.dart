import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';
import 'package:task_management_app/screens/task_list_screeen.dart'; // Mengimpor layar daftar tugas
import 'providers/task_provider.dart'; // Mengimpor provider untuk tugas

void main() {
  // Entry point aplikasi, memanggil runApp untuk menjalankan aplikasi Flutter
  runApp(MyApp());
}

// MyApp adalah widget utama aplikasi yang merupakan turunan dari StatelessWidget
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Mengatur mode sistem UI ke edge-to-edge (layar penuh) dan menyembunyikan overlay seperti status bar
    SystemChrome.setEnabledSystemUIMode(SystemUiMode.edgeToEdge, overlays: []);

    return ChangeNotifierProvider(
      // Menginisialisasi TaskProvider sebagai state management global
      create: (context) => TaskProvider(),
      child: MaterialApp(
        title: 'Task Management App', // Judul aplikasi
        home: TaskListScreen(), // Menentukan layar utama yang akan ditampilkan
      ),
    );
  }
}

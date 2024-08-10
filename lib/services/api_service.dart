import 'dart:convert';
import 'package:http/http.dart' as http;
import '../models/task.dart'; // Mengimpor model Task

// ApiService menyediakan metode untuk berinteraksi dengan API backend
class ApiService {
  // Base URL untuk API. Disesuaikan dengan emulator/simulator yang digunakan
  final String baseUrl = 'http://10.0.2.2:3000'; // Untuk emulator Android
  // final String baseUrl = 'http://localhost:3000'; // Untuk simulator iOS

  // Method untuk mengambil daftar tugas dari API
  Future<List<Task>> getTasks() async {
    // Melakukan HTTP GET request ke endpoint '/todos'
    final response = await http.get(Uri.parse('$baseUrl/todos'));

    // Memeriksa apakah request berhasil (status code 200)
    if (response.statusCode == 200) {
      // Jika berhasil, decode JSON dan ubah menjadi List<Task>
      List<dynamic> data = json.decode(response.body);
      return data.map((json) => Task.fromJson(json)).toList();
    } else {
      // Jika gagal, lemparkan exception
      throw Exception('Failed to load tasks');
    }
  }

  // Method untuk menambahkan tugas baru ke API
  Future<Task> addTask(Task task) async {
    // Melakukan HTTP POST request ke endpoint '/todos'
    final response = await http.post(
      Uri.parse('$baseUrl/todos'),
      headers: {
        'Content-Type': 'application/json'
      }, // Mengatur header konten ke JSON
      body: json
          .encode(task.toJson()), // Mengubah task menjadi JSON untuk dikirim
    );

    // Memeriksa apakah request berhasil (status code 201)
    if (response.statusCode == 201) {
      // Jika berhasil, decode JSON dan ubah menjadi objek Task
      return Task.fromJson(json.decode(response.body));
    } else {
      // Jika gagal, lemparkan exception
      throw Exception('Failed to add task');
    }
  }

  // Method untuk memperbarui tugas yang ada di API
  Future<Task> updateTask(Task task) async {
    // Melakukan HTTP PUT request ke endpoint '/todos/{id}'
    final response = await http.put(
      Uri.parse('$baseUrl/todos/${task.id}'),
      headers: {
        'Content-Type': 'application/json'
      }, // Mengatur header konten ke JSON
      body: json
          .encode(task.toJson()), // Mengubah task menjadi JSON untuk dikirim
    );

    // Memeriksa apakah request berhasil (status code 200)
    if (response.statusCode == 200) {
      // Jika berhasil, decode JSON dan ubah menjadi objek Task
      return Task.fromJson(json.decode(response.body));
    } else {
      // Jika gagal, lemparkan exception
      throw Exception('Failed to update task');
    }
  }

  // Method untuk menghapus tugas dari API berdasarkan ID
  Future<void> deleteTask(int id) async {
    // Melakukan HTTP DELETE request ke endpoint '/todos/{id}'
    final response = await http.delete(Uri.parse('$baseUrl/todos/$id'));

    // Memeriksa apakah request berhasil (status code 204)
    if (response.statusCode != 204) {
      // Jika gagal, lemparkan exception
      throw Exception('Failed to delete task');
    }
  }
}

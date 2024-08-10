import 'dart:ui';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import '../models/task.dart';
import '../services/api_service.dart';

// TaskProvider mengelola data Task dan menyediakan notifikasi ketika data berubah
class TaskProvider with ChangeNotifier {
  final ApiService _apiService =
      ApiService(); // Menginisialisasi ApiService untuk interaksi dengan API
  List<Task> _tasks = []; // Menyimpan daftar tugas yang diambil dari API
  bool _isFetching =
      false; // Menunjukkan status apakah sedang mengambil data atau tidak

  // Getter untuk mendapatkan daftar tugas
  List<Task> get tasks => _tasks;

  // Getter untuk mengetahui apakah data sedang diambil
  bool get isFetching => _isFetching;

  // Method untuk mengambil daftar tugas dari API
  Future<void> fetchTasks() async {
    _isFetching = true; // Mengatur status menjadi sedang mengambil data
    notifyListeners(); // Memberitahukan pendengar (widget) bahwa data sedang diambil

    try {
      // Coba untuk mengambil daftar tugas dari API
      _tasks = await _apiService.getTasks();
    } catch (e) {
      // Jika terjadi kesalahan saat mengambil data, tampilkan pesan error
      print('Error fetching tasks: $e');
      _showToast(
          "Failed to fetch tasks"); // Tampilkan toast untuk memberi tahu pengguna
    } finally {
      _isFetching = false; // Mengatur status menjadi tidak mengambil data lagi
      notifyListeners(); // Memberitahukan pendengar bahwa data telah diambil
    }
  }

  // Method untuk menambahkan tugas baru
  Future<void> addTask(Task task) async {
    try {
      // Coba untuk menambahkan tugas baru melalui API
      Task newTask = await _apiService.addTask(task);
      _tasks.add(newTask); // Tambahkan tugas baru ke daftar lokal
      notifyListeners(); // Beritahu pendengar bahwa ada tugas baru
      _showToast(
          "Task added successfully"); // Tampilkan toast untuk memberi tahu pengguna
    } catch (e) {
      // Jika terjadi kesalahan saat menambahkan tugas, tampilkan pesan error
      print('Error adding task: $e');
      _showToast(
          "Failed to add task"); // Tampilkan toast untuk memberi tahu pengguna
    }
  }

  // Method untuk memperbarui tugas yang ada
  Future<void> updateTask(Task task) async {
    try {
      // Coba untuk memperbarui tugas melalui API
      await _apiService.updateTask(task);
      fetchTasks(); // Ambil ulang daftar tugas setelah diperbarui
      _showToast(
          "Task updated successfully"); // Tampilkan toast untuk memberi tahu pengguna
    } catch (e) {
      // Jika terjadi kesalahan saat memperbarui tugas, tampilkan pesan error
      print('Error updating task: $e');
      _showToast(
          "Failed to update task"); // Tampilkan toast untuk memberi tahu pengguna
    }
  }

  // Method untuk menghapus tugas berdasarkan ID
  Future<void> deleteTask(int taskId) async {
    try {
      // Coba untuk menghapus tugas melalui API
      await _apiService.deleteTask(taskId);
      fetchTasks(); // Ambil ulang daftar tugas setelah tugas dihapus
      _showToast(
          "Task deleted successfully"); // Tampilkan toast untuk memberi tahu pengguna
    } catch (e) {
      // Jika terjadi kesalahan saat menghapus tugas, tampilkan pesan error
      print('Error deleting task: $e');
      _showToast(
          "Failed to delete task"); // Tampilkan toast untuk memberi tahu pengguna
    }
  }

  // Method untuk menampilkan pesan toast di layar
  void _showToast(String message) {
    Fluttertoast.showToast(
      msg: message, // Pesan yang akan ditampilkan
      toastLength: Toast.LENGTH_SHORT, // Durasi toast
      gravity: ToastGravity.CENTER, // Posisi toast di layar
      backgroundColor:
          Color(0x4Db286e9), // Warna latar belakang toast (ungu terang)
      textColor: Color(0xFF6A3EA1), // Warna teks pada toast (ungu gelap)
      fontSize: 16.0, // Ukuran font untuk teks toast
    );
  }

  // Method placeholder untuk mengganti status penyelesaian tugas, bisa diimplementasikan nanti
  void toggleTaskCompletion(int id) {}
}

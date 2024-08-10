import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';
import '../models/task.dart';
import 'add_edit_task_screen.dart';

class TaskListScreen extends StatefulWidget {
  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  // Variabel untuk menyimpan query pencarian yang dimasukkan pengguna
  String _searchQuery = '';

  // Variabel untuk menyimpan status filter (bisa bernilai 'All', 'Completed', atau 'Incomplete')
  String _filterStatus = 'All';

  // FocusNode digunakan untuk melacak fokus dari TextField pencarian
  final FocusNode _focusNode = FocusNode();

  // Variabel untuk mengatur warna border dari TextField pencarian
  Color _borderColor = Colors.white;

  // Variabel untuk mengatur warna ikon pencarian
  Color _iconColor = Colors.grey;

  @override
  void initState() {
    super.initState();

    // Memastikan bahwa daftar tugas diambil dari penyedia (provider) setelah widget dibangun
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Provider.of<TaskProvider>(context, listen: false).fetchTasks();
    });

    // Menambahkan listener pada FocusNode untuk memantau apakah TextField sedang fokus atau tidak
    _focusNode.addListener(() {
      setState(() {
        if (_focusNode.hasFocus) {
          // Jika TextField sedang fokus, ubah warna border dan ikon menjadi warna ungu
          _borderColor = Color(0xFF6A3EA1);
          _iconColor = Color(0xFF6A3EA1);
        } else {
          // Jika TextField tidak fokus, kembalikan warna border dan ikon menjadi warna default
          _borderColor = Colors.white;
          _iconColor = Colors.grey;
        }
      });
    });
  }

  @override
  void dispose() {
    // Menghancurkan (dispose) FocusNode saat widget ini dibuang, untuk menghindari kebocoran memori
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white, // Warna latar belakang untuk layar
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20.0, vertical: 30.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Baris untuk menampilkan judul halaman dan ikon
              Row(
                children: [
                  Text(
                    'Task List', // Teks judul halaman
                    style: TextStyle(
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF6A3EA1), // Warna teks ungu
                    ),
                  ),
                  SizedBox(width: 10), // Memberi jarak antara teks dan ikon
                  Icon(Icons.list_alt_rounded,
                      color: Color(0xFF6A3EA1), size: 30),
                ],
              ),
              SizedBox(
                  height: 16), // Jarak antara header dan TextField pencarian

              // Container yang membungkus TextField pencarian
              Container(
                decoration: BoxDecoration(
                  color: Colors.white, // Warna latar belakang TextField
                  borderRadius: BorderRadius.circular(
                      30), // Membuat sudut TextField menjadi melengkung
                  border:
                      Border.all(color: _borderColor), // Warna border TextField
                  boxShadow: [
                    // Efek bayangan di bawah TextField
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.1),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(0, 3),
                    ),
                  ],
                ),
                child: TextField(
                  focusNode: _focusNode, // Menambahkan FocusNode ke TextField
                  decoration: InputDecoration(
                    hintText: 'Search', // Placeholder teks di dalam TextField
                    hintStyle:
                        TextStyle(color: Colors.grey), // Warna teks placeholder
                    prefixIcon: Icon(Icons.search,
                        color: _iconColor), // Ikon pencarian di dalam TextField
                    border: InputBorder
                        .none, // Menghilangkan border default dari TextField
                    contentPadding: EdgeInsets.symmetric(
                        vertical: 15,
                        horizontal: 20), // Padding di dalam TextField
                  ),
                  onChanged: (value) {
                    // Memperbarui nilai _searchQuery saat pengguna mengetik di TextField
                    setState(() {
                      _searchQuery = value;
                    });
                  },
                ),
              ),
              SizedBox(
                  height:
                      16), // Jarak antara TextField pencarian dan filter status tugas

              // Row untuk menampilkan filter status tugas
              Row(
                children: [
                  _buildFilterChip(
                      'All'), // Membuat chip filter untuk status 'All'
                  SizedBox(width: 8), // Jarak antara chip filter
                  _buildFilterChip(
                      'Completed'), // Membuat chip filter untuk status 'Completed'
                  SizedBox(width: 8), // Jarak antara chip filter
                  _buildFilterChip(
                      'Incomplete'), // Membuat chip filter untuk status 'Incomplete'
                ],
              ),
              SizedBox(
                  height: 16), // Jarak antara filter status dan daftar tugas

              // Expanded digunakan agar ListView di bawahnya mengambil ruang yang tersisa di layar
              Expanded(
                child: Consumer<TaskProvider>(
                  // Konsumen TaskProvider yang memberikan akses ke data dan status tugas
                  builder: (context, taskProvider, child) {
                    if (taskProvider.isFetching) {
                      // Menampilkan indikator loading saat tugas sedang diambil
                      return Center(child: CircularProgressIndicator());
                    }

                    if (taskProvider.tasks.isEmpty) {
                      // Jika tidak ada tugas, tampilkan pesan
                      return Center(
                        child: Text(
                          'No tasks yet. Click + to add a task.',
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                      );
                    }

                    // Filter daftar tugas berdasarkan query pencarian dan status filter
                    List<Task> filteredTasks = taskProvider.tasks.where((task) {
                      bool matchesSearch = task.title.toLowerCase().contains(
                          _searchQuery
                              .toLowerCase()); // Apakah judul tugas mengandung query pencarian
                      bool matchesFilter = _filterStatus == 'All' ||
                          (_filterStatus == 'Completed' && task.completed) ||
                          (_filterStatus == 'Incomplete' &&
                              !task
                                  .completed); // Apakah tugas sesuai dengan filter status
                      return matchesSearch &&
                          matchesFilter; // Mengembalikan true jika tugas cocok dengan pencarian dan filter
                    }).toList();

                    if (filteredTasks.isEmpty) {
                      // Jika tidak ada tugas yang cocok dengan pencarian atau filter, tampilkan pesan
                      return Center(
                        child: Text(
                          'No task in this filter',
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                      );
                    }

                    // Menampilkan daftar tugas yang sudah difilter menggunakan ListView
                    return ListView.builder(
                      itemCount: filteredTasks
                          .length, // Jumlah item yang akan ditampilkan
                      itemBuilder: (context, index) {
                        Task task = filteredTasks[
                            index]; // Mengambil tugas berdasarkan index
                        return GestureDetector(
                          onTap: () {
                            // Navigasi ke layar tambah/edit tugas dengan data tugas yang dipilih
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    AddEditTaskScreen(task: task),
                              ),
                            );
                          },
                          child: Container(
                            margin: EdgeInsets.only(
                                bottom:
                                    16), // Memberi jarak antar item dalam ListView
                            padding: EdgeInsets.all(
                                16), // Padding di dalam container tugas
                            decoration: BoxDecoration(
                              color: Colors
                                  .white, // Warna latar belakang container tugas
                              borderRadius: BorderRadius.circular(
                                  16), // Sudut melengkung pada container tugas
                              boxShadow: [
                                // Efek bayangan pada container tugas
                                BoxShadow(
                                  color: Colors.grey.withOpacity(0.1),
                                  spreadRadius: 1,
                                  blurRadius: 5,
                                  offset: Offset(0, 3),
                                ),
                              ],
                            ),
                            child: Row(
                              children: [
                                // Kolom untuk menampilkan judul dan status tugas
                                Expanded(
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        task.title, // Menampilkan judul tugas
                                        style: TextStyle(
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          color: Color(
                                              0xFF1E0E3E), // Warna teks judul tugas
                                        ),
                                      ),
                                      SizedBox(
                                          height:
                                              4), // Jarak antara judul dan status tugas
                                      Text(
                                        task.completed
                                            ? 'Done'
                                            : 'Mark as done', // Menampilkan status tugas
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                    ],
                                  ),
                                ),
                                // Tombol untuk menandai tugas sebagai selesai atau belum selesai
                                GestureDetector(
                                  onTap: () {
                                    // Mengubah status tugas (completed atau tidak) dan memperbarui tugas melalui provider
                                    task.completed = !task.completed;
                                    taskProvider.updateTask(task);
                                  },
                                  child: Container(
                                    width: 24, // Lebar container tombol selesai
                                    height:
                                        24, // Tinggi container tombol selesai
                                    decoration: BoxDecoration(
                                      shape: BoxShape
                                          .circle, // Bentuk tombol menjadi lingkaran
                                      color: task.completed
                                          ? Color(
                                              0xFF6A3EA1) // Warna tombol jika tugas sudah selesai
                                          : Colors
                                              .transparent, // Warna tombol jika tugas belum selesai
                                      border: Border.all(
                                        color: Color(
                                            0xFF6A3EA1), // Warna border tombol
                                        width: 2, // Ketebalan border tombol
                                      ),
                                    ),
                                    child: task.completed
                                        ? Icon(Icons.check,
                                            size: 16,
                                            color: Colors
                                                .white) // Ikon centang jika tugas selesai
                                        : null, // Jika belum selesai, tidak ada ikon di dalam tombol
                                  ),
                                ),
                                SizedBox(
                                    width:
                                        16), // Jarak antara tombol selesai dan tombol hapus

                                // Tombol untuk menghapus tugas
                                GestureDetector(
                                  onTap: () => _showDeleteConfirmationDialog(
                                      context,
                                      taskProvider,
                                      task.id), // Menampilkan dialog konfirmasi hapus
                                  child: Icon(
                                    Icons.delete, // Ikon untuk tombol hapus
                                    color:
                                        Color(0xFF6A3EA1), // Warna ikon hapus
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),

      // Tombol mengambang untuk menambahkan tugas baru
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          // Navigasi ke layar tambah/edit tugas tanpa data (untuk menambahkan tugas baru)
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddEditTaskScreen()),
          );
        },
        child: Icon(Icons.add), // Ikon tambah pada tombol mengambang
        backgroundColor: Color(0xFF6A3EA1), // Warna latar belakang tombol
        elevation: 2, // Elevasi (ketinggian bayangan) tombol mengambang
      ),
    );
  }

  // Widget untuk membuat filter chip berdasarkan label yang diberikan
  Widget _buildFilterChip(String label) {
    bool isSelected = _filterStatus ==
        label; // Mengecek apakah chip yang dipilih sesuai dengan status filter saat ini
    return GestureDetector(
      onTap: () {
        // Mengubah status filter saat chip dipilih
        setState(() {
          _filterStatus = label;
        });
      },
      child: Container(
        padding: EdgeInsets.symmetric(
            horizontal: 16, vertical: 8), // Padding di dalam chip filter
        decoration: BoxDecoration(
          color: isSelected
              ? Color(0xFF6A3EA1)
              : Colors.transparent, // Warna latar belakang chip jika dipilih
          borderRadius: BorderRadius.circular(20), // Sudut melengkung pada chip
          border: Border.all(
            color: isSelected
                ? Color(0xFF6A3EA1)
                : Colors.grey, // Warna border chip berdasarkan statusnya
          ),
        ),
        child: Text(
          label, // Label teks yang ditampilkan pada chip
          style: TextStyle(
            color: isSelected
                ? Colors.white
                : Colors.grey, // Warna teks berdasarkan status chip
            fontWeight: isSelected
                ? FontWeight.bold
                : FontWeight.normal, // Ketebalan teks berdasarkan status chip
          ),
        ),
      ),
    );
  }

  // Fungsi untuk menampilkan dialog konfirmasi penghapusan tugas
  void _showDeleteConfirmationDialog(
      BuildContext context, TaskProvider taskProvider, int taskId) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Delete Task',
            style: TextStyle(color: Color(0xFF6A3EA1)), // Warna judul dialog
          ),
          content: Text(
              'Are you sure you want to delete this task?'), // Pesan konfirmasi
          actions: <Widget>[
            TextButton(
              child: Text(
                'Cancel',
                style:
                    TextStyle(color: Color(0xFF6A3EA1)), // Warna tombol Cancel
              ),
              onPressed: () {
                Navigator.of(context)
                    .pop(); // Menutup dialog tanpa melakukan tindakan
              },
            ),
            TextButton(
              child: Text(
                'Delete',
                style:
                    TextStyle(color: Color(0xFF6A3EA1)), // Warna tombol Delete
              ),
              onPressed: () {
                taskProvider.deleteTask(
                    taskId); // Menghapus tugas dengan ID yang diberikan
                Navigator.of(context)
                    .pop(); // Menutup dialog setelah penghapusan
              },
            ),
          ],
        );
      },
    );
  }
}

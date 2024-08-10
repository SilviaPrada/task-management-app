import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../providers/task_provider.dart';
import '../models/task.dart';

class AddEditTaskScreen extends StatefulWidget {
  final Task? task;

  AddEditTaskScreen({this.task});

  @override
  _AddEditTaskScreenState createState() => _AddEditTaskScreenState();
}

class _AddEditTaskScreenState extends State<AddEditTaskScreen> {
  // Membuat kunci untuk Form, yang digunakan untuk validasi input
  final _formKey = GlobalKey<FormState>();

  // Variabel untuk menyimpan nilai dari judul task dan status selesai
  late String _title;
  late bool _completed;

  @override
  void initState() {
    super.initState();
    // Inisialisasi nilai awal untuk judul dan status selesai
    // Jika task sudah ada (edit mode), gunakan nilai dari task tersebut
    // Jika tidak ada (add mode), gunakan nilai default (kosong dan tidak selesai)
    _title = widget.task?.title ?? '';
    _completed = widget.task?.completed ?? false;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        // Menampilkan judul AppBar berdasarkan mode (tambah/edit)
        title: Text(
          widget.task == null ? 'Add Task' : 'Edit Task',
          style: TextStyle(color: Color(0xFF6A3EA1)),
        ),
        backgroundColor: Colors.white, // Warna latar belakang AppBar
        elevation: 0, // Menghilangkan bayangan AppBar
        iconTheme: IconThemeData(color: Color(0xFF6A3EA1)), // Warna ikon AppBar
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Form(
          key: _formKey, // Kunci form yang digunakan untuk validasi input
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              // Input untuk judul task
              TextFormField(
                initialValue:
                    _title, // Nilai awal judul diambil dari variabel _title
                decoration: InputDecoration(
                  labelText: 'Task Title',
                  labelStyle:
                      TextStyle(color: Color(0xFF6A3EA1)), // Warna teks label
                  focusedBorder: UnderlineInputBorder(
                    borderSide: BorderSide(
                        color: Color(0xFF6A3EA1)), // Warna border saat fokus
                  ),
                ),
                // Validasi input untuk memastikan judul tidak kosong
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please enter a title'; // Pesan error jika input kosong
                  }
                  return null; // Tidak ada error
                },
                // Menyimpan nilai input ke dalam variabel _title saat form disimpan
                onSaved: (value) {
                  _title = value!;
                },
              ),
              SizedBox(
                  height: 20), // Jarak antara input judul dan status selesai
              // Baris untuk menampilkan status selesai task
              Row(
                children: [
                  Text(
                    'Completed', // Label untuk status selesai
                    style: TextStyle(fontSize: 16),
                  ),
                  SizedBox(
                      width: 8), // Jarak antara label dan tombol status selesai
                  // Tombol status selesai
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        _completed = !_completed; // Toggle status selesai
                      });
                    },
                    child: Container(
                      decoration: BoxDecoration(
                        shape: BoxShape.circle, // Bentuk tombol bulat
                        border: Border.all(
                          color: Color(0xFF6A3EA1), // Warna border tombol
                          width: 2.0,
                        ),
                        color: _completed
                            ? Color(0xFF6A3EA1)
                            : Colors
                                .white, // Warna tombol berdasarkan status selesai
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(4.0),
                        // Ikon untuk status selesai, hanya tampil jika task selesai
                        child: _completed
                            ? Icon(
                                Icons.check, // Ikon centang
                                size: 13.0, // Ukuran ikon
                                color: Colors.white,
                              )
                            : Icon(
                                Icons
                                    .check_box_outline_blank, // Ikon kosong jika task belum selesai
                                size: 13.0,
                                color: Colors.transparent,
                              ),
                      ),
                    ),
                  ),
                ],
              ),
              SizedBox(
                  height: 30), // Jarak antara status selesai dan tombol simpan
              // Tombol untuk menyimpan task
              SizedBox(
                width:
                    double.infinity, // Lebar tombol sesuai dengan lebar layar
                child: ElevatedButton(
                  onPressed:
                      _submitForm, // Fungsi yang dipanggil saat tombol ditekan
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Color(0xFF6A3EA1), // Warna ungu
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(
                          8.0), // Sudut melengkung pada tombol
                    ),
                  ),
                  child: Text('Save'), // Teks pada tombol
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Fungsi untuk menangani penyimpanan task
  void _submitForm() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save(); // Simpan nilai input dari form
      final taskProvider = Provider.of<TaskProvider>(context, listen: false);

      if (widget.task == null) {
        // Jika mode tambah (task belum ada), buat task baru
        Task newTask = Task(
          userId: 1, // ID user, biasanya didapat dari autentikasi
          id: 0, // ID task, biasanya di-generate oleh API
          title: _title, // Judul task yang diinput
          completed: _completed, // Status selesai task
        );
        taskProvider.addTask(newTask); // Tambahkan task baru ke provider
      } else {
        // Jika mode edit (task sudah ada), perbarui task
        Task updatedTask = Task(
          userId: widget.task!.userId, // ID user yang sama
          id: widget.task!.id, // ID task yang sama
          title: _title, // Judul task yang diinput
          completed: _completed, // Status selesai task
        );
        taskProvider.updateTask(updatedTask); // Perbarui task di provider
      }

      Navigator.pop(context); // Kembali ke layar sebelumnya setelah menyimpan
    }
  }
}

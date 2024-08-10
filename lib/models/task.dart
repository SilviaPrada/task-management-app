class Task {
  final int userId; // ID pengguna yang memiliki task
  final int
      id; // ID unik untuk task
  final String title; // Judul atau nama task
  bool completed; // Status apakah task ini sudah selesai atau belum

  // Konstruktor untuk membuat instance Task
  Task({
    required this.userId, // ID pengguna harus disediakan
    required this.id, // ID task juga harus disediakan
    required this.title, // Judul task harus disediakan
    required this.completed, // Status selesai harus disediakan
  });

  // Factory method untuk membuat instance Task dari JSON
  factory Task.fromJson(Map<String, dynamic> json) {
    return Task(
      userId: json['userId'], // Ambil ID pengguna dari data JSON
      id: json['id'], // Ambil ID task dari data JSON
      title: json['title'], // Ambil judul task dari data JSON
      completed: json['completed'], // Ambil status selesai dari data JSON
    );
  }

  // Method untuk mengonversi instance Task menjadi Map<String, dynamic>
  Map<String, dynamic> toJson() {
    return {
      'userId': userId, // Masukkan ID pengguna ke dalam map
      'id': id, // Masukkan ID task ke dalam map
      'title': title, // Masukkan judul task ke dalam map
      'completed': completed, // Masukkan status selesai ke dalam map
    };
  }
}

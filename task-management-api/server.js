const express = require('express');
const bodyParser = require('body-parser');
const cors = require('cors');
const tasksRoutes = require('./routes/tasks');  // Mengimpor rute yang telah didefinisikan

const app = express();                    // Membuat instance aplikasi Express
const PORT = process.env.PORT || 3000;    // Menentukan port server, menggunakan environment variable atau default ke 3000

// Middleware
app.use(cors());                          // Mengaktifkan CORS untuk semua rute
app.use(bodyParser.json());               // Menggunakan body-parser untuk parsing JSON di body request

// Rute
app.use('/todos', tasksRoutes);           // Menghubungkan rute /todos dengan tasksRoutes yang sudah dibuat

// Menjalankan server
app.listen(PORT, () => {
    console.log(`Server is running on port ${PORT}`); // Log saat server berhasil dijalankan
});

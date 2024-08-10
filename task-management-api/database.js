const { Sequelize } = require('sequelize'); 

// Membuat instance Sequelize baru dan mengkonfigurasi koneksi ke database SQLite
const sequelize = new Sequelize({
    dialect: 'sqlite', // Menentukan bahwa kita menggunakan SQLite sebagai database
    storage: './database.sqlite'  // Nama file database SQLite yang akan digunakan
});

// Mengekspor instance sequelize untuk digunakan di bagian lain dari aplikasi
module.exports = sequelize;

const { DataTypes } = require('sequelize');
const sequelize = require('./database');    // Mengimpor instance Sequelize yang telah dikonfigurasi

// Mendefinisikan model Task
const Task = sequelize.define('Task', {
    userId: {
        type: DataTypes.INTEGER,      // Tipe data INTEGER untuk menyimpan userId
        allowNull: false              // Tidak boleh kosong
    },
    title: {
        type: DataTypes.STRING,       // Tipe data STRING untuk menyimpan judul task
        allowNull: false              // Tidak boleh kosong
    },
    completed: {
        type: DataTypes.BOOLEAN,      // Tipe data BOOLEAN untuk status penyelesaian task
        defaultValue: false           // Nilai default adalah false (belum selesai)
    }
});

// Mengekspor model Task agar dapat digunakan di bagian lain aplikasi
module.exports = Task;

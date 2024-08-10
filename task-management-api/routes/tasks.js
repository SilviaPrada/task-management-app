const express = require('express');
const router = express.Router();
const Task = require('../taskModel');

// Sinkronisasi model dengan database
Task.sync();

// GET /todos - Mengambil semua task
router.get('/', async (req, res) => {
    try {
        const tasks = await Task.findAll();    // Mengambil semua data task dari database
        res.json(tasks);                       // Mengirimkan data task sebagai respons dalam format JSON
    } catch (err) {
        res.status(500).json({ error: err.message });  // Menangani error jika ada
    }
});

// POST /todos - Membuat task baru
router.post('/', async (req, res) => {
    try {
        const newTask = await Task.create({    // Membuat task baru dengan data dari body request
            userId: req.body.userId,
            title: req.body.title,
            completed: req.body.completed || false // Nilai default untuk completed adalah false
        });
        res.status(201).json(newTask);         // Mengirimkan task yang baru dibuat sebagai respons
    } catch (err) {
        res.status(500).json({ error: err.message });  // Menangani error jika ada
    }
});

// PUT /todos/{id} - Memperbarui task berdasarkan ID
router.put('/:id', async (req, res) => {
    try {
        const task = await Task.findByPk(req.params.id);  // Mencari task berdasarkan ID

        if (!task) {
            return res.status(404).json({ message: "Task not found" });  // Jika task tidak ditemukan
        }

        await task.update(req.body);   // Memperbarui task dengan data baru dari body request
        res.json(task);                // Mengirimkan task yang telah diperbarui sebagai respons
    } catch (err) {
        res.status(500).json({ error: err.message });  // Menangani error jika ada
    }
});

// DELETE /todos/{id} - Menghapus task berdasarkan ID
router.delete('/:id', async (req, res) => {
    try {
        const task = await Task.findByPk(req.params.id);  // Mencari task berdasarkan ID

        if (!task) {
            return res.status(404).json({ message: "Task not found" });  // Jika task tidak ditemukan
        }

        await task.destroy();    // Menghapus task dari database
        res.status(204).send();  // Mengirimkan respons tanpa konten (204 No Content)
    } catch (err) {
        res.status(500).json({ error: err.message });  // Menangani error jika ada
    }
});

module.exports = router;  // Mengekspor router agar dapat digunakan di aplikasi utama

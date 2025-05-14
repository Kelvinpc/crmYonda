// const express = require('express');
// const router = express.Router();
// const db = require('../config/database');

// // Ruta para obtener personas
// router.get('/personas', async (req, res) => {
//     try {
//         const query = `
//             SELECT * FROM usuarios
//         `;
//         const [usuarios] = await db.query(query);

//         // Renderiza la vista 'personas' pasando la variable 'usuarios'
//         res.render('personas', { usuarios: usuarios });
//     } catch (error) {
//         console.error(error);
//         res.status(500).send('Error al obtener los usuarios');
//     }
// });

// // Ruta para obtener clientes
// router.get('/clientes', async (req, res) => {
//     try {
//         const query = `
//             SELECT * FROM usuarios
//         `;
//         const [usuarios] = await db.query(query);

//         // Renderiza la vista 'clientes' pasando la variable 'usuarios'
//         res.render('clientes', { usuarios: usuarios });
//     } catch (error) {
//         console.error(error);
//         res.status(500).send('Error al obtener los usuarios');
//     }
// });

// module.exports = router;

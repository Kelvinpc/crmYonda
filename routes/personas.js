const express = require('express');
const router =express.Router()
const db = require('../config/database')

router.get('/', (req, res) =>{
    res.render('')

})


// router.get('/clientes', (req, res) =>{
//     res.render('')

// })

router.get('/clientes', async (req,res) =>{
    try{

        const query =`
        SELECT 
            P.apellidos,
            P.nombres,
            P.tipodoc,
            P.numdoc,
            P.fechanac,
            P.telefono,
            P.email,
            P.idorigen,
            P.fechacreacion,
            P.fechamodificado,
            O.origen
        FROM personas P 
        INNER JOIN origenes O ON O.idorigen = P.idorigen
        `;
        const [datosPersona] = await db.query(query)
        res.render('clientes', {datosPersona})
    }catch(error){
        console.error(error);
        
    }
})

module.exports = router;
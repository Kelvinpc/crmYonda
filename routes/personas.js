const express = require('express');
const router =express.Router()
const db = require('../config/database')

router.get('/', (req, res) =>{
    res.render('')

})

render.get('/', async (req,res) =>{
    try{

        const query =`SELECT 
        P.apellidos,
        P.nombres,
        P.tipodoc,
        P.numdoc,
        P.fechanac,
        P.telefono,
        P.email,
        P.idorigen,
        P.fechacreacion,
        P.fechamodificado
        FROM personas P 
        INNER JOIN 
        ;`
        const [datosPersona]
        
    }catch(error){
        console.error(error);
        
    }
})

module.exports = router;
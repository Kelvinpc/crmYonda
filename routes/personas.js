const express = require('express');
const router =express.Router()
const db = require('../config/database')

router.get('/', (req, res) =>{
    res.render('')

})

router.get('/clientes', async (req,res) =>{
    try{

        const query =`
        SELECT 
            p.nombres,
            p.apellidos,
            e.estado,o.origen,
            p.tipodoc,
            p.numdoc,
            p.fechanac,
            p.telefono,
            p.email
            FROM (
                SELECT s.*
                FROM seguimiento s
                INNER JOIN (
                    SELECT c.idpersona,max(s.fechainicio) AS fechamax
                    FROM seguimiento s
                    INNER JOIN carga c ON c.idcarga = s.idcarga
                    GROUP BY c.idpersona
                )ult ON ult.idpersona = (SELECT c2.idpersona FROM carga c2 WHERE c2.idcarga = s.idcarga)
                    AND fechamax = s.fechainicio
                    
            )s
            INNER JOIN carga c ON c.idcarga = s.idcarga 
            INNER JOIN estados e ON e.idestado = s.idestado 
            INNER JOIN personas p ON p.idpersona = c.idpersona 
            INNER JOIN origenes o ON o.idorigen = p.idorigen
        `;
        const [datosPersona] = await db.query(query)
        res.render('clientes', {datosPersona})
    }catch(error){
        console.error(error);
        
    }
})


// router.get('/clientes', async (req,res) =>{
//     try{

//         const query =`
//         SELECT 
//         O.idorigen,
//         O.origen
//         FROM origenes O
//         `;
//         const [datos] = await db.query(query)
//         res.render('clientes', {datos})
//     }catch(error){
//         console.error(error);
        
//     }
// })

router.get('/', async (req, res) => {
    try {
        const [origenes] = await db.query(`SELECT * FROM origenes`);
        res.render('clientes', { origenes: origenes }); // Cambiar 'datos' por 'origenes'
    } catch (error) {
        console.error(error);
    }
});


// router.get('/clientes', (req,res) =>{
//     try{
//         const []
//     }catch(error){
//         console.error(error);
        
//     }
// })


router.post('/clientes', async(req,res) => {
    try {

        const {apellidos, nombres, tipodoc, numdoc, fechanac, telefono, email, idorigen} = req.body

        await db.query(`INSERT INTO personas (apellidos, nombres, tipodoc, numdoc, fechanac, telefono, email, idorigen) VALUES (?,?,?,?,?,?,?,?)`,
            [apellidos, nombres, tipodoc, numdoc, fechanac, telefono, email, idorigen])
        
        res.redirect('/')
    } catch (error) {
        console.error(error);
        
    }
})




module.exports = router;
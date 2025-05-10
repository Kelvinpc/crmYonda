const express = require('express');
const router =express.Router()
const db = require('../config/database')

router.get('/', async (req, res) =>{
    try{
        
        const query =`
            SELECT  
                COUNT(p.idpersona) AS 'totalclientes',
                ROUND((COUNT(p.idpersona) * 100.0 / (SELECT COUNT(*) FROM personas WHERE idorigen IS NOT NULL)), 2) AS porcentaje,
                o.origen
            FROM personas p
            INNER JOIN origenes o ON o.idorigen = p.idorigen
            WHERE p.idorigen IS NOT NULL
            GROUP BY o.origen
        `;

        const [estadisticasOrigen] = await db.query(query)
        res.render('', {estadisticasOrigen: estadisticasOrigen})
    }catch(error){
        console.error(error);
    }
})



router.get('/clientes', async (req,res) =>{
    try{
        const [origenes] = await db.query(`SELECT * FROM origenes`)
        
        const query =`
        SELECT 
            p.nombres,
            p.apellidos,
            e.estado,
            o.origen,
            p.tipodoc,
            p.numdoc,
            p.fechanac,
            p.telefono,
            p.email,
            u.nomuser
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
            INNER JOIN asignaciones a ON a.idasignaciones =c.idasignaciones
            INNER JOIN usuarios u ON u.idusuario = a.idusuarioasesor

        `;  
        const [datosPersona] = await db.query(query)
        res.render('clientes', {datosPersona, origenes})
    }catch(error){
        console.error(error);
        
    }
})





router.get('/personas', async (req,res) =>{
    try{
        const [origenes] = await db.query(`SELECT * FROM origenes`)
        
            const query =`
                SELECT 
                    p.*,
                    o.origen,
                    s.*,
                    e.estado
                    
                FROM personas p

                LEFT JOIN origenes o ON o.idorigen = p.idorigen
                LEFT JOIN carga c ON c.idpersona = p.idpersona



                LEFT JOIN (
                    SELECT s.*
                    FROM seguimiento s
                    INNER JOIN (
                        SELECT c.idpersona, MAX(s.fechainicio) AS fechamax
                        FROM seguimiento s
                        INNER JOIN carga c ON c.idcarga = s.idcarga

                        GROUP BY c.idpersona
                    ) ult 
                    ON ult.idpersona = (SELECT c2.idpersona FROM carga c2 WHERE c2.idcarga = s.idcarga)
                    AND ult.fechamax = s.fechainicio
                ) s ON s.idcarga = c.idcarga
                LEFT JOIN estados e ON e.idestado = s.idestado


            `;
            
        const [datosPersona] = await db.query(query)
        res.render('personas', {datosPersona, origenes})
    }catch(error){
        console.error(error);
        
    }
})



router.get('/', async (req, res) => {
    try {
        const [origenes] = await db.query(`SELECT * FROM origenes`);
        res.render('clientes', { origenes: origenes }); // Cambiar 'datos' por 'origenes'
    } catch (error) {
        console.error(error);
    }
});





router.post('/create', async(req,res) => {
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
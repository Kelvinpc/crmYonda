const express = require('express');
const router =express.Router()
const db = require('../config/database')




router.get('/origenes', async (req, res) =>{
    try{
        const query =`
            SELECT * FROM origenes WHERE estado ='Activo'
        `;
        const [origenes] = await db.query(query)


        res.render('origenes', {origenes: origenes})
    }catch(error){
        console.error(error);
    }
})

router.get('/origeneseliminados', async (req, res) => {
  try {
    const [origenes] = await db.query("SELECT * FROM origenes WHERE estado = 'Desactivado'");

    res.render('origeneseliminados', {
      origenes
    });
  } catch (error) {
    console.error(error);
  }
});



router.post('/createOrigen', async(req,res) => {
    try {

        const {origen} = req.body

        await db.query(`INSERT INTO origenes (origen) VALUES (?)`,
            [origen])
        
        res.redirect('/')
    } catch (error) {
        console.error(error);
        
    }
})


// router.get('/editorigen/:id', async (req, res) =>{
//     try{
        
//         const query =`
//             SELECT * FROM origenes
//         `;

//         const [origenes] = await db.query(query)
//         res.render('editorigen', {origenes: origenes})
//     }catch(error){
//         console.error(error);
//     }
// })



// router.post('/editorigen/:id', async(req,res) =>{
//     try{
//         await db.query("UPDATE origenes SET origen= ? , fechamodificado = ?, WHERE idorigen=?",
//             [origen,fechamodificado, req.params.id])
//             res.redirect('/editorigen')

//     }catch(error){
//         console.error(error)
//     }
// })




router.get('/editorigen/:id', async(req,res)=>{
    try{


        const[origenes] = await db.query("SELECT * FROM origenes WHERE idorigen = ?",[req.params.id])




        if (origenes.length>0) {
            res.render('editorigen',{origenes:origenes[0]})

                    // Formato: YYYY-MM-DDTHH:MM
        origenes.fechacreacion = origenes.fechacreacion
            ? new Date(origenes.fechacreacion).toISOString().substring(0, 16)
            : '';

        origenes.fechamodificado = origenes.fechamodificado
            ? new Date(origenes.fechamodificado).toISOString().substring(0, 16)
            : '';
        }else{
            res.redirect('/origenes')
        }
    }catch(error){
        console.error(error);
        
    }
})

router.post('/editorigen/:id',async(req,res) =>{
    try{


        const[origenes] = await db.query("UPDATE origenes SET estado='Desactivado' WHERE idorigen = ?",[req.params.id])

        // const { origen, estado, fechacreacion, fechamodificado } = req.body;
        // await db.query(
        //     `UPDATE origenes SET origen=?, estado=?, fechacreacion=?, fechamodificado=? WHERE idorigen=?`,
        //     [origen, estado, fechacreacion, fechamodificado, req.params.id]
        // )

        res.redirect('/origenes',{origenes})
    }catch(error){
        console.error(error)
    }
})

router.get('/delete/:id', async(req,res) =>{
    try{

        const resultado = await db.query("UPDATE origenes SET estado='Desactivado' WHERE idorigen = ?", [req.params.id])




        res.redirect('/origenes')
    }catch(error){
        console.error(error)
    }
})


router.get('/recuperar/:id', async(req,res) =>{
    try{

        const resultado = await db.query("UPDATE origenes SET estado='Activo' WHERE idorigen = ?", [req.params.id])


        res.redirect('/origeneseliminados')
    }catch(error){
        console.error(error)
    }
})


module.exports = router;



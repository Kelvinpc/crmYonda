const express = require('express');
const router =express.Router()
const db = require('../config/database')




router.get('/origenes', async (req, res) =>{
    try{
        
        const query =`
            SELECT * FROM origenes
        `;

        const [origenes] = await db.query(query)
        res.render('origenes', {origenes: origenes})
    }catch(error){
        console.error(error);
    }
})


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

router.post('editorigen/:id', async(req,res) =>{
    try{
        await db.query("UPDATE origenes SET origen= ? , fechamodificado = ?, WHERE idorigen=?",
            [origen,fechamodificado, req.params.id])
            res.redirect('/')

    }catch(error){
        console.error(error)
    }
})


module.exports = router;
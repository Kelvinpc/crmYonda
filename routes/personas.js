const express = require('express');
const router =express.Router()
const db = require('../config/database')

router.get('/', (req, res) =>{
    res.send('Pagina dew personas')

})

module.exports = router;
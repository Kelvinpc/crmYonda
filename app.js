const express = require('express');
const bodyParser = require('body-parser');
const path = require('path');


const rutaCrm = require('./routes/personas');



const app = express();
const PORT = process.env.PORT || 3000


app.use(bodyParser.urlencoded({extended: true}))
app.use(bodyParser.json())
app.use(express.static(path.join(__dirname,'public')))


app.set('view engine', 'ejs')
app.set('views', path.join(__dirname, 'views'))


app.use('/',rutaCrm)



app.listen(PORT,'192.168.1.124',() =>{
    console.log(`Servidor iniciado en http://192.168.1.124:${PORT}`)
})
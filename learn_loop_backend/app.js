require('dotenv').config()
const express=require('express');
const cors=require('cors');
const db_connect=require('./congif/db');
const authroutes=require('./routes/authroutes');

const app=express();

app.use(cors({
    origin:"*",
    methods:"GET,POST,PUT,DELETE",
    Credential:true,
}))
app.use(express.json())



app.use('/uploads',express.static('uploads'))

db_connect();
const port=process.env.PORT || 3000;

app.use('/api/auth',authroutes);

app.listen(port,()=>{
    console.log(`Server stared at port :${port}`)
})

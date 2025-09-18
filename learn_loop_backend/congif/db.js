const mongoose=require('mongoose');

const db_connect= async ()=>{
    try{
    await mongoose.connect(process.env.MONGO_URI);
    console.log('Database connected successfully');
    }
    catch(err){
        console.log('Error in database connection',err);
        process.exit(1);
    }
};

module.exports=db_connect;
const jwt=require('jsonwebtoken');
const AppError=require('../utils/Errors');

const authenticate=(req,res,next)=>{
    const token=req.header('Authorization')?.replace('Bearer ','');
    if(!token){
        throw new AppError(201,'No tokens provided');
    }
    try{
        const decode=jwt.verify(token,process.env.JWT_Secret);
        req.user=decode;
        next();
    }
    catch(err){
        if(err instanceof AppError){
            return res.status(err.status).json({message:err.message});
        }
        return res.status(400).json({message:`Error ${err.message}`})

    }
}
module.exports=authenticate;
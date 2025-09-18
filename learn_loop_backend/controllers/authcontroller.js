const User=require('../models/usermodel');
const bcrypt=require('bcryptjs');
const jwt=require('jsonwebtoken');
const {sendEmail,otpSend}=require('../utils/mailer');
const AppError=require('../utils/Errors');
const authenticate=require('../middleware/auth');
const usermodel = require('../models/usermodel');

exports.signup=async(req,res)=>{
    const {first_name,last_name,email,password}=req.body;
    try{
    let user=await User.findOne({email});
    if(user && user.isVerified){
        throw new AppError(400,'User already exists and is verified');
    }
    const otp=Math.floor(100000+Math.random()*900000).toString();
    const otpExpiry=new Date(Date.now()+10*60000);
    const hashedPassword=await bcrypt.hash(password,10);
    if(user){
        user.first_name=first_name;
        user.last_name=last_name;
        user.password=hashedPassword;
        user.otp=otp;
        user.otpExpiry=otpExpiry;
        user.isVerified=false;
    }
    else{
        user=new User({first_name,last_name,email,password:hashedPassword,otp,otpExpiry});
    }
    await user.save();
    await sendEmail(email,otp);
    res.status(200).json({message:'OTP succesfully sent to the email'});
}
catch(err){
    if(err instanceof AppError){
        return res.status(err.status).json({message:err.message});
    }
    else{
        res.status(500).json({message:err.message});
    }

}
}
exports.verifyOTP=async(req,res)=>{
    const {email,otp}=req.body;
    try{
        const user= await User.findOne({email});
    if(!user || user.otp!=otp || user.otpExpiry<Date.now()){
        throw new AppError(400,'Invalid or expired otp')
    }
    user.isVerified=true,
    user.otp=null,
    user.otpExpiry=null,

    await user.save()
    return res.status(200).json({message:'User verified sucessfully'});

}
catch(err){
    if(err instanceof AppError){
        return res.status(err.status).json({message:err.message})
    }
    return res.status(500).json({message:err.message})
}
}

exports.login=async(req,res)=>{
    const {email,password}=req.body;
    try{
        const user=await User.findOne({email});
        if(!user || !user.isVerified){
            throw new AppError(400,'User not found or is not verified')
        }

        const match=await bcrypt.compare(password,user.password);
        if(!match){
            throw new AppError(400,'Invalid credidentals')
        }
        const token=jwt.sign({'id':user._id,'email':user.email,'name':user.first_name},process.env.JWT_Secret,{expiresIn:'7d'});
        const id=user._id;
        console.log(id);
        return res.status(200).json({message:'Login successful',token,id});

    }
    catch(err){
        if(err instanceof AppError){
            return res.status(err.status).json({message:err.message});
        }
        return res.status(500).json({message:err.message});

    }
}

exports.getInitial=async(req,res)=>{
    const userID=req.user.id;
    try{
       const user=await User.findById(userID).select('first_name');
       const initial=user.first_name.charAt(0).toUpperCase();
       return res.status(200).json({initial});
    }
    catch(e){
        return res.status(500).json({message:"Error found"})
    }

}

exports.getFullName=async(req,res)=>{
    const userID=req.user.id;
    try{
        const user= await User.findById(userID).select('first_name last_name');
        const fullname=`${user.first_name} ${user.last_name}`
    
        return res.status(200).json({fullname}); 
    }
    catch(e){
        return res.status(500).json({message:'Error while passing the fullname'})
    }
}

exports.getEmail=async(req,res)=>{
    const userid=req.user.id;
    try{
        const email=await User.findById(userid).select('email');

        return res.status(200).json({email});
    }
    catch(e){
        return res.status(500).json({message:'Error while passing the email'})

    }
}

exports.updateinfo=async(req,res)=>{
    const{first_name,last_name,bio}=req.body;
    try{
        const updateduserdetails=await User.findByIdAndUpdate(
            req.user.id,
            {first_name,last_name,bio},
            {new:true}
        );
        return res.status(200).json({message:'User data updated sucessfully',user:updateduserdetails})
    }
    catch(e){
        return res.status(500).json({message:'Internal error occurred'});

    }
}

exports.getBio=async(req,res)=>{
    const userID=req.user.id;
    try{
        const bio=await User.findById(userID).select('bio');
        return res.status(200).json({bio});
    
    }
    catch(e){
        return res.status(500).json({message:'Internal error occurred'});

    }
}

exports.getfirstname=async(req,res)=>{
    const userID=req.user.id;
    try{
        const firstname=await User.findById(userID).select('first_name');
        return res.status(200).json({firstname});

    }
    catch(e){
        return res.status(500).json({message:'Internal error occurred'});

    }
}

exports.getlastname=async(req,res)=>{
    const userID=req.user.id;
    try{
        const lastname=await User.findById(userID).select('last_name');
        return res.status(200).json({lastname});

    }
    catch(e){
        return res.status(500).json({message:'Internal error occurred'});

    }
}

exports.changepicture=async(req,res)=>{
    const userID=req.user.id;
     if (!req.file) {
      return res.status(400).json({ message: 'No file uploaded' });
    }
    try{
        const newpicture=await User.findByIdAndUpdate(
            userID,
            {photo:`http://10.0.2.2:3000/uploads/${req.file.filename}`},
            {new:true}
        );
        return res.status(200).json({message:'Profile picture updated sucessfully',photo:newpicture.photo});
    }
    catch(e){
        return res.status(500).json({message:'Internal error occurred'})

    }
}

exports.verifyEmail=async(req,res)=>{
    const {email}=req.body;
    try{
        let user=await User.findOne({email});
    if(!user){
        throw new AppError(400,'No user with such email found, please create a new account')
        
    }
    else{
        const otp=Math.floor(100000+Math.random()*900000).toString();
        const otpExpiry=new Date(Date.now()+10*60000);
        user.passwordChangeOtp=otp,
        user.passwordOtpExpiry=otpExpiry,
        await otpSend(email,otp);
        await user.save();
        return res.status(200).json({message:'An email with 6 digit verification code has been sent to your account'});
    }
}
catch (err){
    if(err instanceof AppError){
        return res.status(err.status).json({message:err.message});
    }
    return res.status(500).json({message:'Internal error occurred',err})
}
}

exports.verificationOTP=async(req,res)=>{
const{email,otp}=req.body;
try{
const user=await User.findOne({email});
if(!user || user.passwordChangeOtp!=otp || user.passwordOtpExpiry.getTime()<Date.now()){
    throw new AppError(400,'Invalid OTP')
}
else{
    user.passwordChangeOtp=null;
    user.passwordOtpExpiry=null;
    await user.save();
    return res.status(200).json({message:'Otp verified ✅'})
}

}

catch(err){
    if(err instanceof AppError){
        return res.status(err.status).json({message:err.message});
    }
    else{
        return res.status(500).json({message:'Backend error'})
    }

}
}

exports.changepassword=async(req,res)=>{
    const{email,password}=req.body;
    try{
        const user=await User.findOne({email});

        const isSame=await bcrypt.compare(password,user.password);
        if(isSame){
            throw new AppError(400,'Please choose a different password from your current one');
        }
        else{
            user.password= await bcrypt.hash(password,10);
        await user.save();
        return res.status(200).json({message:'Password changed sucessfully now you can login back'});
        }
    }
    catch(err){
        if(err instanceof AppError){
            return res.status(err.status).json({message:err.message});
        }
        return res.status(500).json({message:'Backend error occurred'});
    }
}
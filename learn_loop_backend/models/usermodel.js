const mongoose=require('mongoose');

const User_schema=new mongoose.Schema({
  'email':{
    type:String,unique:true,required:true
  }
, 
 'password':{
    type:String,required:true
 },
 'isVerified':{
  type:Boolean,default:false
 },
 'first_name':{
    type:String,required:true
 },
 'last_name':{
  type:String,required:true
 },
 'otp':String,
 'otpExpiry':Date,
 'bio':{
  type:String,default:''
 },
 'photo':{
  type:String
 },
 'passwordChangeOtp':String,
 'passwordOtpExpiry':Date,
});

module.exports=mongoose.model('User',User_schema);
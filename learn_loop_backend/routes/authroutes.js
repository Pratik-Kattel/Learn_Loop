const express=require('express');
const router=express.Router();
const{signup,verifyOTP,login,getInitial,getFullName,getEmail,updateinfo,getBio,getfirstname,getlastname,changepicture,verifyEmail,verificationOTP,changepassword}=require('../controllers/authcontroller');
const authenticate=require('../middleware/auth');
const User=require('../models/usermodel');
const upload=require('../utils/multer');

router.post('/signup',signup);
router.post('/verifyOTP',verifyOTP);
router.post('/login',login);
router.put('/update-info',authenticate,updateinfo);
router.get('/get-initial',authenticate,getInitial);
router.get('/get-fullname',authenticate,getFullName);
router.get('/get-firstname',authenticate,getfirstname);
router.get('/get-lastname',authenticate,getlastname);
router.get('/get-email',authenticate,getEmail);
router.get('/get-bio',authenticate,getBio);
router.post('/verify-email',authenticate,verifyEmail);
router.post('/change-profile-picture',authenticate,upload.single('photo'),changepicture);
router.post('/verification-otp',verificationOTP);
router.post('/change-password',changepassword);

module.exports=router;
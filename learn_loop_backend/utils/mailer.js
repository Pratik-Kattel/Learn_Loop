const nodemailer = require('nodemailer');

const sendEmail = async (to, otp) => {
  const transporter = nodemailer.createTransport({
    service: 'gmail',
    auth: {
      user: process.env.EMAIL_USER,
      pass: process.env.EMAIL_PASS,
    },
  });

  const mailoption = {
    from: `Learn Loop <${process.env.EMAIL_USER}>`,
    to,
    subject: 'Email Verification OTP',
    html: `
      <div style="font-family: Arial, sans-serif; padding: 20px; background-color: #f9f9f9;">
        <div style="max-width: 500px; margin: auto; background: #ffffff; padding: 30px; border-radius: 10px; box-shadow: 0 0 10px rgba(0,0,0,0.05);">
          <h2 style="color: #333;">Email Verification</h2>
          <p style="font-size: 16px;">Hello,</p>
          <p style="font-size: 16px;">To verify your email address, please use the OTP below:</p>
          <div style="margin: 20px 0; padding: 15px; background: #fff5f5; color: #e74c3c; font-size: 24px; font-weight: bold; text-align: center; border: 1px dashed #e74c3c; border-radius: 8px;">
            ${otp}
          </div>
          <p style="font-size: 14px; color: #777;">This OTP is valid for 10 minutes. Do not share it with anyone.</p>
          <p style="font-size: 16px;">Thank you,<br><strong>Learn Loop Team</strong></p>
        </div>
      </div>
    `,
  };

  await transporter.sendMail(mailoption);
};

const otpSend=async(to,otp)=>{
const transporter=nodemailer.createTransport({
  service:'gmail',
  auth:{
    user:process.env.EMAIL_USER,
    pass:process.env.EMAIL_PASS
  }
});
 const mailoption={
  from:`Learn loop ${process.env.EMAIL_USER}`,
  to,
  subject:'Password change request',
  html:`This is your otp ${otp}`
 };

 await transporter.sendMail(mailoption);

}

module.exports = {sendEmail,otpSend};

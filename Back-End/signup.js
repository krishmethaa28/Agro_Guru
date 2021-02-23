exports.signup = function(req, res, next) {
    User.findOne({ email: req.body.email }, function (err, user) {
      // error occur
      if(err){
          return res.status(500).send({msg: err.message});
      }
      // if email is exist into database i.e. email is associated with another user.
      else if (user) {
          return res.status(400).send({msg:'This email address is already associated with another account.'});
      }
      // if user is not exist into database then save the user into database for register account
      else{
          // password hashing for save into databse
          req.body.password = Bcrypt.hashSync(req.body.password, 10);
          // create and save user
          user = new User({ name: req.body.name, email: req.body.email, password: req.body.password });
          user.save(function (err) {
              if (err) { 
                return res.status(500).send({msg:err.message});
              }
              
              // generate token and save
              var token = new Token({ _userId: user._id, token: crypto.randomBytes(16).toString('hex') });
              token.save(function (err) {
                if(err){
                  return res.status(500).send({msg:err.message});
                }
  
                  // Send email (use credintials of SendGrid)
                  var transporter = nodemailer.createTransport({ service: 'Sendgrid', auth: { user: process.env.SENDGRID_USERNAME, pass: process.env.SENDGRID_PASSWORD } });
                  var mailOptions = { from: 'no-reply@example.com', to: user.email, subject: 'Account Verification Link', text: 'Hello '+ req.body.name +',\n\n' + 'Please verify your account by clicking the link: \nhttp:\/\/' + req.headers.host + '\/confirmation\/' + user.email + '\/' + token.token + '\n\nThank You!\n' };
                  transporter.sendMail(mailOptions, function (err) {
                      if (err) { 
                          return res.status(500).send({msg:'Technical Issue!, Please click on resend for verify your Email.'});
                       }
                      return res.status(200).send('A verification email has been sent to ' + user.email + '. It will be expire after one day. If you not get verification Email click on resend token.');
                  });
              });
          });
      }
      
    });
  
  };
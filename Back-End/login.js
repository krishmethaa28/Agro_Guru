exports.login = function(req, res, next) {
    User.findOne({ email: req.body.email }, function(err, user) {
        // error occur
        if(err){
            return res.status(500).send({msg: err.message});
        }
        // user is not found in database i.e. user is not registered yet.
        else if (!user){
            return res.status(401).send({ msg:'The email address ' + req.body.email + ' is not associated with any account. please check and try again!'});
        }
        // comapre user's password if user is find in above step
        else if(!Bcrypt.compareSync(req.body.password, user.password)){
            return res.status(401).send({msg:'Wrong Password!'});
        }
        // check user is verified or not
        else if (!user.isVerified){
            return res.status(401).send({msg:'Your Email has not been verified. Please click on resend'});
        } 
        // user successfully logged in
        else{
            return res.status(200).send('User successfully logged in.');
        }
    });

};
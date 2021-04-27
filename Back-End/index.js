import express from 'express';
import routes from './src/routes/routes';
import mongoose from 'mongoose';
import bodyParser from 'body-parser';

const app = express ();
const PORT = 4000;

//mongoose connection
mongoose.Promise = global.Promise;
mongoose.connect('mongodb://localhost/BACK_ENDdb',{
    useNewUrlParser: true,
    useUnifiedTopology: true

});

//bodyparser setup

app.use(bodyParser.urlencoded({ extended: true}));
app.use(bodyParser.json());
routes(app);

//save static files
app.use(express.static('images'));

app.get('/',(req, res)=>
res.send(`NODE and EXPRESS server running on port ${PORT}`)
);

app.listen(PORT, ()=>
console.log(`Your sever is running on port : ${PORT}`)
);
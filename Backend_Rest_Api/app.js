const express = require('express');
const app = express();
const morgan = require('morgan');
const bodyParser = require('body-parser');
const mongoose = require('mongoose');

const productRoutes = require('./api/routes/products');
const orderRoutes = require('./api/routes/orders');

mongoose.connect('mongodb+srv://baveega:'+process.env.MONGO_ATLAS_PW +'@node-rest.9jtdt.mongodb.net/myFirstDatabase?retryWrites=true&w=majority')

app.use(morgan('dev'));
app.use(bodyParser.urlencoded ({ extended: false}));
app.use(bodyParser.json());

app.use((req, res, next) => {
    res.header('Access-Control-Allow-Origin', '*');
    res.header('Access-Control-Allow-Oridin', 'Origin, X-Requested-With, Content-Type,Accept,Authorization',{
        useMongoClient: true
    } );
    if(req.method === 'OPTIONS') {
        res.header('Access-Controal-Allow-Methods, PUT, POST, PATCG, DELETE,GET');
        return res.status(200).json({});
    }
    next();

});

app.use('/products', productRoutes);
app.use('/orders', orderRoutes);

app.use((req, res, next) => {
    const error = new Error('Not found');
    error.status = 404;
    next(error);

})

app.use((error, req, res, next) =>{
    res.status(error.status || 500);
    res.json({
        error: {
            message: error.message
        }
    });
});

module.exports = app;
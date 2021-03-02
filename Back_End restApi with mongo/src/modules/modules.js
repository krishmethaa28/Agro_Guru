
import mongoose from 'mongoose';

const Schema = mongoose.Schema;

export const ContactSchema = new Schema({
    firstName: {
        type : String,
        required: 'Enter a first name: '

    },
   
    lastName: {
        type : String,
        required: 'Enter a last name: '
    },

    email:{
        type : String,
        required: 'Enter the email address : '
    },

    password:{
        type : String,
        required: 'Confirm password : '
    },

    created_date:{
        type : Date,
        default: Date.now 
    }

});
import mongoose from 'mongoose';
import { ContactSchema } from '../modules/modules';

const Contact = mongoose.model('Contact', ContactSchema);

export const addNewContact = (req, res)=>{
    let newContact = new Contact(req.body);

    newContact.save((err, contact)=>{
        if(err){
            res.send(err);
        }
        res.json(contact);
    });
}

export const getContacts = (req, res)=>{
    Contact.find({},(err, contact)=>{
        if(err){
            res.send(err);
        }
        res.json(contact);
    });
}

export const getContactWithID = (req, res)=>{
    Contact.findById(req.params.contactID,(err, contact)=>{
        if(err){
            res.send(err);
        }
        res.json(contact);
    });
}

export const updateContact = (req, res)=>{
    Contact.findOneAndUpdate({ _id: req.params.contactID}, req.body,{ new: true, useFindAndModify: false}, (err, contact)=>{
        if(err){
            res.send(err);
        }
        res.json(contact);
    });
}

export const deleteContact = (req, res)=>{
    Contact.remove({ _id: req.params.contactID}, (err, contact)=>{
        if(err){
            res.send(err);
        }
        res.json({message : `successfully deleted user`});
    });
}
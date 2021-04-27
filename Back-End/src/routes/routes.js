import {addNewContact,
       getContacts,
       getContactWithID,
       updateContact,
       deleteContact
} from '../controllers/controllers';


const routes = (app) =>{
    app.route('/contact')

    //get all contacts 
    .get((req, res, next)=>{
        //middleware
        console.log(`Request from: ${req.originalUrl}`)
        console.log(`Request type: ${req.method}`)
        next();
    }, getContacts)
    

    //add a contact
    .post(addNewContact);

    //get a specific contact
    app.route('/contact/:contactID')
    .get(getContactWithID)

    //update a specific information
    .put(updateContact)

    //delete a specific user
    .delete(deleteContact)
}

export default routes;
const admin = require('firebase-admin')
const functions = require('firebase-functions')
const serviceAccount = require('./clouddice-995ef-firebase-adminsdk-nv9hy-5d9af09d1e.json')
const dotenv = require('dotenv')
const fetch = require('isomorphic-fetch')
const fs = require('fs')

// Get the FieldValue object
let FieldValue = admin.firestore.FieldValue

// Environment variables
dotenv.config({
    path: './.env'
})

// Dropbox config
const dropboxv2api = require('dropbox-v2-api')
const drop = require('dropbox').Dropbox
let dbx = new drop({
    fetch: fetch,
    accessToken: 'A_j8bd3Z36AAAAAAAAAAcl7S3Ql3tdcSb3FEHKaz5tAmLrg2anj5-2H9zY7qn_y-'
})

const dropbox = dropboxv2api.authenticate({
    token: 'A_j8bd3Z36AAAAAAAAAAcl7S3Ql3tdcSb3FEHKaz5tAmLrg2anj5-2H9zY7qn_y-'
})

// App initialization
admin.initializeApp({
    credential: admin.credential.cert(serviceAccount),
})

// Instance of firestore
let db = admin.firestore()

// Upload using stream
const dropboxUploadStream = dropbox({
    // Method for upload
    resource: 'files/upload',
    parameters: {
        // Required filename
        path: '/package-lock.json'
    },
    readStream: fs.createReadStream('./package-lock.json')
}, (err, result, response) => {
    console.log(result)
    dbx.sharingCreateSharedLink({
        path: result.path_lower
    }).then((result) => {
        console.log(result);
        let docRef = db.collection('files').doc('subject_1')

        let addDoc = db.collection('files').doc('Soft Computing').collection('module-2').add({
            url: result.url.split('?')[0],
            data: {
                title: 'LAN/WAN/MAN',
                module: 2
            },
            date_uploaded: FieldValue.serverTimestamp(),
        }).then((val) => console.log('Complete')).catch((err) => console.log(err));

    }).catch((err) => {
        console.log(err);
    })
})





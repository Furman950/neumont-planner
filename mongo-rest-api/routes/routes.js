const express = require('express')
const https = require('https')

const CustomEvent = require('../models/CustomEvent')
const router = express.Router()
const collectionName = 'events'

var options = {
    host: 'lms.neumont.edu',
    port: 443,
    path: '/api/v1/users/self',
    method: "GET",
    headers: {
        "Authorization": ""
    }
}

function authenticateWithLMS(auth, callback) {
    options.headers.Authorization = auth
    https.get(options, (res) => {
        res.on('data', (chunk) => {
            if (res.statusCode == 401) {
                callback(401, "")
                return
            }

            var body = JSON.parse(chunk);
            if (body.hasOwnProperty('id')) {
                callback(200, body['id'])
            }
        })
    })
}

router.get('/events/all', (req, res, next) => {
    console.log("------ in /events/all -------")
    var callback = (statusCode, id) => {
        if (statusCode == 401) {
            res.status(401).send({ 'error': 'Not Authorized' })
            return;
        }

        if (statusCode != 200) {
            res.status(statusCode).send({ 'error': `Status code ${statusCode}` })
            return;
        }

        req.app.locals.db.collection(collectionName).find({ userId: id }).toArray((err, result) => {
            if (err) {
                res.status(400).send({ 'error': err })
                return;
            }

            if (result === undefined || result.length === 0) {
                res.status(400).send({ 'error': 'No events found' })
            }
            else {
                res.status(200).send(result)
            }
        })
    }

    if (req.headers.authorization == undefined) {
        res.status(400).send({ 'error': "Undefined Authorization header" })
    }
    else {
        authenticateWithLMS(req.headers.authorization, callback)
    }
    console.log("----- END -----")
});

router.delete('/events/delete/:mongoId', (req, res, next) => {
    console.log("----- in /events/delete -------")
    var callback = (statusCode, id) => {
        if (statusCode == 401) {
            res.status(401).send({ 'error': 'Not Authorized' })
            return;
        }

        if (statusCode != 200) {
            res.status(statusCode).send({ 'error': `Status code ${statusCode}` })
            return;
        }

        req.app.locals.db.collection(collectionName)
            .deleteOne({ "mongoId": req.params.mongoId },
                (err, result) => {
                    if (err) {
                        res.status(400).send({ 'error': err })
                        return;
                    }
                    res.status(200).send(result)
                    console.log("deleted doc")
                }
            )
    }

    if (req.headers.authorization == undefined) {
        res.status(400).send({ 'error': "Undefined Authorization header" })
    }
    else {
        authenticateWithLMS(req.headers.authorization, callback)
    }

    console.log("------ END ------")
})

router.patch('/events/edit/:mongoId', (req, res, next) => {
    console.log("------- in /events/edit -----")
    var callback = (statusCode, id) => {
        if (statusCode == 401) {
            res.status(401).send({ 'error': 'Not Authorized' })
            return;
        }

        if (statusCode != 200) {
            res.status(statusCode).send({ 'error': `Status code ${statusCode}` })
            return;
        }


        req.app.locals.db.collection(collectionName).updateOne({
            "mongoId": req.params.mongoId
        },
            {
                $set:
                {
                    mongoId: req.body.mongoId,
                    userId: req.body.userId,
                    title: req.body.title,
                    description: req.body.description,
                    startTime: req.body.startTime,
                    endTime: req.body.endTime
                }
            }, (err, result) => {
                if (err) {
                    res.status(400).send({ 'error': err })
                    return;
                }
                res.status(200).send(result)
            })
    }

    if (req.headers.authorization == undefined) {
        res.status(400).send({ 'error': "Undefined Authorization header" })
    }
    else {
        authenticateWithLMS(req.headers.authorization, callback)
    }
    console.log("-------- END --------");
})

router.post('/events/new', (req, res, next) => {
    console.log("---------- /events/new -------------")
    var callback = (statusCode, id) => {
        if (statusCode == 401) {
            res.status(401).send({ 'error': 'Not Authorized' })
            return;
        }

        if (statusCode != 200) {
            res.status(statusCode).send({ 'error': `Status code ${statusCode}` })
            return;
        }

        const customEvent = new CustomEvent(
            req.body.mongoId,
            id,
            req.body.title,
            req.body.description,
            req.body.startTime,
            req.body.endTime
        )

        req.app.locals.db.collection(collectionName).insertOne(customEvent, (err, result) => {
            if (err) {
                res.status(400).send(result)
                return
            }

            res.status(200).send(result)
        })
    }

    if (req.headers.authorization == undefined) {
        res.status(400).send({ 'error': "Undefined Authorization header" })
    }
    else {
        authenticateWithLMS(req.headers.authorization, callback)
    }

    console.log("------ END ----------")
})

router.get('/events/:mongoId', (req, res, next) => {
    console.log("--------in /event/:mongoId ----------")
    var callback = (statusCode, id) => {
        if (statusCode == 401) {
            res.status(401).send({ 'error': 'Not Authorized' })
            return;
        }

        if (statusCode != 200) {
            res.status(statusCode).send({ 'error': `Status code ${statusCode}` })
            return;
        }

        req.app.locals.db.collection(collectionName).findOne({
            "mongoId": req.params.mongoId
        }, (err, result) => {
            if (err) {
                res.status(400).send({ 'error': err })
            }
            if (result === undefined) {
                res.status(400).send({ 'error': 'No document matching that mongoId was found' })
            } else {
                console.log("sent status 200")
                res.status(200).send(result)
            }
        })
    }

    if (req.headers.authorization == undefined) {
        res.status(400).send({ 'error': "Undefined Authorization header" })
    }

    else {
        authenticateWithLMS(req.headers.authorization, callback)
    }
    
    console.log("------ END ----------")
})

module.exports = router

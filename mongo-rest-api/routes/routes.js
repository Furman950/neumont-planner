const express = require('express')
const ObjectId = require('mongodb').ObjectID

const Document = require('../models/Event')
const router = express.Router()
const collection = 'events'

router.get('/events/all', (req, res, next) => {
  console.log("------ in /events/all -------")
  req.app.locals.db.collection(collection).find({}).toArray((err, result) => {
    if (err) {
      res.status(400).send({ 'error': err })
    }
    if (result === undefined || result.length === 0) {
      res.status(400).send({ 'error': 'No events in database' })
    } else {
      res.status(200).send(result)
    }
  })
  console.log("----- END -----")
})

router.get('/events/:id', (req, res, next) => {
  console.log("-----in /events/:id ----")
  req.app.locals.db.collection(collection).findOne({
    "_id": new ObjectId(req.params.id)
  }, (err, result) => {
    if (err) {
      res.status(400).send({ 'error': err })
    }
    if (result === undefined) {
      res.status(400).send({ 'error': 'No document matching that id was found' })
    } else {
      console.log("sent status 200")
      res.status(200).send(result)
    }

    console.log(result)
  })
  console.log("-----END----")
})

router.post('/events/new', (req, res, next) => {
  console.log("-------in /events/new --------")
  const event = new Event(
    req.body.id,
    req.body.userId,
    req.body.title,
    req.body.description,
    req.body.startTime,
    req.body.endTime)
  req.app.locals.db.collection(collection).insertOne({
    event
  }, (err, result) => {
    if (err) {
      res.status(400).send({ 'error': err })
    }
    res.status(200).send(result)
  })
  console.log("--------END---------")
})

router.get("/getNewObjectId", (req, res, next) => {
  console.log("----- in getNewObjectId ------")
  
  req.app.locals.db.ObjectID
  console.log("--------- END --------")
});

router.delete('/events/delete/:id', (req, res, next) => {
  console.log("--- in /events/delete/:id------")
  req.app.locals.db.collection(collection).deleteOne({
    "_id": new ObjectId(req.params.id)
  }, (err, result) => {
    if (err) {
      res.status(400).send({ 'error': err })
    }
    res.status(200).send(result)
  })
  console.log("-------- END --------");
})

router.patch('/events/edit/:id', (req, res, next) => {
  console.log("------- in /events/edit -----")
  req.app.locals.db.collection(collection).updateOne({
    "_id": new ObjectId(req.params.id)
  },
    {
      $set:
      {
        id: req.body.id,
        userId: req.body.userId,
        title: req.body.title,
        description: req.body.description,
        startTime: req.body.startTime,
        endtiem: req.body.endTime
      }
    }, (err, result) => {
      if (err) {
        res.status(400).send({ 'error': err })
      }
      res.status(200).send(result)
    })
  console.log("-------- END --------");
})
router.get('/test', (req, res, next) => {
  console.log("-------in /test ------")
  req.app.locals.db.collection(collection).insertOne();
  res.status(200).send({ ok: "ok" })
  console.log("-------- END ----------")
})

module.exports = router

const express = require('express')
const bodyParser = require('body-parser')
const MongoClient = require('mongodb').MongoClient

const dbName = 'mongo'
const url = `mongodb://${dbName}:27017`
const options = {
    useNewUrlParser: true, 
    reconnectTries: 60, 
    reconnectInterval: 1000
}

const routes = require('./routes/routes.js')
const port = 5585
const app = express()
const http = require('http').Server(app)

app.use(bodyParser.json())
app.use(bodyParser.urlencoded({ extended: true }))
app.use('/api', routes)
app.use((req, res) =>{
    res.status(404)
})

MongoClient.connect(url, options, (err, database) =>{
    if (err){
        console.log(`FATAL MONGODB CONNECTION ERROR: ${err}:${err.stack}`)
        process.exit(1)
    }

    app.locals.db = database.db('api')
    http.listen(port, () =>{
        console.log(`Listening on port ${port}`)
    })
})

module.exports = app
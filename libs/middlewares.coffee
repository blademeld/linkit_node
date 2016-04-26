bodyParser  = require 'body-parser'
express     = require 'express'
cors        = require 'cors'

###
morgan      = require 'morgan'              //logger
compression = require 'compression'         //compresses http for performance
helmet      = require 'helmet'              //HTTP protection
logger      = require './logger.js'         //logger
###

module.exports = (app)->
    ###set port###
    app.set 'port', 3000

    ###JSON Formatting###
    app.set 'json spaces', 4

    ###CORS Support###
    app.use cors 
        origin          : ["http://localhost:8080"]
        methods         : ["GET", "POST", "PUT", "DELETE"]
        allowedHeaders  : ["Content-Type", "Authorization"]
        
    ###allows request body to be read###
    app.use bodyParser.urlencoded extended: true
        
    ###parses JSON data from body###
    app.use do bodyParser.json
    
    ###app.use do app.auth.initialize       //for passport middleware###
    app.use (req, res, next) ->
        delete req.body.id;
        do next
        return
    
    ###app.use express.static "public"      //allows access to static resources###
    
    return
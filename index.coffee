"use strict"

_           = require "lodash"
express     = require "express"
mysql       = require "mysql"
consign     = require "consign"
bodyParser  = require "body-parser"
methodOverride  = require "method-override"

`const PORT = 3000`
`const app = express()`

connection = mysql.createConnection 
    host: 'localhost'
    port: '3306'
    user: 'linkitAdmin'
    password: 'linkitAdmin'
    database: 'linkit'
    
connection.connect (err)->
    if err then return console.error 'error connecting: ' + err.stack
    console.log 'connected as id '+ connection.threadId
    
app.set 'json spaces', 4
    
###this is middleware and should me moved afterwards###
app .use bodyParser.urlencoded extended: true
    .use bodyParser.json()
    .use methodOverride 'X-HTTP-Method-Override'
    .use (req, res, next)->
        res.header 'Access-Control-Allow-Origin', '*'
        res.header 'Access-Control-Allow-Methods', 'GET,PUT,POST,DELETE'
        res.header 'Access-Control-Allow-Headers', 'Content-Type'
        do next
        return
    .use '/products', (req, res, next)->
        connection.query 'SELECT * FROM products', [], (err, results, fields)->
            if err then return console.error err.stack
            res.send results
            return
#        do next
        return
    .use '/product/:id', (req, res, next)->
        connection.query 'SELECT * FROM products WHERE id = ?', [req.params.id], (err, results, fields)->
            if err then return console.error err.stack
            res.send results
            return
        return
    .use '/product-create', (req, res, next)->
        connection.query 'INSERT INTO products (name,spec,stat,cost,sell,amnt) VALUES (?,?,?,?,?,?)', [req.body.name, req.body.spec, req.body.stat, req.body.cost, req.body.sell, req.body.amnt], (err, results, fields)->
            if err then return console.error err.stack
            res.send results
            return
        return
    .use '/product-update', (req, res, next)->
        connection.query 'UPDATE products SET name = ?, spec = ?, stat = ?, cost = ?, sell = ?, amnt = ? WHERE id = ?', [req.body.name, req.body.spec, req.body.stat, req.body.cost, req.body.sell, req.body.amnt, req.body.id], (err, results, fields)->
            if err then return console.error err.stack
            res.send results
            return
        return
    .use '/product-delete', (req, res, next)->
        connection.query 'DELETE FROM products WHERE id = ?', [req.body.id], (err, results, fields)->
            if err then return console.error err.stack
            res.send results
            return
        return

app.listen 3000
    
#consign verbose: false
#    .include "libs/config.js"
#    .include "db.js"
#    .include "auth.js"
#    .include "libs/middlewares.js"
#    .include "routes"
#    .include "libs/boot.js"
#    .into app
    
module.exports = app
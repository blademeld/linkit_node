// Generated by CoffeeScript 1.9.3
(function() {
  "use strict";
  var _, bodyParser, connection, consign, express, methodOverride, mysql;

  _ = require("lodash");

  express = require("express");

  mysql = require("mysql");

  consign = require("consign");

  bodyParser = require("body-parser");

  methodOverride = require("method-override");

  const PORT = 3000;

  const app = express();

  connection = mysql.createConnection({
    host: 'localhost',
    port: '3306',
    user: 'linkitAdmin',
    password: 'linkitAdmin',
    database: 'linkit'
  });

  connection.connect(function(err) {
    if (err) {
      return console.error('error connecting: ' + err.stack);
    }
    return console.log('connected as id ' + connection.threadId);
  });

  app.set('json spaces', 4);


  /*this is middleware and should me moved afterwards */

  app.use(bodyParser.urlencoded({
    extended: true
  })).use(bodyParser.json()).use(methodOverride('X-HTTP-Method-Override')).use(function(req, res, next) {
    res.header('Access-Control-Allow-Origin', '*');
    res.header('Access-Control-Allow-Methods', 'GET,PUT,POST,DELETE');
    res.header('Access-Control-Allow-Headers', 'Content-Type');
    next();
  }).use('/products', function(req, res, next) {
    connection.query('SELECT * FROM products', [], function(err, results, fields) {
      if (err) {
        return console.error(err.stack);
      }
      res.send(results);
    });
  }).use('/product/:id', function(req, res, next) {
    connection.query('SELECT * FROM products WHERE id = ?', [req.params.id], function(err, results, fields) {
      if (err) {
        return console.error(err.stack);
      }
      res.send(results);
    });
  }).use('/product-create', function(req, res, next) {
    connection.query('INSERT INTO products (name,spec,stat,cost,sell,amnt) VALUES (?,?,?,?,?,?)', [req.body.name, req.body.spec, req.body.stat, req.body.cost, req.body.sell, req.body.amnt], function(err, results, fields) {
      if (err) {
        return console.error(err.stack);
      }
      res.send(results);
    });
  }).use('/product-update', function(req, res, next) {
    connection.query('UPDATE products SET name = ?, spec = ?, stat = ?, cost = ?, sell = ?, amnt = ? WHERE id = ?', [req.body.name, req.body.spec, req.body.stat, req.body.cost, req.body.sell, req.body.amnt, req.body.id], function(err, results, fields) {
      if (err) {
        return console.error(err.stack);
      }
      res.send(results);
    });
  }).use('/product-delete', function(req, res, next) {
    connection.query('DELETE FROM products WHERE id = ?', [req.body.id], function(err, results, fields) {
      if (err) {
        return console.error(err.stack);
      }
      res.send(results);
    });
  });

  app.listen(3000);

  module.exports = app;

}).call(this);

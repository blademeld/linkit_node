mysql = require 'mysql'

module.exports = (app)->
    connection = mysql.createConnection 
        host: 'localhost'
        port: '3306'
        user: 'linkitAdmin'
        password: 'linkitAdmin'
        database: 'linkit'

    connection.connect (err)->
        if err then return console.error 'error connecting: ' + err.stack
        console.log 'connected as id '+ connection.threadId
        return
    
    return
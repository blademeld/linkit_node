module.exports = (app)->
    app.get "/", (req, res)->
        res.json {status: "Linkit Node Server"}
        
    app.get "/product", (req, res)->
        app.connection.query 'SELECT * FROM products', [], (err, results, fields)->
            if err then return console.error err.stack
            res.send results
            return
        return
        
    app.get "/product/:id", (req, res)->
        app.connection.query 'SELECT * FROM products WHERE id = ?', [req.params.id], (err, results, fields)->
            if err then return console.error err.stack
            res.send results
            return
        return
        
    app.post "/product", (req, res)->
        app.connection.query 'INSERT INTO products (name,spec,stat,cost,sell,amnt) VALUES (?,?,?,?,?,?)', [req.body.name, req.body.spec, req.body.stat, req.body.cost, req.body.sell, req.body.amnt], (err, results, fields)->
            if err then return console.error err.stack
            res.send results
            return
        return
    
    app.put "/product", (req, res)->
        app.connection.query 'UPDATE products SET name = ?, spec = ?, stat = ?, cost = ?, sell = ?, amnt = ? WHERE id = ?', [req.body.name, req.body.spec, req.body.stat, req.body.cost, req.body.sell, req.body.amnt, req.body.id], (err, results, fields)->
            if err then return console.error err.stack
            res.send results
            return
        return
    
    app.delete "/products", (req, res)->
        app.connection.query 'DELETE FROM products WHERE id = ?', [req.body.id], (err, results, fields)->
            if err then return console.error err.stack
            res.send results
            return
        return
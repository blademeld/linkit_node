// Generated by CoffeeScript 1.9.3
(function() {
  module.exports = function(app) {
    return app.get("/", function(req, res) {
      return res.json({
        status: "Linkit Node Server"
      });
    });
  };

}).call(this);
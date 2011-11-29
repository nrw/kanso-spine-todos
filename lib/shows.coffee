templates = require("duality/templates") 

exports.root = (doc, req) ->
  title: "Todos"
  content: templates.render("base.html", req, {})
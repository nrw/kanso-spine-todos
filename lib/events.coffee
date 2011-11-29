events = require("duality/events") 

events.on "updateFailure", (err, info, req, res, doc) ->
  alert err.message or err.toString()


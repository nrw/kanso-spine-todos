# $ = require('spine/core').$

exports.model = (doc, req) ->
  log "BEGIN MODELS UPDATE FUNCTION"
  # log doc
  # mindoc = $.extend(true, {}, doc);
  # form = new forms.Form(types.login, null, {})
  # form.validate req
  # if form.values.user and form.values.pass
  #   session.login form.values.user, form.values.pass, ((err)-> log err if err)
  [doc, JSON.stringify(doc)]

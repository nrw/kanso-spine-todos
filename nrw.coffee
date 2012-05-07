Note = require "models/note"
{_} = require "underscore"

setup_changes =  ->
  appdb = db.use(require('duality/core').getDBURL())
  
  q = include_docs: yes
    
  appdb.changes q, (err, resp) =>
    docs = _.pluck resp?.results, "doc"
    notes = _.filter docs, (doc) -> doc.modelname is "notes"
    Note.refresh(notes)
    yes



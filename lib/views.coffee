
exports.docs_by_modelname = 
  map: (doc) ->
    emit [doc.modelname], null

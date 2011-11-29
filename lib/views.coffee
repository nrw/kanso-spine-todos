exports.tasks = 
  map: (doc) ->
    if doc.type is "task"
      emit [doc._id], null

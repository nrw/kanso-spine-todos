module.exports = [
  # static
  from: "/static/*"
  to: "static/*"
,
  require('spine/rewrites')
, # spine static 
  from: "/spine/lib/*"
  to: "spine/lib/*"

, # get tasks
  from: "/tasks"
  to: "_list/tasks/tasks"
  query:
    include_docs: "true"
    format: "json"

, # show root
  from: "/"
  to: "_show/root"

, # catchall
  from: "*"
  to: "_show/not_found"
 ]
exports.tasks = (head, req) ->
  start
    code: 200
    headers:
      "Content-Type": "application/json"
  send "["
  first = yes
  while row = getRow()
    send "," if not first
    send JSON.stringify row.doc
    first = no
  "]"

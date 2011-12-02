module.exports = [
  # static
  from: "/static/*"
  to: "static/*"

, # spine
  require('spine-adapter/rewrites')

, # show root
  from: "/"
  to: "_show/root"

, # catchall
  from: "*"
  to: "_show/not_found"
 ]
$ = jQuery

Spine.Model.include toJSON: ->
  result = {}
  for key in @constructor.attributes when key of @
    if typeof @[key] is 'function'
      result[key] = @[key]()
    else
      result[key] = @[key]
  result._id = @id if @id
  result.type = "task"
  result

class Task extends Spine.Model
  @configure "Task", "name", "done"
  
  @extend Spine.Model.Ajax

  # Choose exactly one of the following lines:
  # Uncomment this line to read tasks
  @url: "/tasks/_design/tasks/_rewrite/tasks"
  
  # Uncomment this line to save tasks
  # @url: "/tasks"

  @active: ->
    @select (item) -> !item.done

  @done: ->
    @select (item) -> !!item.done

  @destroyDone: ->
    rec.destroy() for rec in @done()
  
class Tasks extends Spine.Controller
  events:
   "change   input[type=checkbox]": "toggle"
   "click    .destroy":             "remove"
   "dblclick .view":                "edit"
   "keypress input[type=text]":     "blurOnEnter"
   "blur     input[type=text]":     "close"
 
  elements:
    "input[type=text]": "input"

  constructor: ->
    super
    @item.bind("update",  @render)
    @item.bind("destroy", @release)
  
  render: =>
    @replace($("#taskTemplate").tmpl(@item))
    @
  
  toggle: ->
    @item.done = !@item.done
    @item.save()
  
  remove: ->
    @item.destroy()
  
  edit: ->
    @log @item
    @el.addClass("editing")
    @input.focus()
  
  blurOnEnter: (e) ->
    if e.keyCode is 13 then e.target.blur()
  
  close: ->
    @el.removeClass("editing")
    @item.updateAttributes({name: @input.val()})

class TaskApp extends Spine.Controller
  events:
    "submit form":   "create"
    "click  .clear": "clear"

  elements:
    ".items":     "items"
    ".countVal":  "count"
    ".clear":     "clear"
    "form input": "input"
  
  constructor: ->
    super
    @log "taskapp constructor"
    Task.bind("create",  @addOne)
    Task.bind("refresh", @addAll)
    Task.bind("refresh change", @renderCount)
    Task.fetch()
    
  
  addOne: (task) =>
    @log JSON.stringify(task.toJSON())
    # task.toJSON()
    view = new Tasks(item: task)
    @items.append(view.render().el)
  
  addAll: =>
    Task.each(@addOne)

  create: (e) ->
    e.preventDefault()
    Task.create(name: @input.val())
    @input.val("")
  
  clear: ->
    Task.destroyDone()
  
  renderCount: =>
    active = Task.active().length
    @count.text(active)
    
    inactive = Task.done().length
    if inactive 
      @clear.show()
    else
      @clear.hide()

module.exports = TaskApp

# <script type="text/javascript" charset="utf-8">
#   var exports = this;
#   jQuery(function(){
#     var App = require("lib/index");
#     exports.app = new App({el: $("#content")});      
#   });
# </script>
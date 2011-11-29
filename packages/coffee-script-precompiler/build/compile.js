var async, coffeescript, compileCoffee, logger, modules, path, spawn, utils;
coffeescript = require("../coffee-script/lib/coffee-script/coffee-script");
async = require("async");
logger = require("kanso/logger");
utils = require("kanso/utils");
spawn = require("child_process").spawn;
path = require("path");
modules = require("kanso/modules");
compileCoffee = function(project_path, filename, settings, callback) {
  var args, coffeec, err_out, js;
  logger.info("compiling", utils.relpath(filename, project_path));
  args = [filename];
  args.unshift("--print");
  coffeec = spawn(__dirname + "/../coffee-script/bin/coffee", args);
  js = "";
  err_out = "";
  coffeec.stdout.on("data", function(data) {
    return js += data;
  });
  coffeec.stderr.on("data", function(data) {
    return err_out += data;
  });
  return coffeec.on("exit", function(code) {
    if (code === 0) {
      return callback(null, js);
    } else {
      return callback(new Error(err_out));
    }
  });
};
module.exports = {
  before: "properties",
  run: function(root, path, settings, doc, callback) {
    var paths;
    if (!settings["coffee-script"]) {
      return callback(null, doc);
    }
    if (!settings["coffee-script"]["modules"] && !settings["coffee-script"]["attachments"]) {
      return callback(null, doc);
    }
    paths = settings["coffee-script"]["modules"] || [];
    if (!Array.isArray(paths)) {
      paths = [paths];
    }
    return async.forEach(paths, (function(p, cb) {
      var pattern;
      pattern = /.*\.coffee/i;
      return utils.find(utils.abspath(p, path), pattern, function(err, data) {
        if (err) {
          return cb(err);
        }
        return async.forEach(data, (function(filename, callback2) {
          var name;
          name = utils.relpath(filename, path).replace(/\.coffee$/, "");
          return compileCoffee(path, filename, settings, function(err, js) {
            if (err) {
              return callback2(err);
            }
            modules.add(doc, name, js.toString());
            return callback2();
          });
        }), cb);
      });
    }), function(err) {
      return callback(err, doc);
    });
  }
};
(function() {
  var CompassFilter, Filter, Promise, path, spawn;

  path = require('path');

  spawn = require('child_process').spawn;

  Filter = require('broccoli-filter');

  Promise = require('rsvp').Promise;

  CompassFilter = function(inputTree, options) {
    var isCompassFilter;
    isCompassFilter = this instanceof CompassFilter;
    if (!isCompassFilter) {
      return new CompassFilter(inputTree, options);
    }
    this.inputTree = inputTree;
    this.options || (this.options = {
      'sassDir': this.inputTree.srcDir
    });
    return this;
  };

  CompassFilter.prototype = Object.create(Filter.prototype);

  CompassFilter.prototype.constructor = CompassFilter;

  CompassFilter.prototype.extensions = ['sass', 'scss'];

  CompassFilter.prototype.targetExtension = 'css';

  CompassFilter.prototype.processString = function(string, relativePath) {
    var compassArgs;
    compassArgs = ['compile', '--sass-dir=' + this.options.sassDir, '--css-dir=css'];
    return new Promise(function(resolve, reject) {
      var compile;
      compile = spawn('compass', compassArgs, {
        cwd: process.cwd()
      });
      return compile.on('close', function(result) {
        return resolve();
      });
    });
  };

  module.exports = CompassFilter;

}).call(this);

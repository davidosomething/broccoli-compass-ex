path = require 'path'

# calling compass executable in a child process
spawn = require('child_process').spawn

# this is a broccoli filter
Filter = require 'broccoli-filter'

# the spawned output is async, use a promise to wait for it to resolve
Promise = require('rsvp').Promise;

# CompassFilter
# @param inputTree
# @example for inputTree {
#   inputtree: 'fixtures'
#   srcDir:    'test1/',
# @param object options
CompassFilter = (inputTree, options)->
  isCompassFilter = (this instanceof CompassFilter)
  return new CompassFilter(inputTree, options) unless isCompassFilter

  @inputTree = inputTree
  @options ||= {
    'sassDir': @inputTree.srcDir
  }
  console.log('input tree ----------')
  console.log(inputTree)
  console.log('----------')
  return @

CompassFilter.prototype = Object.create(Filter.prototype)
CompassFilter.prototype.constructor = CompassFilter
CompassFilter.prototype.extensions = ['sass', 'scss']
CompassFilter.prototype.targetExtension = 'css'

# CompassFilter.processString
#
# @param string string the file contents
# @param string relativePath the file path
CompassFilter.prototype.processString = (string, relativePath)->
  compassArgs = [
    'compile'
    '--sass-dir=' + @options.sassDir
    '--css-dir=css'
  ]

  return new Promise (resolve, reject)->
    compile = spawn('compass', compassArgs, { cwd: process.cwd() })
    compile.on 'close', (result)->
      resolve()

module.exports = CompassFilter

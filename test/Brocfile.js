var pickFiles = require('broccoli-static-compiler');
var compileCompass = require('../index.js')

var test1 = pickFiles('fixtures', {
  srcDir: 'test1/',
  destDir: 'test1'
})

test1 = compileCompass(test1);

module.exports = test1;

module.exports = ->

  @loadNpmTasks 'grunt-coffeelint'
  @loadNpmTasks 'grunt-contrib-clean'
  @loadNpmTasks 'grunt-contrib-coffee'

  @config 'clean',
    output: [ 'test/output' ]

  @config 'coffeelint',
    gruntfile: [ 'Gruntfile.coffee' ]
    source: [ 'src/*.coffee' ]

  @config 'coffee',
    source:
      files:
        'index.js': 'src/index.coffee'

  @registerTask 'default', [
    'coffeelint:source'
    'coffee:source'
    'clean:output'
  ]

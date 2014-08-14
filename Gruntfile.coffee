module.exports = (grunt) ->
  require('load-grunt-tasks')(grunt)

  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')

    connect:
      server:
        options:
          keepalive: true

    coffee:
      dist:
        src: './src/angular-step-input.coffee'
        dest: './angular-step-input.js'

    sass:
      dist:
        src: './src/angular-step-input.sass'
        dest: './angular-step-input.css'

    ngAnnotate:
      dist:
        src: './angular-step-input.js'
        dest: './angular-step-input.js'

    uglify:
      options:
        preserveComments: 'some'
      dist:
        src: './angular-step-input.js'
        dest: './angular-step-input.min.js'

    karma:
      dist:
        configFile: 'karma.conf.js'

    watch:
      coffee:
        files: './src/angular-step-input.coffee'
        tasks: ['coffee']
      sass:
        files: './src/angular-step-input.sass'
        tasks: ['sass']

  grunt.registerTask('default', ['ngAnnotate', 'uglify'])
  grunt.registerTask('server', ['default', 'connect', 'watch'])
  grunt.registerTask('test', ['karma:dist'])

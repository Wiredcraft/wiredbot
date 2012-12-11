module.exports = function(grunt) {
  // Project configuration.
  grunt.initConfig({
    pkg: '<json:package.json>',
    // test: {
    //   files: ['test/**/*.js']
    // },
    // Sorry, we use coffee-script here.
    // lint: {
    //   files: ['grunt.js', 'lib/**/*.js', 'test/**/*.js']
    // },
    // jshint: {
    //   options: {
    //     curly: true,
    //     eqeqeq: true,
    //     immed: true,
    //     latedef: true,
    //     newcap: true,
    //     noarg: true,
    //     sub: true,
    //     undef: true,
    //     boss: true,
    //     eqnull: true,
    //     node: true
    //   },
    //   globals: {
    //     exports: true
    //   }
    // }, 
    watch: {
      files: '<config:lint.files>',
      tasks: 'default'
    },
    coffeelintOptions: {
      'no_tabs': {
        'level': 'error'
      },

      'no_trailing_whitespace': {
        'level': 'error'
      },

      'max_line_length': {
        'value': 9999,
        'level': 'warn'
      },

      'camel_case_classes': {
        'level': 'error'
      },

      'indentation': {
        'value': 2,
        'level': 'error'
      },

      'no_implicit_braces': {
        'level': 'ignore'
      },

      'no_trailing_semicolons': {
        'level': 'error'
      },

      'no_plusplus': {
        'level': 'ignore'
      },

      'no_throwing_strings': {
        'level': 'error'
      },

      'cyclomatic_complexity': {
        'value': 11,
        'level': 'ignore'
      },

      'line_endings': {
        'value': 'unix',
        'level': 'ignore'
      },

      'no_implicit_parens': {
        'level': 'ignore'
      }

    },
    coffeelint: {
      app: ['./scripts/**/*.coffee']
    },
    simplemocha: {
      all: {
        options: {
          src: './test/**/*.coffee',
          globals: ['chai'],
          timeout: 3000,
          ignoreLeaks: false,
          grep: '*-test',
          ui: 'bdd',
          reporter: 'spec',
          compilers: {
            coffee: 'coffee-script'
          }
        }
      }
    },
    docco: {
      app: {
        src: ['./scripts/profile.coffee', './scripts/consciousness.coffee',
              './scripts/wiredcraft.coffee', './scripts/wiredthings.coffee']
      }
    }
  });

  //
  grunt.loadNpmTasks('grunt-docco');
  grunt.loadNpmTasks('grunt-coffeelint');
  grunt.loadNpmTasks('grunt-simple-mocha');

  // Default task.
  grunt.registerTask('default', 'coffeelint docco');

};
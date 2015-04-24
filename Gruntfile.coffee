module.exports = (grunt) ->
  grunt.initConfig
    pkg: grunt.file.readJSON('package.json')

    clean:
      openclerk: ['openclerk/']
      docs: ['docs/']

    gitclone:
      clone:
        options:
          repository: 'https://github.com/soundasleep/openclerk'
          branch: 'master'
          directory: 'openclerk'

    composer:
      openclerk:
        options:
          cwd: 'openclerk'

    phpdoc2:
      openclerk:
        options:
          directories: [
            'openclerk/batch/',
            'openclerk/core/',
            'openclerk/inc/',
            'openclerk/jobs/',
            'openclerk/site/',
            'openclerk/templates/',
            'openclerk/vendor/openclerk/',
            'openclerk/vendor/soundasleep/'
          ],
          output: 'docs/'
          json: 'database.json'
          config: 'phpdoc2.json'

  grunt.loadNpmTasks 'grunt-contrib-clean'
  grunt.loadNpmTasks 'grunt-composer'
  grunt.loadNpmTasks 'grunt-git'
  grunt.loadNpmTasks 'grunt-phpdoc2'

  grunt.registerTask 'default', 'Generate documentation', [
    'clean',
    'gitclone',
    'composer:openclerk:install'
    'phpdoc2'
  ]

// Generated on 2013-04-18 using generator-ember 0.2.4
'use strict';

module.exports = function (grunt) {
    // load all grunt tasks
    require('matchdep').filterDev('grunt-*').forEach(grunt.loadNpmTasks);

  // Experimenting with git & grunt builds
  //grunt.loadNpmTasks('grunt-git');
  grunt.loadNpmTasks('grunt-bower-task');

    // configurable paths
    var armTechConfig = {
        app: 'app',
        dist: 'dist'
    };

    grunt.initConfig({
        armTech: armTechConfig,
        clean: {
            dist: {
                files: [{
                    dot: true,
                    src: [
                        '.tmp',
                        '<%= armTech.dist %>/*',
                        '!<%= armTech.dist %>/.git*'
                    ]
                }]
            },
            server: '.tmp'
        },
        jshint: {
            options: {
                jshintrc: '.jshintrc'
            },
            all: [
                'Gruntfile.js',
                '<%= armTech.app %>/scripts/{,*/}*.js',
                '!<%= armTech.app %>/scripts/vendor/*',
                'test/spec/{,*/}*.js'
            ]
        },
        rev: {
            dist: {
                files: {
                    src: [
                        '<%= armTech.dist %>/scripts/{,*/}*.js',
                        '<%= armTech.dist %>/styles/{,*/}*.css',
                        '<%= armTech.dist %>/images/{,*/}*.{png,jpg,jpeg,gif,webp}',
                        '<%= armTech.dist %>/styles/fonts/*'
                    ]
                }
            }
        },
        copy: {
            dist: {
                files: [{
                    expand: true,
                    dot: true,
                    cwd: '<%= armTech.app %>',
                    dest: '<%= armTech.dist %>',
                    src: [
                        '*.{ico,txt}',
                        '.htaccess',
                        'images/{,*/}*.{webp,gif}',
                        'styles/fonts/*'
                    ]
                }]
            }
        },
        git: {
            commit: {
                options: {
                    command: 'commit',
                    message: 'grunt testing'
                }
                ,files: {
                    //src: ['test.txt']
                    //src: grunt.file.expand('**/*')
                    //src: grunt.file.expand({cwd: cwd},['**/*'])
                }
            },
            push: {
                options: {
                    command: 'push'
                }
            }
        },
        bower: {
                install: {
                options: {
                  cleanTargetDir: true,
                  cleanBowerDir: true,
                  install: true,
                  copy: true
                }
          }
        }
    });

    grunt.registerTask('test', [
        'clean:server',
        'concurrent:test',
        'connect:test',
        'mocha'
    ]);

    grunt.registerTask('build', [
        'clean:dist',
        'useminPrepare',
        'concurrent:dist',
        'cssmin',
        'concat',
        'uglify',
        'copy',
        'rev',
        'usemin'
    ]);

    grunt.registerTask('default', [
        'test',
        'build'
    ]);
};

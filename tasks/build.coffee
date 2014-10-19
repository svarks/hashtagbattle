gulp      = require 'gulp'
coffeeify = require 'gulp-coffeeify'
stylus    = require 'gulp-stylus'
concat    = require 'gulp-concat'

gulp.task 'build', ['scripts', 'styles']

gulp.task 'scripts', ['scripts:app', 'scripts:vendor']

gulp.task 'scripts:vendor', ->
  gulp.src([
    'bower_components/jquery/dist/jquery.js'
  ])
    .pipe(concat('vendor.js'))
    .pipe(gulp.dest('public'))

gulp.task 'scripts:app',  ->
  gulp.src('assets/scripts/*.coffee')
    .pipe(coffeeify())
    .pipe(gulp.dest('public'))

gulp.task 'styles', ->
  gulp.src('assets/styles/*.styl')
    .pipe(stylus())
    .pipe(gulp.dest('public'))

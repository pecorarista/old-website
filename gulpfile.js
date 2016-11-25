'use strict';

const gulp = require('gulp');
const pug = require('gulp-pug');
const puglint = require('gulp-pug-linter');
const sass = require('gulp-sass')
const sasslint = require('gulp-sass-lint')
const postcss = require('gulp-postcss');
const cssnext = require('postcss-cssnext');
const processors = [ cssnext() ];

const pugFiles = ['pug/**/*.pug', '!pug/**/_*.pug']
const sassFiles = ['sass/**/*.s+(a|c)ss']

gulp.task('pug', () =>
  gulp.src(pugs)
    .pipe(puglint())
    .pipe(puglint.reporter('fail'))
    .pipe(pug({
      pretty: true,
      data: {
        lang: 'en'
      }
    }))
    .pipe(gulp.dest('html'))
);

gulp.task('sass', () =>
  gulp.src(stylesheets)
    .pipe(sasslint())
    .pipe(sasslint.format())
    .pipe(sasslint.failOnError())
    .on('error', error => process.exit(error))
    .pipe(sass({ outputStyle: 'expanded' }))
    .pipe(postcss(processors))
    .pipe(gulp.dest('css'))
);

gulp.task('default', () => ['pug', 'sass']);

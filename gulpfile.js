'use strict';

const gulp = require('gulp');
const webserver = require('gulp-webserver');
const pug = require('gulp-pug');
const puglint = require('gulp-pug-linter');
const sass = require('gulp-sass');
const sasslint = require('gulp-sass-lint');
const postcss = require('gulp-postcss');
const cssnext = require('postcss-cssnext');
const processors = [ cssnext() ];
const dist = 'dist';
const pugFiles = ['pug/**/*.pug', '!pug/**/_*.pug'];
const sassFiles = ['sass/**/*.s+(a|c)ss'];
const highlighter = {
  css: 'bower_components/highlightjs/styles/solarized-light.css',
  js: 'bower_components/highlightjs/highlight.pack.js'
};
const mathjax = 'bower_components/MathJax/MathJax.js';
const materialize = {
  css: 'bower_components/materialize/dist/css/materialize.css',
  js: 'bower_components/materialize/dist/js/materialize.js'
};
const roboto = {
  css: 'bower_components/roboto-fontface/css/**/*.css',
  font: 'bower_components/roboto-fontface/fonts/**/*.{eot,svg,woff}'
};
const jquery = 'bower_components/jquery/dist/jquery.min.js';
const img = 'img/**/*';

gulp.task('img', () =>
  gulp.src(img).pipe(gulp.dest('dist/public/img/'))
);

gulp.task('font', () => {
  gulp.src(roboto.font).pipe(gulp.dest('dist/public/fonts/'));
  gulp.src(roboto.css).pipe(gulp.dest('dist/public/css/'));
});

gulp.task('pug', () => {
  gulp.src(pugFiles)
    .pipe(puglint())
    .pipe(puglint.reporter('fail'))
    .pipe(pug({
      pretty: true
    }))
    .pipe(gulp.dest('dist'));
});

gulp.task('sass', () =>
  gulp.src(sassFiles)
    .pipe(sasslint())
    .pipe(sasslint.format())
    .pipe(sasslint.failOnError())
    .on('error', error => process.exit(error))
    .pipe(sass({ outputStyle: 'expanded' }))
    .pipe(postcss(processors))
    .pipe(gulp.dest('dist/public/css'))
);

gulp.task('vendor', () => {
  gulp.src(highlighter.css).pipe(gulp.dest('dist/public/css'));
  gulp.src(highlighter.js).pipe(gulp.dest('dist/public/js'));
  gulp.src(mathjax).pipe(gulp.dest('dist/public/js'));
  gulp.src(materialize.css).pipe(gulp.dest('dist/public/css'));
  gulp.src(materialize.js).pipe(gulp.dest('dist/public/js'));
  gulp.src(jquery).pipe(gulp.dest('dist/public/js'));
});

gulp.task('default', ['img', 'font', 'pug', 'sass', 'vendor']);

gulp.task('server', ['default'],() => {
  gulp.watch(pugFiles, ['pug']);
  gulp.watch(sassFiles, ['sass']);
  gulp.src(dist)
    .pipe(webserver({
      livereload: true
    }))
});

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
const posts = require('./posts.json');
const pugFiles = ['pug/**/*.pug', '!pug/**/_*.pug', '!pug/index.pug'];
const index = 'pug/index.pug';
const sassFiles = ['sass/**/*.s+(a|c)ss'];
const img = 'img/**/*';

gulp.task('img', () =>
  gulp.src(img).pipe(gulp.dest('dist/public/img/'))
);

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

gulp.task('index', () => {
  ['en', 'ja'].forEach(lang =>
    gulp.src(index)
      .pipe(puglint())
      .pipe(puglint.reporter('fail'))
      .pipe(pug({
        pretty: true,
        data: {
          lang: lang,
          posts: posts
        }
      }))
      .pipe(gulp.dest('dist'))
  );
});

gulp.task('default', ['img', 'index', 'pug', 'sass']);

gulp.task('server', ['default'],() => {
  gulp.watch(['pug/**/*.pug', '!pug/index.pug'], ['pug']);
  gulp.watch([index, 'pug/**/_*.pug'], ['index']);
  gulp.watch(sassFiles, ['sass']);
  gulp.src(dist)
    .pipe(webserver({
      livereload: true,
      port: 8000
    }));
});

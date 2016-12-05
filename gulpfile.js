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
const index = 'pug/**/index.pug';
const sassFiles = ['sass/**/*.s+(a|c)ss'];
const img = 'img/**/*';
const highlighter = {
  css: './bower_components/prism/themes/prism.css',
  js: [
    './bower_components/prism/prism.js',
    './bower_components/prism/components/prism-bash.min.js',
    './bower_components/prism/components/prism-makefile.min.js',
    './bower_components/prism/components/prism-latex.min.js',
    './bower_components/prism/components/prism-java.min.js',
    './bower_components/prism/components/prism-scala.min.js'
  ]
};

gulp.task('pdfjs', () => {
  gulp.src('./bower_components/pdfjs-dist/build/*')
    .pipe(gulp.dest('dist/pdf.js/build'));
  gulp.src('./bower_components/pdfjs-dist/web/**/*')
    .pipe(gulp.dest('dist/pdf.js/web'));
});

gulp.task('img', () =>
  gulp.src(img).pipe(gulp.dest('dist/public/img/'))
);

gulp.task('post', () => {
  ['en', 'ja'].forEach(lang => {
    gulp.src([`pug/${lang}/\*\*/\*.pug`, `!pug/${lang}/index.pug`])
      .pipe(puglint())
      .pipe(puglint.reporter('fail'))
      .pipe(pug({
        pretty: true,
        data: {
          lang: 'ja'
        }
      }))
      .pipe(gulp.dest('dist/ja/'));
  });
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

gulp.task('highlighter', () => {
  console.log('E');
  gulp.src(highlighter.css).pipe(gulp.dest('dist/public/css'));
  gulp.src(highlighter.js).pipe(gulp.dest('dist/public/js'));
});

gulp.task('default', ['pdfjs', 'img', 'highlighter', 'index', 'post', 'sass']);

gulp.task('server', ['default'],() => {
  gulp.watch(['pug/**/*.pug', '!pug/**/index.pug'], ['post']);
  gulp.watch([index, 'pug/**/_*.pug'], ['index']);
  gulp.watch(sassFiles, ['sass']);
  gulp.src(dist)
    .pipe(webserver({
      livereload: true,
      port: 8000
    }));
});

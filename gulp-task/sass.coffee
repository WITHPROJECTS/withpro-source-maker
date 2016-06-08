gulp           = require('gulp')
path           = require('path')
compass        = require('gulp-compass')
pleeease       = require('gulp-pleeease')
cache          = require('gulp-cached')
plumbler       = require('gulp-plumber')
conf           = require('../gulpfile')

gulp.task('sass',->
    targetFile = conf.watchFile.sass
    destDir    = conf.path.out.css
    _conf      = conf.css
    task       = process.argv[2]
    source     = gulp.src( targetFile )
        .pipe( cache( 'sass' ) )
        .pipe( plumbler( _conf.plumber ) )
        .pipe( compass( _conf.sass ) )
        .pipe( pleeease( _conf.pleeease ) )
        .pipe( plumbler.stop() )
        .pipe( gulp.dest( destDir ) )
    if task is 'watch'
        return
    else
        return source
)

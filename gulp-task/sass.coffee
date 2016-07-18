gulp      = require('gulp')
path      = require('path')
sass      = require('gulp-sass')
sassImg   = require('gulp-sass-image')
pleeease  = require('gulp-pleeease')
cache     = require('gulp-cached')
plumbler  = require('gulp-plumber')
sourcemap = require('gulp-sourcemaps')
conf      = require('../gulpfile')

# ==============================================================================
#
# ==============================================================================
gulp.task('sass:image', ->
    _param            = conf.css.sassImage.param
    _imgPtn           = path.join(conf.path.out.img, '**/*.+(jpeg|jpg|png|gif|svg)')
    _param.targetFile = conf.css.sassImage.destFile
    _dest             = path.join(conf.css.sassImage.destDir )
    return gulp.src(_imgPtn)
        .pipe(sassImg(_param))
        .pipe( gulp.dest(_dest) )
)

# ==============================================================================
#
# ==============================================================================
gulp.task('sass', ['sass:image'], ->
    _targetFile = conf.watchFile.sass
    _destDir    = conf.path.out.css
    _conf       = conf.css
    _task       = process.argv[2]

    _source     = gulp.src( _targetFile )
        .pipe( plumbler( _conf.plumber ) )
        .pipe( sourcemap.init() )
        .pipe( sass( _conf.sass ) )
        .pipe( pleeease( _conf.pleeease ) )
        .pipe( sourcemap.write('./') )
        .pipe( plumbler.stop() )
        .pipe( gulp.dest( _destDir ) )

    if _task is 'watch'
        return
    else
        return _source
)

gulp       = require('gulp')
path       = require('path')
fs         = require('fs')
execSync   = require('child_process').execSync
styleguide = require('devbridge-styleguide')
# ejs         = require('gulp-ejs')
# rename      = require('gulp-rename')
# _           = require('lodash')
# browserSync = require('browser-sync').create()

styleguide  = require('devbridge-styleguide')
conf        = require('../gulpfile')

gulp.task('styleguide', ['browserSnyc-styleguide'], ->
    _conf = conf.styleguide.styleguide.param

    if !fs.existsSync(conf.path.out.styleguide)
        execSync('styleguide initialize '+conf.path.out.styleguide)

    styleguide.startServer(_conf)


    # fs.stats(conf.path.out.styleguide, (err, stats)->
        # if obj and obj[]
        # console.log stats
        # return
    # )
    # styleguide.startServer()


    # _conf    = conf.styleguide.aigis
    # _param   = _conf.param
    # assetDir = path.dirname(_conf.confFile)

    # styleguide = require('devbridge-styleguide')

    #browserSync.init(
    #    server :
    #        baseDir : conf.path.out.styleguide
    #)
    #for _key of _param
    #    if _key is 'dest' then _param[_key] = path.relative(assetDir, conf.path.out.styleguide)
    #    #if _key is 'source'
    #    #    for _val, _i in _param[_key] then _param[_key][_i] = path.relative(assetDir, _val)
    #
    ## --------------------------------------------------------------------------
    ## スタイルガイドの作成
    #build = ()->
    #    return
    #    return gulp.src(_conf.confFile)
    #        .pipe(aigis())
    #
    ## --------------------------------------------------------------------------
    ## 設定ファイルの生成
    #return gulp.src(_conf.confTempFile)
    #    .pipe(ejs(_param))
    #    .pipe(rename({ extname : '.yml' }))
    #    .pipe(gulp.dest(assetDir))
    #    .on('end', build)
)

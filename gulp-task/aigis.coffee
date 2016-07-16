gulp   = require('gulp')
path   = require('path')
aigis  = require('gulp-aigis')
ejs    = require('gulp-ejs')
rename = require('gulp-rename')
_      = require('lodash')
conf   = require('../gulpfile')

gulp.task('styleguide', ->
    _conf    = conf.styleguide.aigis
    _param   = _conf.param
    assetDir = path.dirname(_conf.confFile)
    for _key of _param
        if _key is 'dest' then _param[_key] = path.relative(assetDir, conf.path.out.styleguide)
        #if _key is 'source'
        #    for _val, _i in _param[_key] then _param[_key][_i] = path.relative(assetDir, _val)

    # --------------------------------------------------------------------------
    # スタイルガイドの作成
    build = ()->
        return
        return gulp.src(_conf.confFile)
            .pipe(aigis())

    # --------------------------------------------------------------------------
    # 設定ファイルの生成
    return gulp.src(_conf.confTempFile)
        .pipe(ejs(_param))
        .pipe(rename({ extname : '.yml' }))
        .pipe(gulp.dest(assetDir))
        .on('end', build)
)

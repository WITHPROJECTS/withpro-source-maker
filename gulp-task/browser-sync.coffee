gulp        = require('gulp')
path        = require('path')
_           = require('lodash')
browserSync = require('browser-sync').create()
conf        = require('../gulpfile')


# ==============================================================================
# ローカルサーバー
# ==============================================================================
gulp.task('browserSnyc-localServer', ->
    _conf = conf.browserSync
    browserSync.init(_conf.localSrvParam)
    return this
)

# ==============================================================================
# スタイルガイドサーバー
# ==============================================================================
gulp.task('browserSnyc-styleguide', ->
    _conf = conf.browserSync
    browserSync.init(_conf.styleguideSrvParam)
    return this
)

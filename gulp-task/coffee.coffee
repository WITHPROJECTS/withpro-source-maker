gulp       = require('gulp')
path       = require('path')
# __         = require('lodash')
sourcemaps = require('gulp-sourcemaps')
coffee     = require('gulp-coffee')
uglify     = require('gulp-uglify')
plumbler   = require('gulp-plumber')
conf       = require('../gulpfile')
concat     = require('gulp-concat')
cache      = require('gulp-cached')

gulp.task('coffee',->
    targetFile = conf.watchFile.coffee
    destDir    = conf.path.out.js
    _conf      = conf.coffee
    _path      = null
    _list      = null
    task       = process.argv[2]
    source     = null
    # 結合あり -----------------------------------------------------------------
    if conf.coffee.concatList
        if task is 'watch'
            # watchタスクから呼ばれた場合は該当する結合ファイルのみ結合する
            _path = path.relative(conf.cwd,conf.temp.coffee.changeFile)
            _list = {}
            for _filePath, _fileList of _conf.concatList
                for _file in _fileList
                    if _file == _path
                        _list[_filePath] = _fileList
                        break
        else
            # coffeeタスク単体で呼ばれた場合は変更ファイルというのがないので全て処理
            _list = _conf.concatList

        for _path, _fileList of _list
            gulp.src( _fileList )
                .pipe( concat( _path ) )
                .pipe( plumbler( _conf.plumber ) )
                .pipe( sourcemaps.init() )
                .pipe( coffee( _conf.compileParam ) )
                .pipe( uglify( _conf.uglify ) )
                .pipe( sourcemaps.write( './' ) )
                .pipe( plumbler.stop() )
                .pipe( gulp.dest( destDir ) )
            return gulp.src( _fileList )
    # 結合なし -----------------------------------------------------------------
    else
        return gulp.src( targetFile )
            .pipe( plumbler( _conf.plumber ) )
            .pipe( cache('coffee') )
            .pipe( sourcemaps.init() )
            .pipe( coffee( _conf.compileParam ) )
            .pipe( uglify( _conf.uglify ) )
            .pipe( sourcemaps.write( './' ) )
            .pipe( plumbler.stop() )
            .pipe( gulp.dest( destDir ) )
)

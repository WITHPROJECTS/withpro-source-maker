gulp       = require('gulp')
path       = require('path')
sourcemaps = require('gulp-sourcemaps')
uglify     = require('gulp-uglify')
plumbler   = require('gulp-plumber')
conf       = require('../gulpfile')
concat     = require('gulp-concat')
cache      = require('gulp-cached')
babel      = require('gulp-babel')

gulp.task('js',->
    targetFile = conf.watchFile.js
    destDir    = conf.path.out.js
    _conf      = conf.js
    _path      = null
    _list      = null
    task       = process.argv[2]
    # 結合あり -----------------------------------------------------------------
    if conf.js.concatList
        if task is 'watch'
            # watchタスクから呼ばれた場合は該当する結合ファイルのみ結合する
            _path = path.relative(conf.cwd,conf.temp.js.changeFile)
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
                .pipe( cache('js') )
                .pipe( concat( _path ) )
                .pipe( plumbler( _conf.plumber ) )
                .pipe( sourcemaps.init() )
                .pipe( babel( _conf.babel ) )
                .pipe( uglify( _conf.uglify ) )
                .pipe( sourcemaps.write( './' ) )
                .pipe( plumbler.stop() )
                .pipe( gulp.dest( destDir ) )
            return gulp.src( _fileList )
    # 結合なし -----------------------------------------------------------------
    else
        return  gulp.src( targetFile )
            .pipe( cache('js') )
            .pipe( plumbler( _conf.plumber ) )
            .pipe( babel( _conf.babel ) )
            .pipe( uglify( _conf.uglify ) )
            .pipe( plumbler.stop() )
            .pipe( gulp.dest( destDir ) )
    return
)

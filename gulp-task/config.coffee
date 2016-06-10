gulp     = require('gulp')
path     = require('path')
conf     = require('../gulpfile')
cache    = require('gulp-cached')
notifier = require('node-notifier')

# ==============================================================================

conf.path =
    'gulp' :
        'task' : 'gulp-task/'
    # 入力ディレクトリ ---------------------------------------------------------
    'in' :
        'dir'    : 'src'
        'sass'   : 'src/sass/'
        'js'     : 'src/js/'
        'coffee' : 'src/coffee/'
        'font'   : 'src/font/'
    # 出力ディレクトリ ---------------------------------------------------------
    'out' :
        'dir'   : 'build'
        'js'    : 'build/js'
        'jsLib' : 'build/js/lib'
        'css'   : 'build/css'
        'img'   : 'build/img'
        'font'  : 'build/font'
    # ライブラリディレクトリ ---------------------------------------------------
    'lib' :
        'sass' : 'lib/sass'
        'js'   : 'lib/js'

# ==============================================================================
#
# 監視ファイル
#
# ==============================================================================
conf.watchFile =
    'sass'   : path.join(conf.path.in.sass,'**/*.sass')
    'coffee' : path.join(conf.path.in.coffee,'**/*.coffee')
    'js'     : path.join(conf.path.in.js,'**/*.js')

# ==============================================================================
#
# 命名規則 ファイル生成時など
#
# ==============================================================================
conf.namingRules =
    'joinWordsExt' : '-'  # 単語同士をつなげる文字
    'modeExt'      : '--' # 対象名とその状態を表す名称をつなげる文字
    'prefixExt'    : '__' # 対象の種別を表す文字

# ==============================================================================
#
# JavaScript
#
# ==============================================================================
conf.js =
    # 圧縮 ---------------------------------------------------------------------
    'uglify' :
        'magnle'           : true
        'preserveComments' : 'license'
    # 結合 ---------------------------------------------------------------------
    'concatList' : false
    # babelの設定 --------------------------------------------------------------
    'babel' :
        presets : ['es2015','stage-0','stage-1','stage-2']
    # watch停止防止処理 --------------------------------------------------------
    'plumber' :
        'errorHandler' : (err)->
            console.error err.message
            delete cache.caches['js']
            notifier.notify(
                'title'   : 'JS Error'
                'message' : err.message
                'sound'   : 'Glass'
            )
            return this

# ==============================================================================
#
# CoffeeScript
#
# ==============================================================================
conf.coffee =
    # コンパイル時のパラメータ -------------------------------------------------
    'compileParam' :
        'bare' : false
    # 圧縮 ---------------------------------------------------------------------
    'uglify' :
        'magnle'           : true
        'preserveComments' : 'license'
    # 結合 ---------------------------------------------------------------------
    'concatList' : false
    # watch停止防止処理 --------------------------------------------------------
    'plumber' :
        'errorHandler' : (err)->
            console.error err.name + ':' + err.message
            console.error err.location
            delete cache.caches['coffee']
            notifier.notify(
                'title'   : 'Coffee Error'
                'message' : err.message
                'sound'   : 'Glass'
            )
            return this

# ==============================================================================
#
# CSS
#
# ==============================================================================
conf.css =
    # Sass use Compass ---------------------------------------------------------
    'sass' :
        'style'       : 'expanded'
        'sourcemap'   : true
        'time'        : true
        'environment' : 'production'
        'sass'        : conf.path.in.sass
        'css'         : conf.path.out.css
        'javascript'  : conf.path.out.js
        'image'       : conf.path.out.img
        'font'        : conf.path.out.font
        'import_path' : [
            conf.path.lib.sass
        ]
    # CSS互換処理 --------------------------------------------------------------
    'pleeease' :
        'autoprefixer' :
           'browsers' : ['last 3 version']
           'cascade'  : true
        'minifier' : true
        'rem'      : true
        'opacity'  : false
    # watch停止防止処理 --------------------------------------------------------
    'plumber' :
        'errorHandler' : (err)->
            notifier.notify(
                'title'   : 'Sass Error'
                'message' : err.message
                'sound'   : 'Glass'
            )
            return this

# ==============================================================================
#
# icon font
#
# ==============================================================================
conf.iconfont =
    'templatePath' : path.join(conf.path.gulp.task, 'iconfont-assets/sample-template')
    'sassFileName' : '_iconfont'
    'sassFilePath' : path.join(conf.path.in.sass,'mixin/')
    'compileParam' :
        'fontName'       : 'iconfont'
        'prependUnicode' : true
        'formats'        : ['ttf', 'woff', 'svg']
        'normalize'      : true
        'fixedWidth'     : true


conf.temp = {}

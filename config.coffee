conf           = {cwd : process.cwd()}
module.exports = conf

# ==============================================================================
# パスの設定
# ==============================================================================
conf.path = {}
conf.path['projectRoot'] = './'
# 入力ディレクトリ
conf.path['in'] = { 'dir' : 'src' }
# 出力ディレクトリ
conf.path['out'] = { 'dir' : 'build' }



# require('./gulp-task/core/core')

# gulp     = require('gulp')
# path     = require('path')
# conf     = require('../gulpfile')
# cache    = require('gulp-cached')
# notifier = require('node-notifier')
# _        = require('lodash')
#
# # ==============================================================================
# conf.path =
#     'projectRoot' : './'
#     'gulp' :
#         'task' : 'gulp-task/'
#     # 入力ディレクトリ ---------------------------------------------------------
#     'in' :
#         'dir'    : 'src'
#         'sass'   : 'src/sass/'
#         'js'     : 'src/js/'
#         'coffee' : 'src/coffee/'
#         'font'   : 'src/font/'
#     # 出力ディレクトリ ---------------------------------------------------------
#     'out' :
#         'dir'        : 'build'
#         'js'         : 'build/js'
#         'jsLib'      : 'build/js/lib'
#         'css'        : 'build/css'
#         'img'        : 'build/img'
#         'font'       : 'build/font'
#         'map'        : 'build/css'
#         'styleguide' : 'styleguide'
#     # ライブラリディレクトリ ---------------------------------------------------
#     'lib' :
#         'sass' : 'lib/sass'
#         'js'   : 'lib/js'
#
# # ==============================================================================
# #
# # 監視ファイル
# #
# # ==============================================================================
# conf.watchFile =
#     'sass'   : path.join(conf.path.in.sass,'**/*.sass')
#     'coffee' : path.join(conf.path.in.coffee,'**/*.coffee')
#     'js'     : path.join(conf.path.in.js,'**/*.js')
#
# # ==============================================================================
# #
# # 命名規則 ファイル生成時など
# #
# # ==============================================================================
# conf.namingRules =
#     'joinWordsExt' : '-'  # 単語同士をつなげる文字
#     'modeExt'      : '--' # 対象名とその状態を表す名称をつなげる文字
#     'prefixExt'    : '__' # 対象の種別を表す文字
#
# # ==============================================================================
# #
# # JavaScript
# #
# # ==============================================================================
# conf.js =
#     # 圧縮 ---------------------------------------------------------------------
#     'uglify' :
#         'magnle'           : true
#         'preserveComments' : 'license'
#     # 結合 ---------------------------------------------------------------------
#     'concatList' : false
#     # babelの設定 --------------------------------------------------------------
#     'babel' :
#         presets : ['es2015','stage-0','stage-1','stage-2']
#     # watch停止防止処理 --------------------------------------------------------
#     'plumber' :
#         'errorHandler' : (err)->
#             console.error err.message
#             delete cache.caches['js']
#             notifier.notify(
#                 'title'   : 'JS Error'
#                 'message' : err.message
#                 'sound'   : 'Glass'
#             )
#             return this
#
# # ==============================================================================
# #
# # CoffeeScript
# #
# # ==============================================================================
# conf.coffee =
#     # コンパイル時のパラメータ -------------------------------------------------
#     'compileParam' :
#         'bare' : false
#     # 圧縮 ---------------------------------------------------------------------
#     'uglify' :
#         'magnle'           : true
#         'preserveComments' : 'license'
#     # 結合 ---------------------------------------------------------------------
#     'concatList' : false
#     # watch停止防止処理 --------------------------------------------------------
#     'plumber' :
#         'errorHandler' : (err)->
#             console.error err.name + ':' + err.message
#             console.error err.location
#             delete cache.caches['coffee']
#             notifier.notify(
#                 'title'   : 'Coffee Error'
#                 'message' : err.message
#                 'sound'   : 'Glass'
#             )
#             return this
#
# # ==============================================================================
# #
# # CSS
# #
# # ==============================================================================
# conf.css =
#     'sassImage' :
#         'destDir'  : path.join(conf.path.in.sass, 'func')
#         'destFile' : '_sass-image.scss'
#         'param'    :
#             'images_path' : conf.path.out.img
#             'css_path'    : conf.path.out.css
#             # 'http_images_path'
#     # Sass use Compass ---------------------------------------------------------
#     'sass' :
#         'outputStyle'       : 'expanded'
#         'precision'         : 5
#         'sourceComments'    : false
#         'sourceMap'         : true
#         'sourceMapContents' : false
#         'sourceMapEmbed'    : false
#         'includePaths'      : [ conf.path.lib.sass ]
#     # CSS互換処理 --------------------------------------------------------------
#     'pleeease' :
#         'autoprefixer' :
#            'browsers' : ['last 3 version']
#            'cascade'  : true
#         'minifier' : false
#         #'minifier' :
#         #    'preserveHacks'     : true
#         #    'removeAllComments' : false
#         'rem'      : true
#         'opacity'  : false
#     # watch停止防止処理 --------------------------------------------------------
#     'plumber' :
#         'errorHandler' : (err)->
#             notifier.notify(
#                 'title'   : 'Sass Error'
#                 'message' : err.message
#                 'sound'   : 'Glass'
#             )
#             delete cache.caches['sass']
#             return this
#
# # ==============================================================================
# #
# # icon font
# #
# # ==============================================================================
# conf.iconfont =
#     'templatePath' : path.join(conf.path.gulp.task, 'iconfont-assets/sample-template')
#     'sassFileName' : '_iconfont'
#     'sassFilePath' : 'mixin' # Sassディレクトリからの相対
#     # 'sassFilePath' : path.join(conf.path.in.sass,'mixin/')
#     'compileParam' :
#         'fontName'       : 'iconfont'
#         'prependUnicode' : true
#         'formats'        : ['ttf', 'woff', 'svg']
#         'normalize'      : true
#         'fixedWidth'     : true
#
# # ==============================================================================
# #
# # browser-sync
# #
# # ==============================================================================
# conf.browserSync =
#     'localSrvParam' :
#         'ui' :
#             'port' : 5010
#         'files'  : _.toArray(conf.watchFile)
#         'port'   : 5000
#         'open'   : 'external'
#         'server' :
#             'directory' : true
#             'baseDir'   : conf.path.projectRoot
#     'styleguideSrvParam' :
#         'ui' :
#             'port' : 5011
#         'port' : 5001
#         'open' : 'external'
#         'server' :
#             'directory' : true
#             'baseDir'   : conf.path.out.styleguide
#
# # ==============================================================================
# #
# # styleguide
# #
# # ==============================================================================
# conf.styleguide =
#     'styleguide' :
#         'param' :
#             'styleguidePath' : conf.path.out.styleguide
#     'aigis' :
#         'confFile'     : path.join(conf.path.gulp.task, 'aigis-assets/aigis_config.yml')
#         'confTempFile' : path.join(conf.path.gulp.task, 'aigis-assets/aigis_config.ejs')
#         'param' :
#             'source'          : 'aigis_assets' # aigis_config.ymlからのパス
#             'template_dir'    : 'template_ejs' # aigis_config.ymlからのパス
#             'dest'            : conf.path.out.styleguide
#             'dependencies'    : ['aigis_assets']
#             'template_engine' : 'ejs'
#
#
# conf.temp = {}

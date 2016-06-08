gulp           = require('gulp')
path           = require('path')
conf           = {cwd : process.cwd()}
module.exports = conf
require('./gulp-task/config')
require('./gulp-task/sass')
require('./gulp-task/coffee')
require('./gulp-task/js')
require('./gulp-task/watch')

# ==============================================================================
#
# 設定変更
#
# gulp-task/config.coffeeに記載している全ての設定はここで上書きできます。
#
# ==============================================================================
# JS,CoffeeScriptファイルの結合
# ------------------------------------------------------------------------------
# JSやCoffeeScriptのファイルを結合したい場合は下記コメントアウトを外し編集してください。
#
# JS
#conf.js.concatList =
#    '/common.js' : [
#        path.join(conf.path.in.js,'a.js')
#        path.join(conf.path.in.js,'b.js')
#    ]
#    './parent/child.js' : [
#        path.join(conf.path.in.js,'parent/child/a.js')
#        path.join(conf.path.in.js,'parent/child/b.js')
#    ]

# CoffeeScript
#conf.coffee.concatList =
#   '/common.coffee' : [
#       path.join(conf.path.in.coffee,'common/a.coffee')
#       path.join(conf.path.in.coffee,'common/b.coffee')
#   ]
#    './parent/child.coffee' : [
#        path.join(conf.path.in.coffee,'parent/child/a.coffee')
#        path.join(conf.path.in.coffee,'parent/child/b.coffee')
#    ]

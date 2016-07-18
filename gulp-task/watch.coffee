gulp = require('gulp')
path = require('path')
conf = require('../gulpfile')

gulp.task('watch', ->
    # Sass ---------------------------------------------------------------------
    sassWatch = gulp.watch(conf.watchFile.sass,['sass'])
    # JS -----------------------------------------------------------------------
    jsWatch = gulp.watch(conf.watchFile.js,['js'])
    jsWatch.on('change',(evt)->
        conf.temp.js = { 'changeFile' : evt.path }
        return
    )
    # CoffeeScript -------------------------------------------------------------
    coffeeWatch = if conf.coffee then gulp.watch(conf.watchFile.coffee,['coffee'])
    coffeeWatch.on('change',(evt)->
       conf.temp.coffee = { 'changeFile' : evt.path }
       return
    )
)

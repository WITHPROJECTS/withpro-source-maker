gulp        = require('gulp')
path        = require('path')
plumbler    = require('gulp-plumber')
iconfont    = require('gulp-iconfont')
conf        = require('../gulpfile')
consolidate = require('gulp-consolidate')
rename      = require('gulp-rename')
_           = require('lodash')

# ==============================================================================
# Sassファイル生成用の関数
# ==============================================================================
changeCodepointTo16 = (codepoint)->
    return codepoint.toString(16).toUpperCase()

setFontfaceUrlVal = (changePath, name, ext, format)->
    _path = path.relative(conf.path.out.css,conf.path.out.font)
    if changePath then _path = changePath
    _path = path.join(_path,"#{name}.#{ext}")
    return "url('#{_path}') format('#{format}')"

sassFontPathBuilder = (changePath = false)->
    formats   = conf.iconfont.compileParam.formats
    fontName  = conf.iconfont.compileParam.fontName
    result    = []
    for ext in formats
        if ext is 'ttf'  then result.push(setFontfaceUrlVal(changePath, fontName, ext, 'truetype'))
        if ext is 'woff' then result.push(setFontfaceUrlVal(changePath, fontName, ext, 'woff'))
        if ext is 'svg'  then result.push(setFontfaceUrlVal(changePath, fontName, ext, 'svg'))
    result = result.join()
    return result

# ==============================================================================

gulp.task('iconfont',->
    runTimestamp     = Math.round(Date.now()/1000)
    destDir          = conf.path.out.font
    _conf            = conf.iconfont
    targetFile       = [path.join(conf.path.in.font, '**/*.svg')]
    _param           = _.merge({}, _conf.compileParam)
    _param.timestamp = runTimestamp

    return gulp.src(targetFile)
        .pipe(iconfont(_param))
        .on('glyphs', (glyphs, options)->
            _engine           = 'lodash'
            _templatePath     = _conf.templatePath
            _templateName     = 'fontawesome'
            _consolidateParam =
                'glyphs' : glyphs.map((glyph)-> {
                    'name'      : glyph.name
                    'codepoint' : glyph.unicode[0].charCodeAt(0) }
                )
                'namingRules'         : conf.namingRules
                'fontName'            : _param.fontName
                'fontPath'            : './'
                'className'           : 'iconfont'
                'sassFontPathBuilder' : sassFontPathBuilder
                'changeCodepointTo16' : changeCodepointTo16


            # CSS
            gulp.src(path.join(_templatePath, _templateName+'.css'))
               .pipe(consolidate('swig',_consolidateParam))
               .pipe(rename({ basename : _param.fontName }))
               .pipe(gulp.dest(destDir))
            # Sass
            gulp.src(path.join(_templatePath, _templateName+'.sass'))
               .pipe(consolidate('swig', _consolidateParam))
               .pipe(rename({ basename : _conf.sassFileName }))
               .pipe(gulp.dest(_conf.sassFilePath))
            # HTML
            gulp.src(path.join(_templatePath, _templateName+'.html'))
               .pipe(consolidate('swig',_consolidateParam))
               .pipe(rename({ basename : _param.fontName }))
               .pipe(gulp.dest(destDir))
            return this
        )
        .pipe(gulp.dest(destDir))
)

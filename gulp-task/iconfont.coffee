gulp        = require('gulp')
path        = require('path')
plumbler    = require('gulp-plumber')
iconfont    = require('gulp-iconfont')
conf        = require('../gulpfile')
consolidate = require('gulp-consolidate')
rename      = require('gulp-rename')
_           = require('lodash')

ext2format =
    'woff' : 'woff'
    'ttf'  : 'truetype'
    'svg'  : 'svg'

# ==============================================================================
# Sassファイル生成用の関数
# ==============================================================================
changeCodepointTo16 = (codepoint)->
    return codepoint.toString(16).toUpperCase()

setFontfaceUrlVal = (changePath, name, ext, format)->
    _path = path.relative(path.join(conf.path.out.css, conf.iconfont.sassFilePath), conf.path.out.font)
    if changePath then _path = changePath
    _path = path.join(_path,"#{name}.#{ext}")
    return "url('#{_path}') format('#{format}')"

sassFontPathBuilderSingle = (changePath = false, targetExt)->
    formats  = conf.iconfont.compileParam.formats
    fontName = conf.iconfont.compileParam.fontName
    for ext in formats then if ext is targetExt
        return setFontfaceUrlVal(changePath, fontName, ext, ext2format[ext] )
    return ''

sassFontPathBuilder = (changePath = false)->
    formats   = conf.iconfont.compileParam.formats
    fontName  = conf.iconfont.compileParam.fontName
    result    = []
    for ext in formats
        if ext is 'ttf'  then result.push(setFontfaceUrlVal(changePath, fontName, ext, ext2format[ext] ))
        if ext is 'woff' then result.push(setFontfaceUrlVal(changePath, fontName, ext, ext2format[ext] ))
        if ext is 'svg'  then result.push(setFontfaceUrlVal(changePath, fontName, ext, ext2format[ext] ))
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
            _engine           = 'swig'
            _templatePath     = _conf.templatePath
            _templateName     = 'fontawesome'
            _sassDestPath     = path.join(conf.path.in.sass, _conf.sassFilePath)
            _consolidateParam =
                'glyphs' : glyphs.map((glyph)-> {
                    'name'      : glyph.name
                    'codepoint' : glyph.unicode[0].charCodeAt(0) }
                )
                'namingRules'               : conf.namingRules
                'fontName'                  : _param.fontName
                'fontPath'                  : './'
                'className'                 : 'iconfont'
                'sassFontPathBuilder'       : sassFontPathBuilder
                'sassFontPathBuilderSingle' : sassFontPathBuilderSingle
                'changeCodepointTo16'       : changeCodepointTo16


            # CSS
            gulp.src(path.join(_templatePath, _templateName+'.css'))
               .pipe(consolidate(_engine, _consolidateParam))
               .pipe(rename({ basename : _param.fontName }))
               .pipe(gulp.dest(destDir))
            # Sass
            gulp.src(path.join(_templatePath, _templateName+'.sass'))
               .pipe(consolidate(_engine, _consolidateParam))
               .pipe(rename({ basename : _conf.sassFileName }))
               .pipe(gulp.dest(_sassDestPath))
            # HTML
            gulp.src(path.join(_templatePath, _templateName+'.html'))
               .pipe(consolidate(_engine, _consolidateParam))
               .pipe(rename({ basename : _param.fontName }))
               .pipe(gulp.dest(destDir))
            return this
        )
        .pipe(gulp.dest(destDir))
)

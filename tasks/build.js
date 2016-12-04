let gulp             = require('gulp');
let path             = require('path');
let minimist         = require('minimist');
let gulpTaskRegister = require('./utils/gulp-task-register');
let settingFile      = require(path.join(process.cwd(), 'setting.json'));
let argv             = minimist(process.argv.slice(2));
let type             = argv['t'] || argv['type'] ? argv['t'] || argv['type'] : 'default';

// =============================================================================
// dependency module
// =============================================================================
let gulpSass = require('withpro-gulp-sass');
gulpSass.browsers = settingFile.modules['withpro-gulp-sass'].browsers;

// =============================================================================
// gulp task
// =============================================================================
let gulpBuild = ()=>{
  let modules = [gulpSass];
  let depends = [];
  modules.forEach((key)=> key.path = settingFile.path );
  gulpTaskRegister(modules);
  modules.forEach((obj)=> {
    for(let key in obj.functions) if(/build$/.test(key)) depends.push(key);
  });
  gulp.task('default', depends);
}
// =============================================================================
// default task
// =============================================================================
let build = ()=>{
}

if(type === 'gulp') gulpBuild();
if(type === 'default') build();
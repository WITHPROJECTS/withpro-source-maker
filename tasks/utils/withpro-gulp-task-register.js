let gulp = require("gulp");

let register = (conf)=>{
  let keys = Object.keys(conf.functions);
  keys.forEach((key)=>{
    let f = conf.functions;
    if(Array.isArray(f[key])){
      if(typeof f[key] === 'function'){
        gulp.task(key, f[key][0]);
      }else{
        gulp.task(key, f[key][0], f[key][1]);
      }
    }else{
      gulp.task(key, f[key]);
    }
  });
}

module.exports = function(modules){
  modules.forEach((obj)=> register(obj) );
}
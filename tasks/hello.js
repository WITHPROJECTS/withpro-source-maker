let fs          = require("fs-extra");
let path        = require("path");
let colors      = require("colors");
let inquirer    = require("inquirer");
let spawn       = require('child-process-promise').spawn;
let exec        = require('child-process-promise').exec;
let myPackage   = require("../package.json");
let settingFile = require("../setting.json");
let tasksData   = settingFile.modules;
let prompt      = inquirer.createPromptModule();
let tasks       = [];
let result      = [];
let debug       = true;

// /////////////////////////////////////////////////////////////////////////////
//
// Add packages
//
// /////////////////////////////////////////////////////////////////////////////

if(settingFile.init) return false;
settingFile.init = true;

tasksData.forEach((obj)=>{
    obj.version    = typeof obj.version === 'undefined' ? 'latest' : obj.version;
    obj.promptName = typeof obj.promptName === 'undefined' ? obj.name : obj.promptName;
});

console.log(`
===========================================
WITHRPO SOURCE MAKER SETTING.
===========================================
`);

// =============================================================================
// START
// =============================================================================
let start = ()=>{
    tasks = [];
    tasksData.forEach((obj, i)=> tasks.push(obj.promptName) );
    prompt({
        'type'     : 'checkbox',
        'name'     : 'tasks',
        'message'  : 'Use tasks',
        'choices'  : tasks,
        'default'  : false
    }).then(iputTheVersion);
}

// =============================================================================
// input the version that want.
// =============================================================================
let iputTheVersion = (answer)=>{
    if(!answer.tasks.length){
        console.log('noting install'.red.bold);
        return false;
    }
    answer = answer.tasks;
    result = [];
    let q  = [];
    tasksData.forEach((obj, i)=>{
        for(let i = 0, l = answer.length; i < l; i++){
            if(answer[i] === obj.promptName){
                q.push({
                    'type'    : `input`,
                    'name'    : `${obj.name}`,
                    'message' : `${obj.name} version (default -> ${obj.version})`,
                    'filter'  : ((obj)=>{
                        return (val)=>{
                            val = !val ? obj.version : val;
                            obj.version = val;
                            return val;
                        }
                    })(obj)
                });
                result.push(obj);
                break;
            }
        }
    });
    prompt(q).then(confirmation);
}

// =============================================================================
// confirmation
// =============================================================================
let confirmation = (answer)=>{
    console.log('------', 'Install module list'.bold, '------');
    result.forEach((obj)=>{
        console.log(`・${obj.name}`.bold, `:`, `version ${obj.version}`);
    });
    console.log('---------------------------------');
    prompt({
        'type'    : 'list',
        'name'    : 'confirmation',
        'message' : 'OK?',
        'choices' : [
            'ok',
            'redo'
        ],
    }).then((answer)=>{
        answer = answer.confirmation;
        if(answer === 'redo'){
            console.log('\n');
            start();
        }else{
            install();
        }
    });
}

// =============================================================================
// install
// =============================================================================
let install = ()=>{
    let i          = 0;
    let l          = result.length;
    let promise    = null;
    let installErr = 0;
    let set = ()=>{
        promise = npmInstall(result[i]);
        promise
            .then(((obj)=>{
                return (result)=>{
                    console.log(`-> ${obj.name} installed.`);
                    if(i >= l){
                        end();
                    }else{
                        set();
                        i++;
                    }
                }
            })(result[i]))
            .catch(((obj)=>{
                return (err)=>{
                    console.log(`-> ${obj.name} failed.\n`.red);
                    installErr++;
                    if(i >= l){
                        end();
                    }else{
                        set();
                        i++;
                    }
                }
            })(result[i]));
        promise.childProcess.stderr.on('data', (data)=>{
            console.log('[spawn] stderr: ', data.toString());
        });
    }
    let end = ()=>{
        if(installErr){
            console.log(`process is all done. but ${installErr} package fail to install.\nthus, not overwrite setting.json.`.red);
        }else{
            console.log(`process is all done.`.green);
            settingFile.init = true;
            fs.writeFile(path.join(__dirname, '../setting.json'), JSON.stringify(settingFile, null, 2));
        }
    }
    set();
    i++;
}

let npmInstall = (obj)=>{
    console.log(`${obj.name} install...\n`);
    if(!obj.git){
        return spawn(`npm`, [`i`, `-D`, `${obj.name}@${obj.version}`]);
    }else{
        if(obj.version === 'latest'){
            return spawn(`npm`, [`i`, `-D`, `${obj.git}`]);
        }else{
            return spawn(`npm`, [`i`, `-D`, `${obj.git}#${obj.version}`]);
        }
    }
}

// =============================================================================

start();

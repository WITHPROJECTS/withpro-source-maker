let colors    = require("colors");
let inquirer  = require("inquirer");
// let spawn     = require('child-process-promise').spawn;
let spawn     = require('child_process').spawn;
let exec      = require('child_process').exec;
let myPackage = require("../package.json");
let state     = require("./state.json");
let tasksData = require("./list.json");
let prompt    = inquirer.createPromptModule();
let tasks     = [];
let result    = [];

if(state.init) return false;
state.init = true;

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
    console.log('  ↓');
    answer = answer.tasks;
    result = [];
    let q  = [];
    tasksData.forEach((obj, i)=>{
        for(let i = 0, l = answer.length; i < l; i++){
            if(answer[i] === obj.promptName){
                q.push({
                    'type'    : `input`,
                    'name'    : `${obj.name}`,
                    'message' : `${obj.name} version (default -> ${obj.defaultVersion})`,
                    'filter'  : ((obj)=>{
                        return (val)=>{
                            val = !val ? obj.defaultVersion : val;
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
    console.log('  ↓');
    console.log('------ Install module list ------\n');
    result.forEach((obj)=>{
        console.log(`${obj.name} -> version ${obj.version}`);
    });
    console.log('\n---------------------------------');
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
    // console.log(result);
    result.forEach((obj)=>{
        if(!obj.git){
            let a = exec(`npm i -D ${obj.name}@${obj.version}`);
            console.log(a);
            // a.stdout.on('data', function(data){
            //     console.log(data);
            // });
            // console.log(a);
            // let a = spawn('npm', ['i', '-D', `${obj.name}@${obj.version}`]);
            // console.log(a);
            // a.on('finish', function(data){
            //     console.log(data);
            // });
            // console.dir(a.);
            // let child   = promise.childProcess;
            // console.log(child.stdin);
            // spawn.on('message', function(data){
            //     console.log(data);
            // });
            // console.log(childProcess);
            // childProcess.stdout.on('data', function (data) {
            //     console.log('[spawn] stdout: ', data.toString());
            // });
            // spawn(`npm i -D ${obj.name}@${obj.version}`).then((result)=>{
            //     console.log('ok');
            // });
        }
    });
}

// =============================================================================

start();

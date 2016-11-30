let inquirer  = require("inquirer");
let myPackage = require("../package.json");
let state     = require("./state.json");
let tasksData = require("./list.json");
let prompt    = inquirer.createPromptModule();
let qArr      = [];

if(state.init) return false;
state.init = true;

console.log(`
===========================================
WITHRPO SOURCE MAKER SETTING.
===========================================
`);

// =============================================================================
// input the version that want.
// =============================================================================
let iputTheVersion = (answer)=>{
    if(answer.length === 0) return false;
    answer = answer.tasks;
    result = [];
    tasksData.forEach((obj, i)=>{
        for(let i = 0, l = answer.length; i < l; i++){
            if(answer[i] === obj.promptName){
                result.push(obj);
                break;
            }
        }
    });

    console.log(result);
}

// =============================================================================
// START
// =============================================================================
let tasks = [];
tasksData.forEach((obj, i)=> tasks.push(obj.promptName) );
prompt({
    'type'    : 'checkbox',
    'name'    : 'tasks',
    'message' : 'Which the Tasks that to use?\n',
    'choices' : tasks
}).then(iputTheVersion);

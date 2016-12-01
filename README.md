Build up website developping environment in the form of interactive command line.

# Goal

More simply.

# Usage

1. Open tasks/list.json at editor.
2. Write your needed packages into tasks/list.json.
3. Run [ **npm i** ] command at prompt.

## tasks/list.json

| Key        | Value Type | defaultValue | Description                     |
|------------|------------|--------------|---------------------------------|
| name       | string     |              | package name                    |
| git        | string     |              | git repository. if you want it. |
| version    | string     | "latest"     | package version                 |
| promptName | string     | name         | on prompt package name          |

### tasks/list.json For example.

```js
// from npm
[
    {
        "name" : "withpro-gulp-sass"
    },
    {
        "name"    : "withpro-gulp-js",
        "version" : "2.0.0"
    }
]

// from Github
[
    {
        "name" : "withpro-gulp-sass",
        "git"  : "git+ssh://git@github.com:WITHPROJECTS/withpro-gulp-sass.git"
    }
]

```

git property format is [npm install doc.](https://docs.npmjs.com/cli/install).


First time only, After install packages ( **npm i** command ), run tasks/hello.js and start to build up website developping environment. Also package.json is edited it that to add packages.  
Then, "init" property of tasks/state.json is changed to **true**. By this, After the second time, not run tasks/hello.js.

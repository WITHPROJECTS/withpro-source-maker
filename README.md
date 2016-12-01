Build up website developping environment in the form of interactive command line.

# How and Why

# Usage

```
$ npm i
```

First time only, After install packages, run tasks/hello.js and start to build up website developping environment.
And package.json is edited it that to add packages.
Then, "init" property of state.json is changed to **true**.
By this, After the second time, not run tasks/hello.js.

tasks/list.json

| Key        | Value Description               | Value Type | defaultValue |
|------------|---------------------------------|------------|--------------|
| name       | package name                    | string     |              |
| git        | git repository. if you want it. | string     |              |
| version    | package version                 | string     | "latest"     |
| promptName | on prompt package name          | string     | name         |

if you order git repository. check **npm install** doc.
https://docs.npmjs.com/cli/install

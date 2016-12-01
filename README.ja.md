WEBサイト制作環境を対話型で構築します。

# 目標

よりシンプルに

# 使い方

1. tasks/list.jsonをエディターで開きます。
2. tasks/list.jsonに必要なパッケージを記述します。
3. ターミナルで[ **npm i** ]コマンドを実行します。

## tasks/list.json

| キー       | 型     | 初期値   | 説明                        |
|------------|--------|----------|-----------------------------|
| name       | string |          | パッケージ名                |
| git        | string |          | gitリポジトリ(必要であれば) |
| version    | string | "latest" | パッケージのバージョン      |
| promptName | string | name     | ターミナル上で表示する名前  |

### tasks/list.jsonの記述例

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

**npm i** コマンドでパッケージのインストールした後、初回のみtasks/hello.jsが走り、WEBサイト開発環境の構築を行います。  
その際に、package.jsonにパッケージを追記し、tasks/state.jsonの"init"プロパティが **true** になります。  
そのため、2回目以降の **npm i** ではtasks/hello.jsは実行されません。

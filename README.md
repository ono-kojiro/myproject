# myproject

## Gitインストール

### アーカイブ展開
`PortableGit-2.39.1-64-bit.7z.exe` を実行し、ファイルを展開。
`PortableGit` フォルダが作成されるので、`PortableGit-2.39.1-64-bit` にリネームし、`C:\opt\` に配置する。

### 鍵ペア作成
`PortableGit` に含まれている `git-bash.exe` を起動。

```
   ssh-keygen -t ed25519
```

生成した `id_ed25519とid_ed25519.pub` を `/etc/ssh` に配置。

`/etc/ssh/ssh_config` に以下を追記

```
Host 192.168.0.XX
    StrictHostKeyChecking no
	IdentityFile /etc/ssh/ip_ed25519
```

### 公開鍵登録
`id_ed25519.pub` の内容をGitサーバに登録する。

## Manage Credentials
不要

## Create Jenkins Pipeline

ダッシュボード -> Jenkinsの管理 -> プラグインの管理

### プラグインのインストール
Available plugins で 以下のプラグインを選択しインストールする。

   | プラグイン名          | 用途                      |
   |----------------------|---------------------------|
   | Pipeline: Job        | Pipelineジョブを追加       |
   | Pipeline: Declarative| Jenkinsスクリプトを利用する |
   | Pipeline: Stage View | Pipelineのステージを可視化  |
   | Git                  | Gitリポジトリを扱う         |
   | SSH Build Agents Plugin | SSH経由でAgentをインストール、ビルド|
   

### Global Tool Configuration

  名前: Default
  Git実行形式へのパス: C:\opt\PortableGit-2.39.1-64-bit\bin\git.exe


Saveボタンを押す

### Pipeline作成

新規ジョブ作成 -> パイプライン を選択

パイプライン -> 定義
Pipeline script from SCMを選択

SCM : Gitを選択
リポジトリURL : Jenkinsfileを格納しているリポジトリを入力

認証情報　の "+追加" ボタンを押し、"Jenkins" をクリック。

  - Domain: グローバルドメイン を選択
  - 種類: SSHユーザー名と秘密鍵 を選択
  - スコープ: グローバル を選択
  - ID: 任意
  - 説明: 任意
  - ユーザー名: ssh公開鍵のユーザー名
  - 秘密鍵:
　   直接入力を選択、Addボタンを押し、
     Gitサーバに登録済みのssh公開鍵とペアになるssh秘密鍵をテキストで貼り付ける。

秘密鍵は以下のように確認する。
```
   $ less ~/.ssh/id_ed25519
```


秘密鍵を登録後、リポジトリ設定の画面に戻るので、
認証情報が"なし" になっている欄を、先ほど登録したユーザー名に変更する。

# インターネットTVのデータベースの概要

好きな時間に好きな場所で話題の動画を無料で楽しめるインターネットTVサービスを想定してデータベース設計を行いました。

## STEP1：テーブル定義


### channel_programs
　channnelsテーブルとprogramsテーブルから外部キー制約を受けて、放送スケジュールを登録するテーブル。　

| カムラ名  | データ型   | Null | Key | 初期値 | AI |
|:---------|:---------|:-----:|:-----:|:----|:----:|
| id         | int      | NO   | PRI | NULL    | auto_increment |
| channel_id | int      | NO   | MUL | NULL    |                |
| episode_id | int      | NO   | MUL | NULL    |                |
| start_time | datetime | NO   |     | NULL    |                |
| end_time   | datetime | NO   |     | NULL    |                |
| views      | int      | YES  |     | NULL    |                |

**外部キー制約**<br>
- channel_programs.channel_id -> channels.id
- channel_programs.episode_id -> episodes.id

### channels
　チャンネル名を管理するテーブル。

| カムラ名  | データ型   | Null | Key | 初期値 | AI |
|:---------|:---------|:-----:|:-----:|:----|:----:|
| id    | int          | NO   | PRI | NULL    | auto_increment |
| name  | varchar(100) | NO   |     | NULL    |                |


### episodes
　作品の詳細情報が確認できるテーブル。単発映画、連続エピソードの両方を管理している。
seasonsテーブルから外部キー制約を受けている。

| カムラ名  | データ型   | Null | Key | 初期値 | AI |
|:---------|:---------|:-----:|:-----:|:----|:----:|
| id             | int          | NO   | PRI | NULL    | auto_increment |
| season_id      | int          | YES  | MUL | NULL    |                |
| episode_number | int          | YES  |     | NULL    |                |
| title          | varchar(255) | NO   |     | NULL    |                |
| description    | text         | YES  |     | NULL    |                |
| duration_min   | int          | NO   |     | NULL    |                |
| release_date   | date         | YES  |     | NULL    |                |
| views          | int          | YES  |     | NULL    |                |
| is_singleEp    | tinyint(1)   | NO   |     | 0       |                |

**外部キー制約**<br>
- episodes.season_id -> seasons.id

### genres
　アニメ、ドラマ、映画、ニュースのジャンルを登録したテーブル。
チャンネルテーブル、エピソードテーブル両方の外部キーとなっている。

| カムラ名  | データ型   | Null | Key | 初期値 | AI |
|:---------|:---------|:-----:|:-----:|:----|:----:|
| id    | int          | NO   | PRI | NULL    | auto_increment |
| name  | varchar(100) | NO   |     | NULL    |                |


### seasons
シーズン番号を管理するテーブル。programsテーブルから外部キー制約を受けている。

| カムラ名  | データ型   | Null | Key | 初期値 | AI |
|:---------|:---------|:-----:|:-----:|:----|:----:|
| id            | int  | NO   | PRI | NULL    | auto_increment |
| program_id    | int  | NO   | MUL | NULL    |                |
| season_number | int  | YES  |     | NULL    |                |

#**外部キー制約**<br>
- seasons.program_id -> programs.id


### program_genres
programsテーブルとgenreテーブルの中間テーブルとなっている。

| カムラ名  | データ型   | Null | Key | 初期値 | AI |
|:---------|:---------|:-----:|:-----:|:----|:----:|
| id         | int  | NO   | PRI | NULL    | auto_increment |
| program_id | int  | NO   | MUL | NULL    |                |
| genre_id   | int  | NO   | MUL | NULL    |                |

外部キー制約:
    program_genres.program_id -> programs.id
    programs.genre_id -> genres.id

### programs
作品のメインタイトルを管理するテーブル。

| カムラ名  | データ型   | Null | Key | 初期値 | AI |
|:---------|:---------|:-----:|:-----:|:----|:----:|
| id    | int          | NO   | PRI | NULL    | auto_increment |
| title | varchar(255) | NO   |     | NULL    |                |



## STEP2：データの入力
ディレクトリ内の[CREATE.sql](https://github.com/mako-agawa/db-sql-internetTv/blob/main/CREATE.sql)からコードを実行するとテーブルが作られます。<br>ディレクトリ内の[INSERT.sql](https://github.com/mako-agawa/db-sql-internetTv/blob/main/INSERT.sql)から実施するとデータが入力されます。

## STEP3：データの入力
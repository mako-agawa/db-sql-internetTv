# インターネットTVのデータベースの概要

好きな時間に好きな場所で話題の動画を無料で楽しめるインターネットTVサービスを想定してデータベース設計を行いました。

## STEP1：テーブル定義

### channel_programs
　channnelsテーブルとprogramsテーブルから外部キー制約を受けて、放送スケジュールを登録するテーブル。　

| カムラ名  | データ型   | Null | Key | 初期値 | AI |
|:---------|:---------|:-----:|:-----:|:----|:----:|
| id         | int      | NO   | PRI | NULL    | YES |
| channel_id | int      | NO   | MUL | NULL    |                |
| episode_id | int      | NO   | MUL | NULL    |                |
| start_time | datetime | NO   |     | NULL    |                |
| end_time   | datetime | NO   |     | NULL    |                |
| views      | int      | YES  |     | NULL    |                |

**外部キー制約**<br>
- channel_programs.channel_id -> channels.id
- channel_programs.episode_id -> episodes.id

<br>

### channels
　チャンネル名を管理するテーブル。

| カムラ名  | データ型   | Null | Key | 初期値 | AI |
|:---------|:---------|:-----:|:-----:|:----|:----:|
| id    | int          | NO   | PRI | NULL    | YES |
| name  | varchar(100) | NO   |     | NULL    |                |

<br>

### episodes
　作品の詳細情報が確認できるテーブル。単発映画、連続エピソードの両方を管理している。
seasonsテーブルから外部キー制約を受けている。

| カムラ名  | データ型   | Null | Key | 初期値 | AI |
|:---------|:---------|:-----:|:-----:|:----|:----:|
| id             | int          | NO   | PRI | NULL    | YES |
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

<br>

### genres
　アニメ、ドラマ、映画、ニュースのジャンルを登録したテーブル。
チャンネルテーブル、エピソードテーブル両方の外部キーとなっている。

| カムラ名  | データ型   | Null | Key | 初期値 | AI |
|:---------|:---------|:-----:|:-----:|:----|:----:|
| id    | int          | NO   | PRI | NULL    | YES |
| name  | varchar(100) | NO   |     | NULL    |                |

<br>

### seasons
シーズン番号を管理するテーブル。programsテーブルから外部キー制約を受けている。

| カムラ名  | データ型   | Null | Key | 初期値 | AI |
|:---------|:---------|:-----:|:-----:|:----|:----:|
| id            | int  | NO   | PRI | NULL    | YES |
| program_id    | int  | NO   | MUL | NULL    |                |
| season_number | int  | YES  |     | NULL    |                |

**外部キー制約**<br>
- seasons.program_id -> programs.id

<br>

### program_genres
programsテーブルとgenreテーブルの中間テーブルとなっている。

| カムラ名  | データ型   | Null | Key | 初期値 | AI |
|:---------|:---------|:-----:|:-----:|:----|:----:|
| id         | int  | NO   | PRI | NULL    | YES |
| program_id | int  | NO   | MUL | NULL    |                |
| genre_id   | int  | NO   | MUL | NULL    |                |

**外部キー制約**<br>
- program_genres.program_id -> programs.id
- programs.genre_id -> genres.id

<br>

### programs
作品のメインタイトルを管理するテーブル。

| カムラ名  | データ型   | Null | Key | 初期値 | AI |
|:---------|:---------|:-----:|:-----:|:----|:----:|
| id    | int          | NO   | PRI | NULL    | YES |
| title | varchar(255) | NO   |     | NULL    |                |

<br>


## STEP2：テーブル作成とデータの入力
1. ディレクトリ内の[CREATE.sql](https://github.com/mako-agawa/db-sql-internetTv/blob/main/CREATE.sql)からコードを実行するとテーブルが作られます。
2. ディレクトリ内の[INSERT.sql](https://github.com/mako-agawa/db-sql-internetTv/blob/main/INSERT.sql)から実施するとデータが入力されます。

<br>

## STEP3：データを抽出する

1. よく見られているエピソードを知りたいです。エピソード視聴数トップ3のエピソードタイトルと視聴数を取得してください
```SQL
SELECT title, views 
  FROM episodes 
 ORDER BY views DESC 
 LIMIT 3;
```
<br>

2. よく見られているエピソードの番組情報やシーズン情報も合わせて知りたいです。エピソード視聴数トップ3の番組タイトル、シーズン数、エピソード数、エピソードタイトル、視聴数を取得してください
```SQL
SELECT p.title AS program_title, s.season_number, e.episode_number, e.title AS episode_title, e.views
  FROM episodes e
  JOIN seasons s ON e.season_id = s.id
  JOIN programs p ON s.program_id = p.id
 ORDER BY e.views DESC
 LIMIT 3;
```
<br>

3. 本日の番組表を表示するために、本日、どのチャンネルの、何時から、何の番組が放送されるのかを知りたいです。本日放送される全ての番組に対して、チャンネル名、放送開始時刻(日付+時間)、放送終了時刻、シーズン数、エピソード数、エピソードタイトル、エピソード詳細を取得してください。なお、番組の開始時刻が本日のものを本日方法される番組とみなすものとします
```SQL
SELECT c.name AS channel_name, cp.start_time, cp.end_time, s.season_number, e.episode_number, e.title AS episode_title, e.description AS episode_description
  FROM channel_programs cp
  JOIN channels c ON cp.channel_id = c.id
  JOIN episodes e ON cp.episode_id = e.id
  JOIN seasons s ON e.season_id = s.id
 WHERE DATE(cp.start_time) = CURDATE();
```
<br>

4. ドラマというチャンネルがあったとして、ドラマのチャンネルの番組表を表示するために、本日から一週間分、何日の何時から何の番組が放送されるのかを知りたいです。ドラマのチャンネルに対して、放送開始時刻、放送終了時刻、シーズン数、エピソード数、エピソードタイトル、エピソード詳細を本日から一週間分取得してください
```SQL
SELECT c.name AS channel_name, cp.start_time, cp.end_time, s.season_number, e.episode_number, e.title AS episode_title, e.description AS episode_description
  FROM channel_programs cp
  JOIN channels c ON cp.channel_id = c.id
  JOIN episodes e ON cp.episode_id = e.id
  JOIN seasons s ON e.season_id = s.id
 WHERE c.name = 'ワンデイドラマ' 
   AND cp.start_time BETWEEN "2024-08-01 08:00:00" AND DATE_ADD(CURDATE(), INTERVAL 7 DAY)
 ORDER BY cp.start_time;
```
<br>

5. (advanced) 直近一週間で最も見られた番組が知りたいです。直近一週間に放送された番組の中で、エピソード視聴数合計トップ2の番組に対して、番組タイトル、視聴数を取得してください
6. (advanced) ジャンルごとの番組の視聴数ランキングを知りたいです。番組の視聴数ランキングはエピソードの平均視聴数ランキングとします。ジャンルごとに視聴数トップの番組に対して、ジャンル名、番組タイトル、エピソード平均視聴数を取得してください。

# インターネットTVのデータベースの概要


## STEP1：テーブル定義


### channel_programs
| カムラ名  | データ型   | Null | Key | 初期値 | AI |
|:---------|:---------|:-----:|:-----:|:----|:----:|
| id         | int      | NO   | PRI | NULL    | auto_increment |
| channel_id | int      | NO   | MUL | NULL    |                |
| episode_id | int      | NO   | MUL | NULL    |                |
| start_time | datetime | NO   |     | NULL    |                |
| end_time   | datetime | NO   |     | NULL    |                |
| views      | int      | YES  |     | NULL    |                |

### channels
| カムラ名  | データ型   | Null | Key | 初期値 | AI |
|:---------|:---------|:-----:|:-----:|:----|:----:|
| id    | int          | NO   | PRI | NULL    | auto_increment |
| name  | varchar(100) | NO   |     | NULL    |                |


### episodes
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


### genres
| カムラ名  | データ型   | Null | Key | 初期値 | AI |
|:---------|:---------|:-----:|:-----:|:----|:----:|
| id    | int          | NO   | PRI | NULL    | auto_increment |
| name  | varchar(100) | NO   |     | NULL    |                |


### seasons
| カムラ名  | データ型   | Null | Key | 初期値 | AI |
|:---------|:---------|:-----:|:-----:|:----|:----:|
| id            | int  | NO   | PRI | NULL    | auto_increment |
| program_id    | int  | NO   | MUL | NULL    |                |
| season_number | int  | YES  |     | NULL    |                |


### program_genres
| カムラ名  | データ型   | Null | Key | 初期値 | AI |
|:---------|:---------|:-----:|:-----:|:----|:----:|
| id         | int  | NO   | PRI | NULL    | auto_increment |
| program_id | int  | NO   | MUL | NULL    |                |
| genre_id   | int  | NO   | MUL | NULL    |                |


### programs
| カムラ名  | データ型   | Null | Key | 初期値 | AI |
|:---------|:---------|:-----:|:-----:|:----|:----:|
| id    | int          | NO   | PRI | NULL    | auto_increment |
| title | varchar(255) | NO   |     | NULL    |                |



## STEP2：データの入力
    
    ディレクトリ内のCREATE.sqlから実施するとテーブルが作られます。
    ディレクトリ内のINSERT.sqlから実施するとデータが入力されます。

## STEP2：データの入力
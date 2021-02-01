# テーブル設計

## users テーブル

| Column     | Type   | Options  |
| ---------- | ------ | -------- |
| email      | string | NOT NULL |
| password   | string | NOT NULL |
| name       | string | NOT NULL |
| profile    | text   | NOT NULL |
| occupation | text   | NOT NULL |
| position   | text   | NOT NULL |

### Association

- has_many :prototypes
- has_many :comments

## prototypesテーブル

| Column     | Type               | Options  |
| ---------- | ------------------ | -------- |
| title      | string             | NOT NULL |
| catch_copy | text               | NOT NULL |
| concept    | text               | NOT NULL |
| user_id    | references         |          |

### Association

- belongs_to :user
- has_many :comment


## commentsテーブル

| Column    | Type       | Options  |
| --------- | ---------- | -------- |
| text      | text       | NOT NULL |
| user_id   | references |          |
| prototype | references |          |

### Association

- belongs_to :prototype
- belongs_to :user
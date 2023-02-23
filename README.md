# README

This README would normally document whatever steps are necessary to get the
application up and running.

Things you may want to cover:

* Ruby version

* System dependencies

* Configuration

* Database creation

* Database initialization

* How to run the test suite

* Services (job queues, cache servers, search engines, etc.)

* Deployment instructions


# アノテーションの活用

```
docker exec -it CONTAINER_ID bash
rails notes

# Usage:
#   rails notes [options]
#
# Options:
#   -a, [--annotations=one two three]  # Filter by specific annotations, e.g. Foobar TODO
```
キーワード | 内容
--- | ---
TODO | 後日追加が必要な、不足の機能
FIXME |	修正の必要な箇所
OPTIMIZE | パフォーマンス低下の原因となる箇所
HACK | リファクタリングの必要なマズいコード
REVIEW | 意図したとおりに動くかどうかチェックが必要
OTHER | 必要ならキーワードを足してもよいが、READMEでキーワードを説明すること

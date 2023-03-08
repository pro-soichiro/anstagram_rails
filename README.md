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

# 初期環境構築方法
1. git clone
2. .envの作成と必要事項の記述
3. docker-compose build
4. docker-compose run --rm web bin/rails db:setup
5. docker-compose up

setupコマンドは「データベースの作成」「スキーマの読み込み」「seedデータを用いたデータベースの初期化」をまとめて実行します。

アプリケーションのデータベースの新しいインスタンスを作成する場合、マイグレーションの全履歴を最初から繰り返すよりも、
単にrails db:schema:loadでスキーマファイルを読み込む方が、高速かつエラーが起きにくい傾向があります。

詳細は[Railsガイド](https://railsguides.jp/active_record_migrations.html#%E3%83%87%E3%83%BC%E3%82%BF%E3%83%99%E3%83%BC%E3%82%B9%E3%82%92%E8%A8%AD%E5%AE%9A%E3%81%99%E3%82%8B)を参照してください。


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

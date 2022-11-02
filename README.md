# isucon12-q-revenge
ISUCON 12 予選の復習をしています。使用言語はPythonです。

`main`ブランチは1台構成、`multiserver-arch`ブランチは2台構成になっています。

## 環境
- 競技者用サーバー: c6i.large
- ベンチマーカー用サーバー: c6i.xlarge

## 時系列
スコアの計測はかなり適当です。1回しか測っていなかったり、計測によってログを切る切らないを変えていたりします。

- 初期実装をPythonに変更 (Score: 1910, [939259d](https://github.com/maroyakachar/isucon12-q-revenge/commit/939259d973ece0cb1b39df30ad381eff5ac36c81))
- `visit_history`の列`tenant_id`, `competition_id`, `player_id`, `created_at`に対してインデックスを作成する (Score: 2443)
- アプリ全体で使われるIDとしてUUIDを使う (Score: 2491, [dd918cf](https://github.com/maroyakachar/isucon12-q-revenge/commit/dd918cf001323bbff44b432abb084c4110d38121))
- flockをスコアを更新するときのものを除いてすべて取り除く (Score: 2605, [b08d2a3](https://github.com/maroyakachar/isucon12-q-revenge/commit/b08d2a34cb5da382f0ccb6c5b0919b0913f163ae))
- ランキングを生成する処理にあるN+1を取り除く (Score: 3175, [01f3efc](https://github.com/maroyakachar/isucon12-q-revenge/commit/01f3efc9ffd8db72b1024a23efa750a3c4e037c9))
- `/api/organizer/competition/<competition_id>/score`で1プレイヤー1スコアにする (Score: 3390, [3970bc1](https://github.com/maroyakachar/isucon12-q-revenge/commit/3970bc1f2f4356d18b23a9660fba9ab19245bee7))
- 2つ前のコードが間違っていたので修正 (Score: 3551, [9002148](https://github.com/maroyakachar/isucon12-q-revenge/commit/90021482e4bb892094d70a4f033c74c918af0ac1))
- プレイヤーのスコア一覧を取得する処理にあるN+1を取り除く (Score: 4257, [d42ccbc](https://github.com/maroyakachar/isucon12-q-revenge/commit/d42ccbc3db31b713b1bf5be1fa386d73ec7dd2eb))
- `initial_data/`でも1プレイヤー1スコアにする (Score: 5184, [13b09d5](https://github.com/maroyakachar/isucon12-q-revenge/commit/13b09d54e3dd4451804645dcc23643a063356cf9))
- ランキングを生成する処理にある`INNER JOIN`をひとつ減らす (Score: 5524, [1a4328f](https://github.com/maroyakachar/isucon12-q-revenge/commit/1a4328f9d8717a6a947f0ab571da1eb8f14b07ec))
  + ここまでの変更で`player_score`には大会、プレイヤーの組に対して高々1つのスコアしかないようにできたので、複数のスコアの中から1つ選ぶための`INNER JOIN`を減らせました
- プレイヤーの順位を前もって計算する (Score: 5761, [ca76cee](https://github.com/maroyakachar/isucon12-q-revenge/commit/ca76cee059857fd657f33d184132bdab5c675b95))
- SQLiteのログを解析するツールを作る (Score: -, [fd90a0c](https://github.com/maroyakachar/isucon12-q-revenge/commit/fd90a0cf59f2abf59f49eaa313ebee226c7c4929))
  + dsqのようなツールがあるのを知らなかったので自作しました
- スコアの追加にbulk insertを使う (Score: 6404, [16a9acc](https://github.com/maroyakachar/isucon12-q-revenge/commit/16a9acc8cd5d3aa5244bc8e9ca14f9111798aac8))
- `LIMIT`句を使ってランキング全体のうち要求されている部分だけをデータベースから取得する (Score: 6728, [31848c3](https://github.com/maroyakachar/isucon12-q-revenge/commit/31848c3f62eed3b078d49e0017a97dac756dbb43))
- `SELECT player_id, MIN(created_at) AS min_created_at FROM visit_history WHERE tenant_id = %s AND competition_id = %s GROUP BY player_id`を高速化する (Score: 7325, [522ee94](https://github.com/maroyakachar/isucon12-q-revenge/commit/522ee94f724beec5ec2d37309d2b0ec8331e4e1d))
  + `player_score`と同様に`visit_history`でも1プレイヤー1履歴にして、`GROUP BY`や`MIN`をなくしました
- uwsgiを使って複数のワーカーを走らせる (Score: 9734, [329b227](https://github.com/maroyakachar/isucon12-q-revenge/commit/329b22774c8ec8bc4e9d924529cf8b7e3bfbf450))
- このあたりで解説をちゃんと読みました
- 最後のflockをトランザクションで置き換える (Score: 10286, [a58a971](https://github.com/maroyakachar/isucon12-q-revenge/commit/a58a971587effed3526e23818dbf035e4ab334f4))
- 大会終了前の課金レポートを適当に返す (Score: ?, [753d4e7](https://github.com/maroyakachar/isucon12-q-revenge/commit/753d4e7f318314606e424d660b91c2e516197cf2))
- プレイヤー情報をキャッシュする (Score: 10294, [afc7fbf](https://github.com/maroyakachar/isucon12-q-revenge/commit/afc7fbfea7a9c9d825d51234aaddbdfec370833d))
- プレイヤーの追加にbulk insertを用いる (Score: 13387, [ad5b177](https://github.com/maroyakachar/isucon12-q-revenge/commit/ad5b1775191d7b13d7c00a759dd2ac265e6017e2))
- ランキングをキャッシュする (Score: 13788, [8df1e3a](https://github.com/maroyakachar/isucon12-q-revenge/commit/8df1e3ac67ae932f6efe390b51009a9b158625c3))
- 課金レポートをキャッシュする (Score: 15231, [6160649](https://github.com/maroyakachar/isucon12-q-revenge/commit/61606494d9d0915e9e7d987c64e566e22f87b89c))
- このあたりからエラーが増えてきた
- `/api/player/player/<player_id>`のSQL文を改善 (Score: 16600, [232ba46](https://github.com/maroyakachar/isucon12-q-revenge/commit/232ba46e5a1793f20db44ac39b4dd4388d8fe899))
- ワーカーを6個に増やす (Score: 15925, [e3af125](https://github.com/maroyakachar/isucon12-q-revenge/commit/e3af125ec21fca1046f3b99e86f84e762c870527))
  + エラーは減らなかった
- 大会情報をキャッシュする (Score: 16446, [cdfd4c5](https://github.com/maroyakachar/isucon12-q-revenge/commit/cdfd4c5fd2b617649d700f87c9b0127b0bf1525c))
- 複数のプレイヤーの存在判定を1回のクエリで行う (Score: 19669, [3a992a8](https://github.com/maroyakachar/isucon12-q-revenge/commit/3a992a872b5b35f8fe2d590c039281654ee77bf4))
- ランキング作成に使うSQL文を改善 (Score: 19836, [dc6bf35](https://github.com/maroyakachar/isucon12-q-revenge/commit/dc6bf3570b6d9a98e1fc4dbb79696359508da128))
- `/api/organizer/players`のSQL文を高速化するためにインデックスを作成 (Score: 12414, [ca3f2aa](https://github.com/maroyakachar/isucon12-q-revenge/commit/ca3f2aaa86f82168c76916d0d5afbede06a64c60))
- listen queueを大きくする (Score: 20398, [addafb0](https://github.com/maroyakachar/isucon12-q-revenge/commit/addafb0dad30260fdd45838603b1b40bf6780d9f))
  + エラーがなくなり安定するようになった
- このあたりで[ISUCON12 予選の解説 (Node.jsでSQLiteのまま10万点行く方法)](https://isucon.net/archives/56842718.html)を読みました
- サーバー2台構成に変更 (Score: 28427, [2e87ab3](https://github.com/maroyakachar/isucon12-q-revenge/commit/2e87ab3eb323959d8b099a40cc35590b625bb2be))
  + 解説と同じように名前の長さでテナントを2つのサーバーに分けました
  + 1台目: App + Nginx + Redis、2台目: App + MySQL + Redis

## 張ったインデックスが`/initialize`によって消されないか
`/initialize`のハンドラの中身を見ると、`webapp/sql/init.sh`が実行されていることが分かります。
このシェルスクリプトはMySQLについては同じディレクトリにある`init.sql`の中のSQL文を実行していますが、その中にテーブルの再作成はありません。
よって、MySQLについては張ったインデックスは削除されません。

一方、SQLiteについてはそれまでのデータベースを削除してしまうので張ったインデックスは削除されてしまいます。
インデックスを永続化するためにはまず`initial_data/`にある初期のデータベースにインデックスを張ります。
例として、`1.db`にインデックスを張りたいときはそのためのSQL文を書いたファイルを用意し、`sqlite3 1.db < (ファイルのパス)`とすればよいです。
次に`/api/admin/tenants/add`が生成するデータベースにもインデックスが張られるようにします。
データベースの生成には`webapp/sql/tenant/10_schema.sql`が使われるので、このファイルにインデックスの設定を加えます。

## uwsgiを使う
最初は`webapp/python/Dockerfile`で`uwsgi --http 0.0.0.0:3000 -M -p 4 main:app`のようなコマンドを実行すればいいと思っていたのですが、それだけだと次のようなエラーが発生します。
```
Traceback (most recent call last):
  File "/home/isucon/.local/lib/python3.9/site-packages/flask/app.py", line 2525, in wsgi_app
    response = self.full_dispatch_request()
  File "/home/isucon/.local/lib/python3.9/site-packages/flask/app.py", line 1822, in full_dispatch_request
    rv = self.handle_user_exception(e)
  File "/home/isucon/.local/lib/python3.9/site-packages/flask/app.py", line 1820, in full_dispatch_request
    rv = self.dispatch_request()
  File "/home/isucon/.local/lib/python3.9/site-packages/flask/app.py", line 1796, in dispatch_request
    return self.ensure_sync(self.view_functions[rule.endpoint])(**view_args)
  File "/home/isucon/webapp/python/main.py", line 296, in tenants_add_handler
    res = admin_db.execute(
AttributeError: 'NoneType' object has no attribute 'execute'
```

これはMySQLサーバーに接続する関数である`run`が実行されていないことが原因です。
初期実装だと`run`関数は`__name__`が`__main__`のときに実行されるのですが、上述のコマンドを使っていると`__name__`が`main`になってしまい実行されません。
これを解決する簡単な方法はMySQLサーバーへの接続をトップレベルに持ってくることです。
他には[`@uwsgidecorators.postfork`](https://uwsgi-docs.readthedocs.io/en/latest/PythonDecorators.html#uwsgidecorators.postfork)を使い、以下のような関数を定義する方法もあります。

```python
import uwsgidecorators

@uwsgidecorators.postfork
def init():
    global admin_db
    admin_db = connect_admin_db()
```

## SQLiteのログを取る
予選本番では気づかなかったのですが、SQLiteのログを取るために`webapp/python/sqltrace.py`というファイルが用意されており、
`webapp/docker-compose-python.yml`の中で`ISUCON_SQLITE_TRACE_FILE`という名前の環境変数にログの出力先のパスを指定するだけで
ログを取れました。

## listen queueを大きくする
改善を進めていくと、ベンチマーカーによる同時接続を捌ききれなくなり、次のようなメッセージがログに現れるようになりました。
```
*** uWSGI listen queue of socket "127.0.0.1:12345" (fd: 3) full !!! (101/100) ***
```
listen queueを大きくすれば解決するので、uwsgiの設定ファイルに`listen = 1000`を加えて対処しました。

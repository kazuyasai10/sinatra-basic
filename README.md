## sinatraメモアプリ

![image](https://user-images.githubusercontent.com/66502196/104883858-bf12f300-59a8-11eb-939b-f4ef36d8eb49.png)


## 何ができるものなのか
postgresにメモ（id,title,content)を保存、読み込み削除ができるアプリです。

## 構築やインストール方法
### Rubyの環境構築
```
% git clone https://github.com/kazuyasai10/sinatara-basic.git
% bundle install --path vendor/bundle
% bundle exec ruby app.rb
=> http://localhost:4567
```

### postgresの環境構築

```
 CREATE DATABASE memo;
```
```
CREATE TABLE memo_table
 (
   id VARCHAR(128) NOT NULL,
   title VARCHAR(128) ,
   content text,
   PRIMARY KEY (id));
```

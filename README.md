# README

nested attributes で save 時にネストしてるモデルに context が渡るか調べるためのサンプルアプリです。Rails 5.2.1

## without context

```
irb(main):001:0> u = User.new(name: 'hoge', posts_attributes: [{title: 'aa'}])
=> #<User id: nil, name: "hoge", created_at: nil, updated_at: nil>
irb(main):002:0> u.save
   (0.1ms)  begin transaction
  User Create (1.4ms)  INSERT INTO "users" ("name", "created_at", "updated_at") VALUES (?, ?, ?)  [["name", "hoge"], ["created_at", "2018-08-23 01:45:38.015564"], ["updated_at", "2018-08-23 01:45:38.015564"]]
  Post Create (0.8ms)  INSERT INTO "posts" ("title", "user_id", "created_at", "updated_at") VALUES (?, ?, ?, ?)  [["title", "aa"], ["user_id", 4], ["created_at", "2018-08-23 01:45:38.018532"], ["updated_at", "2018-08-23 01:45:38.018532"]]
   (1.5ms)  commit transaction
=> true
```


## with context

```
irb(main):003:0> u = User.new(name: 'hoge', posts_attributes: [{title: 'bb'}])
=> #<User id: nil, name: "hoge", created_at: nil, updated_at: nil>
irb(main):004:0> u.save(context: :hoge)
   (0.1ms)  begin transaction
   (0.1ms)  rollback transaction
=> false
irb(main):005:0> u.errors
=> #<ActiveModel::Errors:0x00007fea668173d0 @base=#<User id: nil, name: "hoge", created_at: nil, updated_at: nil>, @messages={:"posts.title"=>["is too short (minimum is 3 characters)"]}, @details={:"posts.title"=>[{:error=>:too_short, :count=>3}]}>
```

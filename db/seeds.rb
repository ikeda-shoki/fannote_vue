User.create!(
  email: 'test@test.com',
  user_name: Faker::Name.unique.name,
  account_name: 'いけちゃん',
  user_introduction: "よろしくお願いします",
  is_reception: "true",
  complete_request_count: 6,
  password: "000000"
 )

User.create!(
  email: 'test1@test.com',
  user_name: Faker::Name.unique.name,
  account_name: 'くろちゃん',
  user_introduction: "初めまして！ヒロアカ大好きです！ヒロアカ関係のイラスト多めです！爆轟押し",
  is_reception: "true",
  complete_request_count: 3,
  password: "000000"
 )

User.create!(
  email: 'test2@test.com',
  user_name: Faker::Name.unique.name,
  account_name: '@LeeeN',
  user_introduction: "写真好き",
  is_reception: "true",
  complete_request_count: 1,
  password: "000000"
 )

User.create!(
  email: 'test3@test.com',
  user_name: Faker::Name.unique.name,
  account_name: '山本 @yuuuta',
  user_introduction: "好きなキャラクターを好きな感じで描きます！依頼どんどん待ってます！",
  is_reception: "true",
  complete_request_count: 0,
  password: "000000"
 )

User.create!(
  email: 'test4@test.com',
  user_name: Faker::Name.unique.name,
  account_name: 'ワカサギ100％',
  user_introduction: "依頼して頂ければ精一杯やらせてもらいます！一緒に宣伝してくれたら嬉しいです！",
  is_reception: "true",
  complete_request_count: 4,
  password: "000000"
 )

User.create!(
  email: 'test5@test.com',
  user_name: Faker::Name.unique.name,
  account_name: '鳥山カマンベールチーズ',
  user_introduction: "ドラゴンボールが大好きです！ドラゴンボール関連の画像多めです。是非フォローしてください！",
  is_reception: "true",
  complete_request_count: 2,
  password: "000000"
 )

10.times do |n|
 User.create!(
    email: "test#{n + 1}@example.com",
    user_name: Faker::Name.unique.name,
    account_name: Faker::Name.unique.name,
    is_reception: "false",
    password: "000000"
 )
end

user = User.find(1)
user.profile_image.attach(io: File.open('app/assets/images/profile.png'), filename: 'test.jpg')

user = User.find(2)
user.profile_image.attach(io: File.open('app/assets/images/profile-2.png'), filename: 'test-2.jpg')

user = User.find(4)
user.profile_image.attach(io: File.open('app/assets/images/profile-3.png'), filename: 'test-3.jpg')

user = User.find(5)
user.profile_image.attach(io: File.open('app/assets/images/profile-4.png'), filename: 'test-4.jpg')

user = User.find(6)
user.profile_image.attach(io: File.open('app/assets/images/profile-5.jpg'), filename: 'test-5.jpg')

#post_image
PostImage.create!(
  user_id: 1,
  title: "鬼滅の刃 柱",
  image_introduction: "＃鬼滅の刃 #アニメ #イラスト #柱 #kimetunoyaiba #hasira #お気に入り #ジャンプ",
  post_image_genre: "イラスト"
  )

PostImage.create!(
  user_id: 2,
  title: "僕のヒーローアカデミア トガちゃん",
  image_introduction: "＃僕のヒーローアカデミア ＃トガちゃん #アニメ #漫画 #ヒロアカ #ヴィラン #ジャンプ",
  post_image_genre: "イラスト"
  )

PostImage.create!(
  user_id: 1,
  title: "甘露寺蜜璃",
  image_introduction: "＃鬼滅の刃 ＃甘露寺蜜璃 ＃柱 ＃恋柱 ＃アニメ ＃お気に入りのキャラクター #ジャンプ",
  post_image_genre: "イラスト"
  )

PostImage.create!(
  user_id: 6,
  title: "ドラゴンボール スーパーゴテンクス",
  image_introduction: "#ドラゴンボール #ゴテンクス #スーパーサイヤ人 #スーパーサイヤ人2 #ドラゴンボールZ #スーパーゴテンクス #イラスト #ジャンプ",
  post_image_genre: "イラスト"
  )

PostImage.create!(
  user_id: 1,
  title: "ドラゴンクエスト5 主人公",
  image_introduction: "＃ハマってます #ドラゴンクエスト5 #主人公 #リュカ #ドラゴンクエスト #doragonquest #イラスト",
  post_image_genre: "イラスト"
  )

PostImage.create!(
  user_id: 2,
  title: "スパイダーマン",
  image_introduction: "#アベンジャーズ #スパイダーマン #蜘蛛 #ヒーロー #disny",
  post_image_genre: "イラスト"
  )

PostImage.create!(
  user_id: 2,
  title: "爆轟",
  image_introduction: "#ヒロアカ #爆轟 #爆発 #イラスト #ジャンプ #アニメ",
  post_image_genre: "イラスト"
  )

PostImage.create!(
  user_id: 5,
  title: "プロフィール画像",
  image_introduction: "#プロフィール画像 #イラスト #プロフィール",
  post_image_genre: "ロゴ"
  )

PostImage.create!(
  user_id: 1,
  title: "アイコン",
  image_introduction: "#プロフィール画像 #イラスト #プロフィール #アイコン画像 #新作",
  post_image_genre: "ロゴ"
  )

PostImage.create!(
  user_id: 5,
  title: "新プロフィール画像",
  image_introduction: "#プロフィール画像 #イラスト #プロフィール #アイコン画像 #新作",
  post_image_genre: "ロゴ"
  )

PostImage.create!(
  user_id: 4,
  title: "Railsロゴ",
  image_introduction: "#ロゴ #rails #プログラミング #アイコン画像 #Ruby",
  post_image_genre: "ロゴ"
  )

PostImage.create!(
  user_id: 3,
  title: "夕日",
  image_introduction: "#写真 #夕日 #sunset #最高！ #たそがれ",
  post_image_genre: "写真"
  )

PostImage.create!(
  user_id: 3,
  title: "神社 鳥居",
  image_introduction: "#写真 #神社 #鳥居 #お願い #好きな写真をあげよう",
  post_image_genre: "写真"
  )

PostImage.create!(
  user_id: 3,
  title: "空港 関西国際空港",
  image_introduction: "#写真 #空港 #関空 #昨日の出来事 #旅行",
  post_image_genre: "写真"
  )

PostImage.create!(
  user_id: 3,
  title: "大自然",
  image_introduction: "#写真 #自然 #これが最高 #海外旅行 #旅行",
  post_image_genre: "写真"
  )

post_image = PostImage.find(1)
post_image.post_image.attach(io: File.open('app/assets/images/illust.png'), filename: 'test-6.jpg')

post_image = PostImage.find(2)
post_image.post_image.attach(io: File.open('app/assets/images/illust-2.jpg'), filename: 'test-7.jpg')

post_image = PostImage.find(3)
post_image.post_image.attach(io: File.open('app/assets/images/illust-3.jpg'), filename: 'test-8.jpg')

post_image = PostImage.find(4)
post_image.post_image.attach(io: File.open('app/assets/images/illust-4.jpg'), filename: 'test-9.jpg')

post_image = PostImage.find(5)
post_image.post_image.attach(io: File.open('app/assets/images/illust-5.jpg'), filename: 'test-10.jpg')

post_image = PostImage.find(6)
post_image.post_image.attach(io: File.open('app/assets/images/illust-6.jpg'), filename: 'test-11.jpg')

post_image = PostImage.find(7)
post_image.post_image.attach(io: File.open('app/assets/images/illust-7.png'), filename: 'test-12.jpg')

post_image = PostImage.find(8)
post_image.post_image.attach(io: File.open('app/assets/images/illust-8.png'), filename: 'test-13.jpg')

post_image = PostImage.find(9)
post_image.post_image.attach(io: File.open('app/assets/images/illust-9.png'), filename: 'test-14.jpg')

post_image = PostImage.find(10)
post_image.post_image.attach(io: File.open('app/assets/images/illust-10.jpg'), filename: 'test-15.jpg')

post_image = PostImage.find(11)
post_image.post_image.attach(io: File.open('app/assets/images/profile.png'), filename: 'test-16.jpg')

post_image = PostImage.find(12)
post_image.post_image.attach(io: File.open('app/assets/images/photo.jpg'), filename: 'test-17.jpg')

post_image = PostImage.find(13)
post_image.post_image.attach(io: File.open('app/assets/images/photo-2.jpg'), filename: 'test-18.jpg')

post_image = PostImage.find(14)
post_image.post_image.attach(io: File.open('app/assets/images/photo-3.jpg'), filename: 'test-19.jpg')

post_image = PostImage.find(15)
post_image.post_image.attach(io: File.open('app/assets/images/photo-4.jpg'), filename: 'test-20.jpg')

# post_image_comment
3.times do |n|
  PostComment.create!(
     user_id: 6 + (n + 1),
     post_image_id: 1,
     comment: Faker::Superhero.name
  )
end

2.times do |n|
  PostComment.create!(
     user_id: 7 + (n + 1),
     post_image_id: 2,
     comment: Faker::Superhero.name
  )
end

5.times do |n|
  PostComment.create!(
     user_id: 6 + (n + 1),
     post_image_id: 3,
     comment: Faker::Books::Dune.quote
  )
end

8.times do |n|
  PostComment.create!(
     user_id: 6 + (n + 1),
     post_image_id: 6,
     comment: Faker::Books::Dune.quote
  )
end

2.times do |n|
  PostComment.create!(
     user_id: (n + 1),
     post_image_id: 7,
     comment: Faker::Books::Dune.saying
  )
end

4.times do |n|
  PostComment.create!(
     user_id: 3 + (n + 1),
     post_image_id: 8,
     comment: Faker::Books::Dune.saying
  )
end

10.times do |n|
  PostComment.create!(
     user_id: 2 + (n + 1),
     post_image_id: 9,
     comment: Faker::Books::Dune.saying
  )
end

4.times do |n|
  PostComment.create!(
     user_id: 8 + (n + 1),
     post_image_id: 10,
     comment: Faker::Books::Dune.saying
  )
end

2.times do |n|
  PostComment.create!(
     user_id: 10 + (n + 1),
     post_image_id: 11,
     comment: Faker::Books::Dune.saying
  )
end

6.times do |n|
  PostComment.create!(
     user_id: 5 + (n + 1),
     post_image_id: 12,
     comment: Faker::Books::Dune.saying
  )
end

7.times do |n|
  PostComment.create!(
     user_id: 2 + (n + 1),
     post_image_id: 13,
     comment: Faker::Books::Dune.saying
  )
end

3.times do |n|
  PostComment.create!(
     user_id: 9 + (n + 1),
     post_image_id: 14,
     comment: Faker::Books::Dune.saying
  )
end

#favorite
10.times do |n|
  Favorite.create!(
     user_id: 2 + (n + 1),
     post_image_id: 1,
  )
end

5.times do |n|
  Favorite.create!(
     user_id: (n + 1),
     post_image_id: 2,
  )
end

8.times do |n|
  Favorite.create!(
     user_id: 4 + (n + 1),
     post_image_id: 3,
  )
end

6.times do |n|
  Favorite.create!(
     user_id: 6 + (n + 1),
     post_image_id: 4,
  )
end

1.times do |n|
  Favorite.create!(
     user_id: 10,
     post_image_id: 5,
  )
end

4.times do |n|
  Favorite.create!(
     user_id: 1 + (n + 1),
     post_image_id: 8,
  )
end

9.times do |n|
  Favorite.create!(
     user_id: (n + 1),
     post_image_id: 9,
  )
end

2.times do |n|
  Favorite.create!(
     user_id: 9 + (n + 1),
     post_image_id: 10,
  )
end

8.times do |n|
  Favorite.create!(
     user_id: 7 + (n + 1),
     post_image_id: 11,
  )
end

5.times do |n|
  Favorite.create!(
     user_id: 1 + (n + 1),
     post_image_id: 12,
  )
end

8.times do |n|
  Favorite.create!(
     user_id: 2 + (n + 1),
     post_image_id: 13,
  )
end

6.times do |n|
  Favorite.create!(
     user_id: 4 + (n + 1),
     post_image_id: 14,
  )
end

1.times do |n|
  Favorite.create!(
     user_id: 3 + (n + 1),
     post_image_id: 15,
  )
end


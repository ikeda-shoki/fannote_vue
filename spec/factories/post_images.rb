include ActionDispatch::TestProcess

FactoryBot.define do
  factory :post_image do
    association :user
    title { Faker::Lorem.characters(number: 15) }
    image_introduction { Faker::Lorem.characters(number: 20) }
    post_image_genre { "イラスト" }
  end
end

FactoryBot.define do
  factory :test_post_image, :class => "PostImage" do
    association :user
    title { Faker::Lorem.characters(number: 15) }
    image_introduction { "#イラスト #明日は明日の風が吹く #テスト #test" }
    post_image_genre { "イラスト" }
    after(:build) do |test_post_image|
      test_post_image.post_image.attach(io: File.open('app/assets/images/profile.png'), filename: 'test_sample.jpg')
    end
  end
end

FactoryBot.define do
  factory :reception_user_post_image, :class => "PostImage" do
    association :reception_user
    title { Faker::Lorem.characters(number: 15) }
    image_introduction { Faker::Lorem.characters(number: 20) }
    post_image_genre { "ロゴ" }
  end
end
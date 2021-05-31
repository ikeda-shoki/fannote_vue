include ActionDispatch::TestProcess

FactoryBot.define do
  factory :request do
    association :requester, factory: :user
    association :requested, factory: :user
    request_introduction { Faker::Lorem.characters(number: 30) }
    file_format { "jpeg" }
    use { Faker::Lorem.characters(number: 30) }
    amount { "1" }
    deadline { "2022/06/20" }
    request_status { "未受付" }
  end
end

FactoryBot.define do
  factory :request_more, :class => "Request" do
    association :requester, factory: :user
    association :requested, factory: :user
    request_introduction { Faker::Lorem.characters(number: 30) }
    file_format { "jpeg" }
    use { Faker::Lorem.characters(number: 30) }
    amount { "2" }
    deadline { "2022/06/20" }
    request_status { "未受付" }
    request_images { fixture_file_upload('app/assets/images/illust.png', 'app/assets/images/illust-2.jpg') }
  end
end
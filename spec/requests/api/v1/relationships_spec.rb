require 'rails_helper'

describe 'RelationshipAPI', type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:other_user) { FactoryBot.create(:not_reception_user) }
  let(:followed_user) { FactoryBot.create(:followed_user) }

  before do
    sign_in user
    user.follow(other_user.id)
  end

  it 'フォローを外すことに成功する(unfollow)' do
    delete "/api/v1/follow/#{other_user.id}"
    expect(response).to have_http_status 200
    expect(user.follower.all.count).to eq 0
  end

  it 'フォローに成功する(follow)' do
    expect { post "/api/v1/follow/#{followed_user.id}" }.to change(user.follower, :count).by(+1)
    expect(response).to have_http_status 200
  end
end
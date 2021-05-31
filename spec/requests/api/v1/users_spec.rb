require 'rails_helper'

describe 'UserAPI', type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:user_another) { FactoryBot.create(:not_reception_user) }

  it 'ユーザーがログイン済みがどうかを確認するが成功(sign_in)' do
    get "/api/v1/users/sign_in"
    expect(response).to have_http_status 200
  end

  it '特定のUserを取得するが成功(show)' do
    sign_in user
    get "/api/v1/users/#{user.id}"
    expect(response).to have_http_status 200
  end

  it '全てのユーザーを取得するが成功(index)' do
    sign_in user
    get "/api/v1/users"
    expect(response).to have_http_status 200
  end

  it 'ユーザーを更新するが成功(update)' do
    sign_in user
    patch "/api/v1/users/#{user.id}", params: { user: { user_name: "山田孝之" } }
    json = JSON.parse(response.body)
    expect(response).to have_http_status 200
    expect(json['user_name']).to eq('山田孝之')
  end

  it 'Userのフォローしているユーザーの一覧を取得するが成功(following)' do
    sign_in user
    get "/api/v1/users/#{user.id}/following"
    expect(response).to have_http_status 200
  end

  it 'Userのフォロワーの一覧を取得するが成功(following)' do
    sign_in user
    get "/api/v1/users/#{user.id}/followed"
    expect(response).to have_http_status 200
  end

  it 'Userが退会するが成功(destroy)' do
    sign_in user
    expect { delete "/api/v1/users/#{user.id}" }.to change(User, :count).by(-1)
    expect(response).to have_http_status 204
  end
end
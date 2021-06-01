require 'rails_helper'

describe 'RequestAPI', type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:requested_user) { FactoryBot.create(:followed_user) }

  before do
    sign_in user
    @user_request = user.request.create(
      request_introduction: "テスト",
      file_format: "png",
      use: "テスト",
      deadline: "2022/06/20",
      amount: 1,
      request_status: "未受付",
      requester_id: user.id,
      requested_id: requested_user.id
    )
    @user_requested = user.requested.create(
      request_introduction: "テスト",
      file_format: "png",
      use: "テスト",
      deadline: "2022/06/20",
      amount: 1,
      request_status: "未受付",
      requester_id: requested_user.id,
      requested_id: user.id
    )
  end

  it 'ユーザーのリクエスト一覧を取得(requesting)' do
    get "/api/v1/users/#{user.id}/requesting"
    expect(response).to have_http_status 200
  end

  it 'ユーザーのリクエストされた一覧を取得(requested)' do
    get "/api/v1/users/#{user.id}/requested"
    expect(response).to have_http_status 200
  end

  it 'Requestの作成に成功する(create)' do
    valid_params = { request_introduction: "テスト", file_format: "png", use: "テスト", deadline: "2022/06/20", amount: 1, request_status: "未受付" }
    expect { post "/api/v1/users/#{user.id}/requests", params: { request: valid_params } }.to change(Request, :count).by(+1)
    expect(response).to have_http_status 201
  end

  it 'Requestの更新、変更に成功する(update)' do
    patch "/api/v1/users/#{user.id}/requests/#{@user_request.id}", params: { request: { use: "テスト編集済み" } }
    json = JSON.parse(response.body)
    expect(response).to have_http_status 200
    expect(json['request']['use']).to eq('テスト編集済み')
  end

  it 'Requestのステータスの更新に成功する(update_request_status)' do
    patch "/api/v1/users/#{user.id}/requests/#{@user_requested.id}/update_request_status", params: { request: { request_status: "製作中" } }
    json = JSON.parse(response.body)
    expect(response).to have_http_status 200
    expect(json['request_status']).to eq('製作中')
  end

  it 'Requestの完成画像の送信に成功する(update_request_status)' do
    update_params =  { request_images: [File.read('spec/fixtures/test_image.jpg.bin')] }
    patch "/api/v1/users/#{user.id}/requests/#{@user_requested.id}/update_request_complete_image", params: { request: update_params }
    expect(response).to have_http_status 200
  end

  it 'Requestの削除に成功する(destroy)' do
    delete "/api/v1/users/#{user.id}/requests/#{@user_request.id}"
    expect(response).to have_http_status 204
    expect(Request.all.count).to eq 1
  end

  it 'リクエスト完了結果を取得(request_done)' do
    get "/api/v1/users/#{user.id}/requests/#{@user_requested.id}/request_done"
    expect(response).to have_http_status 200
  end

  it 'リクエスト完成結果を取得(request_complete)' do
    get "/api/v1/users/#{user.id}/requests/#{@user_request.id}/request_complete"
    expect(response).to have_http_status 200
  end
end
require 'rails_helper'

describe 'ChatAPI', type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:requested_user) { FactoryBot.create(:followed_user) }

  before do
    sign_in user
    @request = user.request.create(
      request_introduction: "テスト",
      file_format: "png",
      use: "テスト",
      deadline: "2022/06/20",
      amount: 1,
      request_status: "未受付",
      requester_id: user.id,
      requested_id: requested_user.id
    )
    @chat = @request.chats.create(
      user_id: user.id,
      request_id: @request.id,
      message: "テストメッセージ",
    )
    UserRoom.create(user_id: user.id, request_id: @request.id)
    UserRoom.create(user_id: requested_user.id, request_id: @request.id)
  end

  it '特定のChatRoomを取得することに成功する(show)' do
    get "/api/v1/users/#{user.id}/requests/#{@request.id}/chats"
    expect(response).to have_http_status 200
  end

  it 'Chatの作成に成功する(create)' do
    valid_params = { message: "テストメッセージ", request_id: @request.id }
    expect { post "/api/v1/users/#{user.id}/requests/#{@request.id}/chats", params: { chat: valid_params } }.to change(Chat, :count).by(+1)
    expect(response).to have_http_status 201
  end

  it 'Chatの削除に成功する(destroy)' do
    delete "/api/v1/users/#{user.id}/requests/#{@request.id}/chats", params: { id: @chat.id }
    expect(response).to have_http_status 204
    expect(Chat.all.count).to eq 0
  end

end
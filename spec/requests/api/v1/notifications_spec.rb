require 'rails_helper'

describe 'NotificationAPI', type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:visitor) { FactoryBot.create(:followed_user) }

  before do
    sign_in user
    @user_notification = user.passive_notifications.create(
      visitor_id: visitor.id,
      visited_id: user.id,
      action: "follow",
      checked: false,
    )
    @user_more_notification = user.passive_notifications.create(
      visitor_id: visitor.id,
      visited_id: user.id,
      action: "follow",
      checked: false,
    )
  end

  it 'ユーザーの通知一覧を取得(index)' do
    get "/api/v1/notifications"
    expect(response).to have_http_status 200
  end

  it '通知の削除に成功する(destroy)' do
    delete "/api/v1/notifications/#{@user_notification.id}"
    expect(response).to have_http_status 204
    expect(Notification.all.count).to eq 1
  end

  it '通知の全ての削除に成功する(all_destroy)' do
    delete "/api/v1/notifications/all_destroy"
    expect(response).to have_http_status 204
    expect(Notification.all.count).to eq 0
  end
end
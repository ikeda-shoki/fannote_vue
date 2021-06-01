require 'rails_helper'

describe 'PostCommentAPI', type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:post_image) { FactoryBot.create(:test_post_image)}

  before do
    sign_in user
    @post_comment = post_image.post_comments.create(
      comment: "初期値",
      user_id: user.id,
      post_image_id: post_image.id
    )
  end

  it 'PostCommentの作成に成功する(create)' do
    valid_params = { comment: "テスト", user_id: user.id }
    expect { post "/api/v1/post_images/#{post_image.id}/post_comments", params: { post_comment: valid_params } }.to change(PostComment, :count).by(+1)
    expect(response).to have_http_status 201
  end

  it 'PostCommentの削除に成功する(destroy)' do
    delete "/api/v1/post_images/#{post_image.id}/post_comments/#{@post_comment.id}"
    expect(response).to have_http_status 204
    expect(PostComment.all.count).to eq 0
  end
end
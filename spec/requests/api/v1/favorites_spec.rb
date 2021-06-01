require 'rails_helper'

describe 'FavoritesAPI', type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:post_image) { FactoryBot.create(:test_post_image)}

  before do
    sign_in user
    @favorite = post_image.favorites.create(
      user_id: user.id,
      post_image_id: post_image.id
    )
  end

  it 'Favoriteの削除に成功する(destroy)' do
    delete "/api/v1/post_images/#{post_image.id}/favorites"
    expect(response).to have_http_status 200
    expect(Favorite.all.count).to eq 0
  end

  it 'Favoriteの作成に成功する(create)' do
    expect { post "/api/v1/post_images/#{post_image.id}/favorites" }.to change(Favorite, :count).by(+1)
    expect(response).to have_http_status 201
  end

end
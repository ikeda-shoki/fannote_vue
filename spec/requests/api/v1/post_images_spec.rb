require 'rails_helper'

describe 'PostImageAPI', type: :request do
  let(:user) { FactoryBot.create(:user) }
  let(:post_image) { FactoryBot.create(:test_post_image)}

  before do
    sign_in user
  end

  it '特定のPostImageを取得することに成功する(show)' do
    get "/api/v1/post_images/#{post_image.id}"
    expect(response).to have_http_status 200
  end

  it '全てのPostImageを取得することに成功する(index)' do
    get "/api/v1/post_images"
    expect(response).to have_http_status 200
  end

  it 'main画面の取得に成功する(main)' do
    get "/api/v1/post_images/main"
    expect(response).to have_http_status 200
  end

  it 'PostImageの作成に成功する(create)' do
    valid_params = { title: "お気に入り", image_introduction: "#ドラゴンボール", image: File.read('spec/fixtures/test_image.jpg.bin'), post_image_genre: "イラスト" }
    expect { post '/api/v1/post_images', params: { post_image: valid_params } }.to change(PostImage, :count).by(+1)
    expect(response).to have_http_status 201
  end

  it 'PostImageの更新に成功する(update)' do
    update_params = { title: "鬼滅の刃", image_introduction: "#ドラゴンボール", image: File.read('spec/fixtures/test_image.jpg.bin'), post_image_genre: "ロゴ" }
    patch "/api/v1/post_images/#{post_image.id}", params: { post_image: update_params }
    json = JSON.parse(response.body)
    expect(response).to have_http_status 200
    expect(json['title']).to eq('鬼滅の刃')
  end
  
  it 'PostImageの削除に成功する(destroy)' do
    delete "/api/v1/post_images/#{post_image.id}"
    expect(response).to have_http_status 204
    expect(PostImage.all.count).to eq 0
  end

end
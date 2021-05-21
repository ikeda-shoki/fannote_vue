json.set! :hash_tag do
  json.partial! "api/v1/post_images/hash_tag", hash_tag: @tag
  json.hash_tag_post_images_count(@tag.post_images.count)
end
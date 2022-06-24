# frozen_string_literal: true
class PostPresenter
  def initialize(posts)
    @posts = posts
  end

  def as_jsons
    posts = []
    @posts.each do |post|
      posts <<
       {
         id: post.id,
         title: post.title,
         body: post.body.body
       }
     end
    posts
  end

  def get_post
    {
      id: @posts.id,
      title: @posts.title,
      body: @posts.body.body,
      views: @posts.views,
      created_at: @posts.created_at,
      updated_at: DateTimeFormatter.DDMMddyy(@posts.updated_at),
      banner_cloud_image: @posts.banner.url,
      thumbnail_cloud_image: @posts.thumbnail.url
    }
  end
end

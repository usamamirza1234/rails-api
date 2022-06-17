# frozen_string_literal: true
class BlogPresenter
  def initialize(blogs)
    @blogs = blogs
  end

  def as_json
    blogs = []
   @blogs.each do |blog|
     blogs <<
      {
        id: blog.id,
        heading: blog.heading,
        sub_heading: blog.sub_heading
      }
    end
    blogs
  end

  def get_blog
    {
      id: @blogs.id,
      heading: @blogs.heading,
      sub_heading: @blogs.sub_heading
    }

  end

end
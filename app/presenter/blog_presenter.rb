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
        heading: blog.heading,
        sub_heading: blog.sub_heading
      }
    end
    blogs
  end

end
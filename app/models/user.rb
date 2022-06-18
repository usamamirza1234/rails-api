class User < ApplicationRecord
  # Include default devise modules. Others available are:
  # :confirmable, :lockable, :timeoutable, :trackable and :omniauthable
  devise :database_authenticatable, :registerable,
         :recoverable, :rememberable, :validatable,
         :lockable, :timeoutable, :trackable

  enum user_type: { admin: 0, app_users: 1 }

  has_many :posts
  has_many :comments, dependent: :destroy



  def comment_created
    self.number_of_comments = number_of_comments + 1
    save
    number_of_comments
  end

end

class AddNumberOfCommentsToUser < ActiveRecord::Migration[6.1]
  def up
    add_column :users, :number_of_comments, :integer, default: 0
  end
  def down
    remove_column :users, :number_of_comments, :integer, default: 0
  end
end

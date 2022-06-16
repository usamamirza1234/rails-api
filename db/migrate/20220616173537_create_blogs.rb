class CreateBlogs < ActiveRecord::Migration[6.1]
  def change
    create_table :blogs do |t|
      t.string :heading
      t.string :sub_heading
      t.timestamps
    end
  end
end

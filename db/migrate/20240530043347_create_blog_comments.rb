class CreateBlogComments < ActiveRecord::Migration[7.1]
  def change
    create_table :blog_comments do |t|
      t.string :comment
      t.references :user, null: false, foreign_key: true
      t.references :blog, null: false, foreign_key: true

      t.timestamps
    end
  end
end

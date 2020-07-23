class MakeReviewsJoinTable < ActiveRecord::Migration[6.0]
  def change
    remove_column :reviews, :name, :string
    add_column :reviews, :user_id, :integer # new column, will be linked to User table
    Review.delete_all # delete all existing reviews since removing the "name" column invalidates all of them
  end
end

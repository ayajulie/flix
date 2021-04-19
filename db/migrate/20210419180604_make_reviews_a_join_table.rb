class MakeReviewsAJoinTable < ActiveRecord::Migration[6.0]
  def change
    remove_column :reviews, :name, :string # specify in case you rollback the migration
    add_column :reviews, :user_id, :integer
    Review.delete_all # to work on a clean table because the records will be invalid
  end
end

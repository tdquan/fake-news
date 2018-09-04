class AddAttributesToPost < ActiveRecord::Migration[5.2]
  def change
  	add_column :posts, :photo, :string
  	add_column :posts, :rating, :float, default: 0.0
  	change_column_default :posts, :upvote, 0
  	change_column_default :posts, :downvote, 0
  	change_column_default :comments, :upvote, 0
  	change_column_default :comments, :upvote, 0
  end
end

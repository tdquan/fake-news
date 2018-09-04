class ChangeColumnDefault < ActiveRecord::Migration[5.2]
  def change
  	change_column_default :comments, :downvote, 0
  end
end

class AddPasswordToUser < ActiveRecord::Migration[5.2]
  def change
  	add_column :users, :password, :string, default: ""
  	change_column :users, :email, :string, unique: true
  end
end

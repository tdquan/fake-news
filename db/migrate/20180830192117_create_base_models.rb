class CreateBaseModels < ActiveRecord::Migration[5.2]
  def change
  	create_table :posts do |t|
      t.string :title
      t.text :content
      t.references :user, foreign: true
      t.integer :upvote
      t.integer :downvote
      t.datetime :created_at
      t.datetime :updated_at

      t.timestamps
    end

    create_table :comments do |t|
    	t.references :user, foreign: true
    	t.references :post, foreign: true
    	t.text :content
    	t.integer :upvote
    	t.integer :downvote
    	t.datetime :created_at
      t.datetime :updated_at

      t.timestamps
    end

    create_table :users do |t|
      t.string :first_name
      t.string :last_name
      t.string :email
      t.string :nickname

      t.timestamps
    end
  end
end

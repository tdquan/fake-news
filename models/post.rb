class Post < ActiveRecord::Base
	belongs_to :user
	has_many :comments

	def posted_on
		super Date.strptime(self.post_date, '%d/%m/%Y')
	end
end

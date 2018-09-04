class User < ActiveRecord::Base
	has_many :posts
	has_many :comments

	def self.authenticate(email, password)
		user = User.find_by_email(email)
		if user && password = user.password
			return user
		else
			return nil
		end
	end
end

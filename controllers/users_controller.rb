class UsersController < ApplicationController
	post '/users' do
		user = User.new
		user.first_name = params[:first_name]
		user.last_name = params[:last_name]
		user.email = params[:email]
		user.nickname = params[:nickname]
		user.password = params[:password]
		if params[:password] == params[:confirm_password] && user.save
			flash[:success] = "Welcome #{user.first_name}"
			warden_handler.authenticate!
			redirect '/'
		else
			flash[:danger] = "Failed to create your account"
			redirect '/signup'
		end
	end

end

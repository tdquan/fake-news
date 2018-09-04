class SessionsController < ApplicationController
	get '/protected' do
		erb :'protected'
	end

	get '/login' do
		erb :'sessions/login'
	end

	get '/signup' do
		erb :'sessions/signup'
	end

	post '/sessions' do
		warden_handler.authenticate!
		if warden_handler.authenticated?
			flash[:success] = "Logged in"
			redirect '/'
		else
			flash[:danger] = "Couldn't log in with provided credentials."
			redirect '/login'
		end
	end

	get '/logout' do
		warden_handler.logout
		flash[:success] = "Logged out."
		redirect '/'
	end
end

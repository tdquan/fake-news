$:.unshift(File.expand_path('../../lib', __FILE__))
require 'sinatra'
require 'sinatra/activerecord'
require 'sinatra/reloader'
require 'better_errors'
require 'asset_handler'
require 'sinatra'
require 'sinatra/flash'
require 'warden'
require 'time_ago'

require_relative '../models/user'
require_relative '../models/post'
require_relative '../models/comment'

set :database, "sqlite3:development.sqlite3"

class ApplicationController < Sinatra::Base
	use Rack::Session::Cookie
	register Sinatra::Flash
	include TimeAgo

	configure :development do
		register Sinatra::Reloader
	  use BetterErrors::Middleware
	  BetterErrors.application_root = File.expand_path('../../', __FILE__)
	end

	set :views, File.expand_path('../../views', __FILE__)

	use AssetHandler

	use Warden::Manager do |manager|
		manager.default_strategies :password
		manager.failure_app = ApplicationController
		manager.serialize_into_session { |user| user.id }
		manager.serialize_from_session { |id| User.find(id) }
	end

	Warden::Manager.before_failure do |env,opts|
	  env['REQUEST_METHOD'] = 'POST'
	end

	Warden::Strategies.add(:password) do
	  def valid?
	    params["email"] || params["password"]
	  end

	  def authenticate!
	    user = User.authenticate(params["email"], params["password"])
	    if user
	      success!(user)
	    else
	    	throw(:warden, message: "The username does not exist.")
	      fail!("Could not log in")
	    end
	  end
	end

	not_found { erb :'404' }

	error { erb :'500' }

	def warden_handler
  	env['warden']
	end

	def current_user
		warden_handler.user
	end

	def check_authentication
		unless warden_handler.authenticated?
			flash[:danger] = "You need to log in before proceeding."
			redirect '/login'
		end
	end
end

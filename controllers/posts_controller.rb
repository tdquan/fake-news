class PostsController < ApplicationController
	require 'open-uri'

	Article = Struct.new(:id, :title, :content, :upvote, :downvote, :comments, :photo_url, :published_date, :user_id, :outside_source, :source_url)

	get '/' do
		find_posts
		erb :'posts/index'
	end

	get '/posts/new' do
		check_authentication
		erb :'posts/new'
	end

	post '/posts' do
		check_authentication
		if current_user.posts.create(title: params[:title], content: params[:content], photo: params[:photo])
			flash[:success] = "Article created."
			redirect '/'
		else
			flash[:danger] = "Failed to create article."
			redirect '/posts/new'
		end
	end

	post '/posts/:id/upvote' do
		check_authentication
		find_post(params[:id])
		@post.upvote = @post.upvote + 1
		@post.save
		redirect '/'
	end

	post '/posts/:id/downvote' do
		check_authentication
		find_post(params[:id])
		@post.downvote = @post.downvote + 1
		@post.save
		redirect '/'
	end

	private

	def find_posts
		@posts = []
		# Articles from database
		Post.all.each do |post|
			article = Article.new(
				post.id.to_s,
				post.title,
				post.content,
				post.upvote,
				post.downvote,
				post.comments,
				post.photo,
				post.created_at,
				post.user_id,
				false,
				""
			)
			@posts << article
		end
		# Articles from outside sources
		url = 'https://newsapi.org/v2/top-headlines?country=fr&apiKey=a53aad26f0ea40ceaf722e0c5c3db3ce'
		req = open(url)
		res_body = req.read
		posts = JSON.parse(res_body)["articles"]
		posts.each do |post|
			i = 1
			article = Article.new(
				"outside-#{i}",
				post["title"],
				post["description"],
				0,
				0,
				[],
				post["urlToImage"],
				Time.parse(post["publishedAt"]),
				nil,
				true,
				post["url"]
			)
			@posts << article
			i += 1
		end
		@posts = (@posts.sort_by { |post| post.published_date }).reverse
	end

	def find_post(id)
		@post = Post.find_by_id(id)
	end
end

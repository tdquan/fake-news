class CommentsController < ApplicationController
	post '/posts/:post_id/comments' do
		check_authentication
		unless params[:new_comment].blank?
			find_post(params[:post_id])
			if @post.comments.create(content: params[:new_comment], user_id: current_user.id)
				flash[:success] = "Added your comment."
			else
				flash[:danger] = "Failed to add your comment."
			end
		else
			flash[:danger] = "Comment content is empty."
		end
		redirect '/'
	end

	private

	def find_post(id)
		@post = Post.find_by_id(id)
	end
end

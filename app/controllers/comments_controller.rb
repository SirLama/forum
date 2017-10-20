class CommentsController < ApplicationController
	before_action :find_post
	before_action :authenticate_user!, only:[:new, :edit]

	def new
		 @comment = Comment.new(post_id: params[:post_id])
	end

	def show
		@comment =Comment.find(params[:id])
	end

	def create
		@comment = Comment.new(comment_params)
		@comment.post_id = @post.id
		@comment.user_id = current_user.id if current_user

		if @comment.save
			redirect_to post_path(@post)
		else
			render 'new'
		end
	end

	private

	def comment_params
		params.require(:comment).permit(params:[:comment, :post_id])
	end

	def find_post
		@post = Post.find(params[:post_id])
	end
end

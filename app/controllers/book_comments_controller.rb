class BookCommentsController < ApplicationController

	def create
		@book = Book.find(params[:book_id])
		# @comment = current_user.book_comments.new(book_comment_params)
		# @comment.book_id = book.id
		 @comment = @book.book_comments.build(book_comment_params) #②
		 @comment.user_id = current_user.id 
		 if @comment.save
		 	render :index
		 end
		end

		def destroy
			@book = Book.find(params[:book_id])
			@comment = current_user.book_comments.find(params[:id])
			if @comment.destroy
				render :index
			end
		end

		private
		def book_comment_params
			params.require(:book_comment).permit(:comment, :user_id, :book_id)
		end
	end

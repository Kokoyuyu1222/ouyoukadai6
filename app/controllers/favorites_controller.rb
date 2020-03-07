class FavoritesController < ApplicationController
	before_action :book_params
	def create
		@favorite = Favorite.create(user_id: current_user.id, book_id: @book.id)
            # redirect_to request.referer
        end
        def destroy
        	@favorite = Favorite.find_by(user_id: current_user.id, book_id: @book.id).destroy
        end
        private
        def favorite_params
        	params.require_params(:favorite).permit(:book_id)
        end
        def book_params
        	@book = Book.find(params[:book_id])
        end
    end

class RatingsController < ApplicationController
  def create
    Rails.logger.debug(rating_params)
    @rating = Rating.create(rating_params.merge({ user_id: current_user.id }))
    render 'create', layout: false, locals: { user: current_user }
  end

private
  def rating_params
    params.require(:rating).permit(:mark, :title, :comment, :book_id)
  end

end

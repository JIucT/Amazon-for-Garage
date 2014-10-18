class RatingsController < ApplicationController
  before_action :authenticate_user!
  
  def create
    @rating = Rating.create(rating_params.merge({ user_id: current_user.id }))
    render 'create', layout: false, locals: { user: current_user }
  end

private
  def rating_params
    params.require(:rating).permit(:mark, :title, :comment, :book_id)
  end

end

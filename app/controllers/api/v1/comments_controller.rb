class Api::V1::CommentsController < Api::V1::BaseController
  acts_as_token_authentication_handler_for User


  def create
    restaurant = Restaurant.find(params[:restaurant_id])
    @comment = Comment.new(comment_params)
    @comment.user = current_user
    @comment.restaurant = restaurant
    authorize @comment
    if @comment.save
      redirect_to api_v1_restaurant_path(restaurant)
    else
      render_error
    end
  end

  private


  def comment_params
    params.require(:comment).permit(:content)
  end

  def render_error
    render json: { errors: @comment.errors.full_messages },
      status: :unprocessable_entity
  end
end
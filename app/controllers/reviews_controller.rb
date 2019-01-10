class ReviewsController < RankingController
  before_action :authenticate_user!, only: :new

  def new
    @product = Product.find(params[:product_id])
    @review = Review.new
  end

  def create
    Review.create(create_params)
    # Review.create(create_params)
    # トップページにリダイレクトする
    redirect_to controller: :products, action: :index
  end

  private
  def create_params
    # params.require(:review).permit(:nickname, :rate, :review).merge(product_id: params[:product_id])
    # params.require(:review).permit(:rate, :review).merge(product_id: params[:product_id], nickname: current_user.nickname)
    # params.require(:review).permit(:rate, :review).merge(product_id: params[:product_id], user_id: current_user.id)
    params.require(:review).permit(:rate, :review).merge(product_id: params[:product_id], user_id: current_user.id)

  end
end

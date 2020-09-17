class CategoriesController < ApplicationController
  before_action :require_admin, except:[:index, :show]
  
  def new
    @category = Category.new
  end
  
  def create
    @category = Category.new(category_params)
    if @category.save
      flash[:notice] = 'Category successfully created'
      redirect_to @category
    else
      render 'new'
    end
  end
  
  def index
    @categories = Category.paginate(page: params[:page], per_page: 4)
  end

  def show
    @category = Category.find(params[:id])
  end

  private

  def require_admin
    if !(logged_in? && current_user.admin?)
      flash[:alert] = "You can't preform that unless you are an admin"
      redirect_to categories_path
    end
  end

  def category_params
    params.require(:category).permit(:name)
  end

end
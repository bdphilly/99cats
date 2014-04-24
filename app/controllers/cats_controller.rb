class CatsController < ApplicationController

  def index
    @cats = Cat.all
    render :index
  end

  def show
    @cat = Cat.find(params[:id])
    render :show
  end

  def new
    @cat = Cat.new
    render :new
  end

  def create
    @new_cat = Cat.new(cat_params)
    if @new_cat.save
      redirect_to cat_url(@new_cat)
    else
      render :new
    end
  end


  def edit
    @cat = Cat.find(params[:id])
    render :edit
  end

  def update
    @updated_cat = Cat.update(params[:id], cat_params)
    redirect_to cat_url(@updated_cat)
  end


  private

    def cat_params
      cat_attrs = [:name, :age, :sex, :color, :birth_date]
      params.require(:cat).permit(*cat_attrs)
    end

end
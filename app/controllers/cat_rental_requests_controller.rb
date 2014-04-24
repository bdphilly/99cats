class CatRentalRequestsController < ApplicationController
  def index
    @cat_rental_requests = CatRentalRequest.all
    render :index
  end

  # def show
  #   @cat_rental_request = CatRentalRequest.find(params[:id])
  #   render :show
  # end

  def new
    @cat_rental_request = CatRentalRequest.new
    @cats = Cat.all
    render :new
  end

  def create
    @new_cat_rental_request = CatRentalRequest.new(cat_rental_params)
    if @new_cat_rental_request.save
      redirect_to cat_rental_requests_url
    else
      render :new
    end
  end


  private

    def cat_rental_params
      cat_rental_attrs = [:cat_id, :start_date, :end_date]
      params.require(:cat_rental_request).permit(*cat_rental_attrs)
    end

end
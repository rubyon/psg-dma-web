class ProductTanksController < ApplicationController
  before_action :authenticate_user!
  def index
    @product_tanks = ProductTank.all
    @new_product_tanks = ProductTank.new
  end

  def create
    @new_product_tanks = ProductTank.new(product_tank_params)

    if @new_product_tanks.save
      redirect_to product_tanks_path
    else
      @product_tanks = ProductTank.all  # 모든 레코드를 다시 가져와서 보여줌
      render :index, status: :unprocessable_entity
    end
  end

  def show
    @product_tank = ProductTank.find(params[:id])
  end

  def update
    @product_tank = ProductTank.find(params[:id])

    if @product_tank.update(product_tank_params)
      redirect_to product_tanks_path  # 수정 후 index 페이지로 리디렉션
    else
      @product_tanks = ProductTank.all  # 모든 레코드를 다시 가져와서 보여줌
      render :index, status: :unprocessable_entity
    end
  end

  def destroy
    @product_tanks = ProductTank.find(params[:id])
    @product_tanks.destroy

    redirect_to product_tanks_path
  end

  private
  def product_tank_params
    params.require(:product_tank).permit(:serial, :weight, :capacity, :inspection_date)
  end
end

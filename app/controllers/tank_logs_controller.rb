class TankLogsController < ApplicationController
  before_action :authenticate_user!
  def index
    @pagy, @tank_logs = pagy(TankLog.all)
  end

  def show
    @tank_log = TankLog.find(params[:id])
  end

  def update
    @tank_log = TankLog.find(params[:id])

    if @tank_log.update(tank_log_params)
      redirect_to tank_logs_path  # 수정 후 index 페이지로 리디렉션
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @tank_log = TankLog.find(params[:id])
    @tank_log.destroy

    redirect_to tank_logs_path
  end

  private
  def tank_log_params
    params.require(:product_tank).permit(:serial, :capacity_filled, :moisture_quantity, :purity_analysis)
  end
end

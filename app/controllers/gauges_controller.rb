class GaugesController < ApplicationController
  layout 'edit'  # 레이아웃 비활성화

  def edit
    permitted_params = params.permit(:page)
    @page = 1
    @page = permitted_params[:page].to_i if permitted_params[:page].present?
    @edit = permitted_params[:edit]

    @gauge = Gauge.find_by_tile_id(params[:id])
    if @gauge.nil?
      @gauge = Gauge.new
      @gauge.tile_id = params[:id]
    end
  end

  def update
    @gauge = Gauge.find_by_tile_id(gauge_params[:tile_id].to_i)

    if @gauge.update(gauge_params)
      redirect_to "/gauges/#{gauge_params[:tile_id]}/edit?page=#{gauge_params[:page_id]}"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def create
    def create
      @gauge = Gauge.new(gauge_params)
      if @gauge.save
        redirect_to "/gauges/#{gauge_params[:tile_id]}/edit?page=#{gauge_params[:page_id]}"
      else
        render :edit, status: :unprocessable_entity
      end
    end
  end

  def map
  end

  private
  def gauge_params
    params.require(:gauge).permit(:page_id,
                                  :tile_id,
                                  :name,
                                  :width,
                                  :height,
                                  :min,
                                  :max,
                                  :offset_x,
                                  :offset_y,
                                  :foreground_color,
                                  :background_color,
                                  :modbus_index)

  end
end

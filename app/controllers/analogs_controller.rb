class AnalogsController < ApplicationController
  layout 'edit'  # 레이아웃 비활성화

  def edit
    permitted_params = params.permit(:page)
    @page = 1
    @page = permitted_params[:page].to_i if permitted_params[:page].present?
    @edit = permitted_params[:edit]

    @analog = Analog.find_by_tile_id(params[:id])
    if @analog.nil?
      @analog = Analog.new
      @analog.tile_id = params[:id]
    end
  end

  def update
    @analog = Analog.find_by_tile_id(analog_params[:tile_id].to_i)

    if @analog.update(analog_params)
      redirect_to "/analogs/#{analog_params[:tile_id]}/edit?page=#{analog_params[:page_id]}"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def create
    def create
      @analog = Analog.new(analog_params)
      if @analog.save
        redirect_to "/analogs/#{analog_params[:tile_id]}/edit?page=#{analog_params[:page_id]}"
      else
        render :edit, status: :unprocessable_entity
      end
    end
  end

  def map
  end

  private
  def analog_params
    params.require(:analog).permit(:page_id,
                                    :tile_id,
                                    :name,
                                    :font_size,
                                    :font_color,
                                    :offset_x,
                                    :offset_y,
                                    :align,
                                    :scale,
                                    :modbus_index)

  end
end
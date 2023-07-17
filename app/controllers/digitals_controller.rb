class DigitalsController < ApplicationController
  layout 'edit'  # 레이아웃 비활성화

  def edit
    @digital = Digital.find_by_tile_id(params[:id])
    if @digital.nil?
      @digital = Digital.new
      @digital.tile_id = params[:id]
    end
  end

  def update
    @digital = Digital.find_by_tile_id(digital_params[:tile_id].to_i)

    if @digital.update(digital_params)
      redirect_to "/digitals/#{digital_params[:tile_id]}/edit?page=#{digital_params[:page_id]}"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def create
    def create
      @digital = Digital.new(digital_params)
      if @digital.save
        redirect_to "/digitals/#{digital_params[:tile_id]}/edit?page=#{digital_params[:page_id]}"
      else
        render :edit, status: :unprocessable_entity
      end
    end
  end

  def map
  end

  private
  def digital_params
    params.require(:digital).permit(:page_id,
                                    :tile_id,
                                    :name,
                                    :on,
                                    :off,
                                    :modbus_bit)

  end
end

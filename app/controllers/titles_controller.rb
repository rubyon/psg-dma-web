class TitlesController < ApplicationController
  layout 'edit'  # 레이아웃 비활성화

  def edit
    permitted_params = params.permit(:page)
    @page = 1
    @page = permitted_params[:page].to_i if permitted_params[:page].present?
    @edit = permitted_params[:edit]

    @title = Title.find_by_tile_id(params[:id])
    if @title.nil?
      @title = Title.new
      @title.tile_id = params[:id]
    end
  end

  def update
    @title = Title.find_by_tile_id(title_params[:tile_id].to_i)

    if @title.update(title_params)
      redirect_to "/titles/#{title_params[:tile_id]}/edit?page=#{title_params[:page_id]}"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def create
    def create
      @title = Title.new(title_params)
      if @title.save
        redirect_to "/titles/#{title_params[:tile_id]}/edit?page=#{title_params[:page_id]}"
      else
        render :edit, status: :unprocessable_entity
      end
    end
  end

  def map
  end

  private
  def title_params
    params.require(:title).permit(:page_id,
                                   :tile_id,
                                   :name,
                                   :font_size,
                                   :font_color,
                                   :text,
                                   :offset_x,
                                   :offset_y,
                                   :align,
                                   :scale,
                                   :link)

  end
end
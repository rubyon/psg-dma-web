class ModbusController < ApplicationController
  before_action :authenticate_user!

  def index

    title_ids = Title.pluck(:tile_id)
    digital_ids = Digital.pluck(:tile_id)
    analog_ids = Analog.pluck(:tile_id)
    gauge_ids = Gauge.pluck(:tile_id)

    @tile_ids = (title_ids + digital_ids + analog_ids + gauge_ids).uniq

    permitted_params = params.permit(:edit, :page)
    @page = 1
    @page = permitted_params[:page].to_i if permitted_params[:page].present?
    @edit = permitted_params[:edit]
    # TMX 파일 경로
    tmx_file = File.join(Rails.root, 'public', 'psg-dma-sample','psg-dma.tmx')
    # TMX 파일 읽기
    tmx_data = Tmx.load(tmx_file)

    # 타일셋 정보 출력
    tmx_data.tilesets.each do |tileset|
      puts "Tileset Name: #{tileset.name}"
      puts "First GID: #{tileset.firstgid}"
      puts "Tile Width: #{tileset.tilewidth}"
      puts "Tile Height: #{tileset.tileheight}"
      puts "Tileset Image: #{tileset.image}"
      puts "Tile Count: #{tileset.tilecount}"
      puts "Columns: #{tileset.columns}"
      @tile_image = tileset.image
      @tile_width = tileset.tilewidth
      @tile_height = tileset.tileheight
      puts "---"
    end

    # 타일 맵 데이터 출력
    @layer_data = Array.new
    tmx_data.layers.each_with_index do |layer, index|
      puts "Layer Name: #{layer.name}"
      puts "Layer Width: #{layer.width}"
      puts "Layer Height: #{layer.height}"
      puts "Layer Data: #{layer.data}"
      layer.data.map! { |element| element - 1 }
      hash = { name: layer.name.to_s, width: layer.width.to_i, height: layer.height.to_i, data: layer.data }
      @layer_height = layer.height
      @layer_data[index] ||= []  # 인덱스 위치에 배열 생성 (이미 생성된 경우 무시)
      @layer_data[index] << hash
      puts "---"
    end
  end

end

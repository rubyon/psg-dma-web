module ModbusHelper
  def calculate_background_position(tile_id)
    tmx_file = File.join(Rails.root, 'public', 'psg-dma-sample','psg-dma.tmx')
    # TMX 파일 읽기
    @tile_image = ""
    @tile_width = 0
    @tile_height = 0
    @tile_columns = 0
    tmx_data = Tmx.load(tmx_file)
    tmx_data.tilesets.each do |tileset|
      puts "Tileset Name: #{tileset.name}"
      puts "First GID: #{tileset.firstgid}"
      puts "Tile Width: #{tileset.tilewidth}"
      puts "Tile Height: #{tileset.tileheight}"
      puts "Tileset Image: #{tileset.image}"
      puts "ImageWidth: #{tileset.imagewidth}"
      @tile_image = tileset.image
      @tile_width = tileset.tilewidth
      @tile_height = tileset.tileheight
      @tile_columns = ( tileset.imagewidth / @tile_width )
      puts "---"
    end

    x = ( tile_id % @tile_columns ) * @tile_width
    y = ( tile_id / @tile_columns ) * @tile_width

    "#{-x}px #{-y}px"
  end
end

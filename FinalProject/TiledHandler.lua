-- There are a coupole of sections of code that I got from this youtube video
-- https://www.youtube.com/watch?v=yKk-rODDD8Y&t=665s
-- These sections being the loading of the tiled map 0-1
-- And the drawing the tile map 1-2
-- I did make some changed to the drawing the tile map which made it scroll and
-- only draw the part that were on screen

--0
function loadTiledMap(path)

  local map = require(path)

  local tileset = map.tilesets[1]

  map.tileset = tileset
  map.quads = {}
  map.image = love.graphics.newImage(tileset.image)


  for y=0, (tileset.imageheight/tileset.tileheight) - 1 do
    for x=0, (tileset.imagewidth/tileset.tilewidth) - 1 do
      local quad = love.graphics.newQuad(
        x * tileset.tilewidth,
        y * tileset.tileheight,
        tileset.tilewidth,
        tileset.tileheight,
        tileset.imagewidth,
        tileset.imageheight
        )
        table.insert(map.quads, quad)
    end
  end
--1

  map.yOffSet = map.height * map.tileheight
  map.screenYBottom = map.yOffSet
  map.screenYTop = map.yOffSet - global.h


  function map.scrollTiles()
    map.yOffSet = map.yOffSet - .65
    map.screenYBottom = map.yOffSet
    map.screenYTop = map.yOffSet + global.h

    if map.yOffSet <= global.h then
      map.yOffSet = map.height * map.tileheight
      map.screenYBottom = map.yOffSet - global.h
      map.screenYTop = map.yOffSet + global.h
    end

    if(global.levelReset) then
      map.yOffSet = map.height * map.tileheight
      map.screenYBottom = map.yOffSet
      map.screenYTop = map.yOffSet - global.h
    end

  end

--1
  function map:draw()
    for i, layer in ipairs(self.layers) do
      for y=0, layer.height - 1 do
        for x=0, layer.width - 1  do
          local index = (x + y * layer.width) + 1
          local tid = layer.data[index]

          if tid ~= 0 then
            local quad = self.quads[tid]
            local xx = x * self.tileset.tilewidth
            local yy = y * self.tileset.tileheight + global.h
            if(yy > map.screenYBottom - 55 and yy < map.screenYTop) then
              love.graphics.draw(self.image,quad, xx, yy - map.yOffSet)
            end

          end
        end
      end
    end
  end
--2



  return map
end

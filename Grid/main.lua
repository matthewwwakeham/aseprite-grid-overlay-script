-- main.lua
local sprite = app.activeSprite

if not sprite then
  app.alert("Please open a sprite first!")
  return
end

-- Use Aseprite's built-in grid settings if available, otherwise default to 16x16
local gridW = (sprite.grid.width > 0) and sprite.grid.width or 16
local gridH = (sprite.grid.height > 0) and sprite.grid.height or 16

app.transaction("Apply Pixel Grid and Save", function()
  -- 1. Create a new layer for the grid overlay
  local gridLayer = sprite:newLayer()
  gridLayer.name = "Grid Overlay"

  -- 2. Target the first frame/cel of the new layer
  local cel = sprite:newCel(gridLayer, 1)
  local img = cel.image

  -- 3. Define a semi-transparent dark grid color
  local gridColor = Color{ r = 0, g = 0, b = 0, a = 120 }

  -- 4. Draw vertical grid lines fitting the pixel coordinates
  for x = gridW, sprite.width - 1, gridW do
    for y = 0, sprite.height - 1 do
      img:putPixel(x, y, gridColor)
    end
  end

  -- 5. Draw horizontal grid lines fitting the pixel coordinates
  for y = gridH, sprite.height - 1, gridH do
    for x = 0, sprite.width - 1 do
      img:putPixel(x, y, gridColor)
    end
  end
end)

-- Refresh the editor view to show changes
app.refresh()

-- Trigger the save command
app.command.SaveFile()
--[[
    Fantasy Brawl
    Author: Jacopo Rossi
    CS50 final project
]]

-- takes a texture, width, and height of tiles and splits it into quads that can be individually drawn
function GenerateQuads(sheet, tilewidth, tileheight)
    local sheetWidth = sheet:getWidth() / tilewidth
    local sheetHeight = sheet:getHeight() / tileheight

    local sheetCounter = 1
    local quads = {}

    for y = 0, sheetHeight - 1 do
        for x = 0, sheetWidth - 1 do
            -- this quad represents a square cutout of our sheet that we can
            -- individually draw instead of the whole sheet
            quads[sheetCounter] =
                love.graphics.newQuad(x * tilewidth, y * tileheight, tilewidth,
                tileheight, sheet:getDimensions())
            sheetCounter = sheetCounter + 1
        end
    end

    return quads
end
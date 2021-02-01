Menu = Class{}

function Menu:init(def)
    self.index = 1
    -- takes in a table describing the options to display
    self.def = def
end

function Menu:update()
    if love.keyboard.PressedThisFrame(DOWN) then
        self.def[self.index].color = CARMINE
        self.index = math.max(1, (self.index + 1) % (#self.def + 1))
        self.def[self.index].color = SIENNA
    elseif love.keyboard.PressedThisFrame(UP) then
        self.def[self.index].color = CARMINE
        self.index = math.abs(math.min(-3, (-self.index - 1) % 4))
        self.def[self.index].color = SIENNA
    end
end

function Menu:getIndex()
    return self.index
end

function Menu:render()
    for k, v in pairs(self.def) do
        love.graphics.printf({v.color, v. string}, v.font, v.x, v.y, v.limit, v.align)
    end
end
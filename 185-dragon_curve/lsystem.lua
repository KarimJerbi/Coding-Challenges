-- #185 Tic Tac Toe - Karim Jerbi(@KarimJerbi)

LSystem = {}
LSystem.__index = LSystem

function LSystem:new(axiom, rules)
    local self = setmetatable({}, LSystem)
    self:initialize(axiom, rules)
    return self
end

function LSystem:initialize(axiom, rules)
    self.sentence = axiom
    self.ruleset = rules
end

function LSystem:generate()
    local nextgen = ""
    for i = 1, #self.sentence do
        local c = string.sub(self.sentence, i, i)
        if self.ruleset[c] then
            nextgen = nextgen .. self.ruleset[c]
        else
            nextgen = nextgen .. c
        end
    end
    self.sentence = nextgen
end

return LSystem

function switch(value, ...)
    local cases = arg
    local callers = {}
    for _, case in ipairs(cases) do
        local name, func = case()
        callers[name] = func
    end
    if callers[value] then
        callers[value]()
    elseif callers['default'] then
        callers['default']()
    end
end

function case(name, func)
    return function() return name, func end
end

function toboolean(value)
    return switch(value, 
        case('1', function()
            return true
        end),
        case('true', function()
            return true
        end),
        case(1, function()
            return true
        end),
        case('default', function()
            return false
        end)
    )
end

local Utils = {}

function Utils:getInput(mensagem, tipo)
    if mensagem then
        print(mensagem)
    end
    if (tipo and (tipo ~= 'number' and
                  tipo ~= 'string' and
                  tipo ~= 'boolean'))
    then
        error('Tipo inválido, tipos válidos: number, boolean')
    end
    local result = io.read()
    if tipo then
        switch(tipo,
            case('boolean', function ()
                result = toboolean(result)
            end),
            case('number', function()
                result = tonumber(result)
            end)
        )
    end
    if result == nil then
        return self:getInput(mensagem, tipo)
    end
    return result
end

local r = Utils:getInput('Entre um boolean', 'boolean')
print(r, type(r))
return Utils
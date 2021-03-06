local utf8 = require 'utf8'

function deepcopy(orig) -- http://lua-users.org/wiki/CopyTable
    local orig_type = type(orig)
    local copy
    if orig_type == 'table' then
        copy = {}
        for orig_key, orig_value in next, orig, nil do
            copy[deepcopy(orig_key)] = deepcopy(orig_value)
        end
        setmetatable(copy, deepcopy(getmetatable(orig)))
    else -- number, string, boolean, etc
        copy = orig
    end
    return copy
end

function concattables(a, b)
    local nt = deepcopy(a)
    for _, i in ipairs(b) do
        table.insert(nt, b)
    end
    return nt
end

function mergetables(a, b)
    local nt = deepcopy(a)
    for k, i in pairs(b) do
        nt[k] = i
    end
    return nt
end

function table.trim(t, s, e)
    local h = {}
    if not e then
        e = #t
    end
    for i=s,e do
        table.insert(h, t[i])
    end
    return h
end

function string.starts(str, thing)
    return string.sub(str, 0, #thing) == thing
end

function string.ends(str, thing)
    return string.sub(str, -#thing) == thing
end

function math.clamp(n, low, high) return math.min(math.max(n, low), high) end

local rsCharset = '0123456789abcdef'

function randomString(len)
    local o = ''
    for i=1,len do
        local ran = love.math.random(1,#rsCharset)
        o = o .. string.sub(rsCharset, ran, ran) -- this is terrible
    end
    return o
end

function utf8.sub(str, start, ennd)
    return utf8.char(utf8.codepoint(str, start, ennd or utf8.len(str)))
end

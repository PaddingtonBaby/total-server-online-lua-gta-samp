script_name('ServerOnline')
script_author('medved')

local res = pcall(require, 'lib.moonloader')
assert(res, 'Lib MOONLOADER not found!')

local font = nil

function join_argb(a, r, g, b)
    local argb = b
    argb = bit.bor(argb, bit.lshift(g, 8))
    argb = bit.bor(argb, bit.lshift(r, 16))
    argb = bit.bor(argb, bit.lshift(a, 24))
    return argb
end

function getTotalPlayers()
    local count = 0
    local maxId = sampGetMaxPlayerId(false)
    for id = 0, maxId do
        if sampIsPlayerConnected(id) then
            count = count + 1
        end
    end
    return count + 1
end

function main()
    while not isSampAvailable() do
        wait(0)
    end

    -- Параметры шрифта
    font = renderCreateFont("Arial", 12, 1)
    local colorTag = '{' .. bit.tohex(join_argb(200, 255, 255, 255)) .. '}'

    local totalPlayers = getTotalPlayers()
    local lastUpdateTime = os.time()

    while true do
        wait(0)

        -- Задержка на скрипте при пересчете - 5 секунд. Если нужно больше - менять в большую сторону.
        if os.time() - lastUpdateTime >= 5 then
            totalPlayers = getTotalPlayers()
            lastUpdateTime = os.time()
        end

        -- Отрисовка строки
        renderFontDrawText(
            font,
            colorTag .. 'online: ' .. tostring(totalPlayers),
            10,  -- X: 10
            10,  -- Y: 10
            -1
        )
    end
end

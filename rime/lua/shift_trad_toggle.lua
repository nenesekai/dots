-- 單擊 Shift 切換簡繁（traditionalization 開關）
-- 邏輯仿照 ascii_composer：按下 Shift 後沒有按其他鍵、且很快鬆開，才算一次「單擊」。
-- 這樣 Shift+字母、Shift+符號、Ctrl+Shift+X 等組合鍵都不會誤觸發。

local OPTION = "traditionalization"
local SHIFT_L, SHIFT_R = 0xffe1, 0xffe2
local MAX_HOLD_SECONDS = 1 -- os.time() 精度為秒，長按超過約 1 秒不算單擊
local kNoop = 2

local P = {}

function P.init(env)
    env.armed = false
    env.pressed_at = 0
end

function P.func(key, env)
    local code = key.keycode
    if code ~= SHIFT_L and code ~= SHIFT_R then
        env.armed = false -- 中途按了別的鍵，取消
        return kNoop
    end

    if not key:release() then
        -- 與其他修飾鍵一起按下時不算
        env.armed = not (key:ctrl() or key:alt() or key:super())
        env.pressed_at = os.time()
        return kNoop
    end

    if env.armed then
        env.armed = false
        local ctx = env.engine.context
        if os.time() - env.pressed_at <= MAX_HOLD_SECONDS and not ctx:get_option("ascii_mode") then
            ctx:set_option(OPTION, not ctx:get_option(OPTION))
        end
    end
    return kNoop
end

return P

local M = {}

local function random_string(length)
    local res = ""
    for i = 1, length do
        res = res .. string.char(math.random(97, 122))
    end
    return res
end

animator = {
    index = 0,
    animations = {},
    labels = {},
    on_completed = function()
    end,
    animate = function()
        animator.index = animator.index + 1

        local animation = animator.animations[animator.index]
        local callback = animator.on_completed

        if animator.index + 1 <= #animator.animations then
            callback = function()
                animation.turns = animation.turns - 1
                if animation.turns <= 0 then
                    animator.animate()
                end
            end
        end

        local animations = animation.animations

        for i, animation in ipairs(animations) do
            go.animate(
                animation.hash,
                animation.property,
                animation.playback,
                animation.to,
                animation.easing,
                animation.duration,
                animation.delay,
                callback
            )
        end
    end
}

function M.new()
    local this = {}

    this.play = function()
        animator.animate()
    end

    this.debug = function()
        pprint(animator.animations)
    end

    this.on_completed = function(callback)
        animator.on_completed = callback
    end

    this.add = function(url, property, playback, to, easing, duration, label, delay)
        label = label or random_string(5)

        local func = {
            property = property,
            to = to,
            label = label,
            hash = url,
            playback = playback or go.PLAYBACK_ONCE_FORWARD,
            easing = easing or go.EASING_LINEAR,
            duration = duration or 0,
            delay = delay or 0
        }

        local animation = nil

        function get_animation(animations, i, l)
            if i > #animations then
                return nil
            elseif animations[i].label == l then
                return animations[i]
            end
            return get_animation(animations, i + 1, l)
        end

        animation = get_animation(animator.animations, 1, label)

        if animation == nil then
            animation = {
                animations = {
                    func
                },
                label = label,
                turns = 1
            }
            table.insert(animator.animations, animation)
        else
            table.insert(animation.animations, func)
            animation.turns = #animation.animations
        end

        return this
    end

    return this
end

return M

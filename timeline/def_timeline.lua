local M = {}

local function randomString(length)
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
    animate = function()
        animator.index = animator.index + 1

        local callback = nil

        local animation = animator.animations[animator.labels[animator.index]]
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
}

function M.new()
    this = {}
    local set_position = function(hash, property, to)
        go.set_position(to, hash)
        return this
    end

    local set_rotation = function(hash, to)
        go.set_rotation(hash, to)
        return this
    end

    this.play = function()
        animator.animate()
    end

    this.debug = function()
        pprint(animator.animations)
    end

    this.add = function(url, property, playback, to, easing, duration, label, delay)
        label = label or randomString(5)

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

        if #animator.animations > 0 then
            function get_animation(animations, i, l)
                if i > #animations then
                    return nil
                elseif animations[i].label == l then
                    return animations[i]
                end
                return get_animation(animations, i + 1, l)
            end

            animation = get_animation(animator.animations, 1, label)
        end

        if animation == nil then
            animation = {
                animations = {
                    func
                },
                label = label
            }
        else
            table.insert(a.animations, func)
        end

        table.insert(animator.animations, animation)
        return this
    end

    return this
end

return M

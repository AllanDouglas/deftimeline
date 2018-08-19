local M = {}

local silent_func = function()
end

local function random_string(length)
    local res = ""
    for i = 1, length do
        res = res .. string.char(math.random(97, 122))
    end
    return res
end

function M.new()
    local this = {
        paused = true,
        index = 0,
        animations = {},
        labels_functions = {},
        labels = {},
        current_label = "",
        completed = function()
        end
    }

    function animate(animator)
        if animator.paused then
            return
        end

        animator.index = animator.index + 1

        local animation = animator.animations[animator.index]

        animator.current_label = animation.label

        local callback = function()
            if animator.paused == false then
                animator.paused = true
                animator.completed()
            end
        end

        if animator.index + 1 <= #animator.animations then
            callback = function()
                animation.turns = animation.turns - 1
                if animation.turns <= 0 then
                    local func = animator.labels_functions[animator.current_label] or silent_func
                    func()
                    animate(animator)
                end
            end
        end

        local animations = animation.animations

        for i, animation in ipairs(animations) do
            go.animate(
                animation.url,
                animation.property,
                animation.playback,
                animation.to,
                animation.easing,
                animation.duration,
                animation.delay,
                function()
                    animation.on_completed()
                    callback()
                end
            )
        end
    end

    this.play = function()
        this.paused = false
        animate(this)
    end

    this.debug = function()
        pprint(this.animations)
    end

    this.on_completed = function(callback)
        this.completed = callback
    end

    this.add_end_label = function(label, callback)
        this.labels_functions[label] = callback
    end

    this.add_from_payload = function(payload)
        this.add(
            payload.url,
            payload.property,
            payload.playback,
            payload.to,
            payload.easing,
            payload.duration,
            payload.delay,
            payload.on_completed,
            payload.label
        )
    end

    this.add = function(url, property, playback, to, easing, duration, delay, on_completed, label)
        label = label or random_string(5)

        local func = {
            property = property,
            to = to,
            label = label,
            url = url,
            playback = playback or go.PLAYBACK_ONCE_FORWARD,
            easing = easing or go.EASING_LINEAR,
            duration = duration or 0,
            delay = delay or 0,
            on_completed = on_completed or silent_func
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

        animation = get_animation(this.animations, 1, label)

        if animation == nil then
            animation = {
                animations = {
                    func
                },
                label = label,
                turns = 1
            }
            table.insert(this.animations, animation)
        else
            table.insert(animation.animations, func)
            animation.turns = #animation.animations
        end

        return this
    end

    return this
end

return M

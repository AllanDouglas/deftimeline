local M = {}

function M.new()
    local this = {
        functions = {}
    }

    local set_position = function(hash, property, to)
        go.set_position(to, hash)
        return this
    end

    local set_rotation = function(hash, to)
        go.set_rotation(hash, to)
        return this
    end

    this.to_position = function(url, property, playback, to, easing, duration, delay)
        return this
    end

    this.from_position = function()
        return this
    end

    this.from_to_position = function()
        return this
    end

    this.to_rotation = function()
        return this
    end

    this.from_rotation = function()
        return this
    end

    this.fromToRotation = function()
        return this
    end

    return this
end

return M

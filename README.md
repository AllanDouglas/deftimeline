# Def Timeline

## Installation

You can use Timeline in your own project by adding this project as a Defold library dependency. Open your game.project file and in the dependencies field under project add:

https://github.com/AllanDouglas/deftimeline/archive/master.zip

Once added you may require either (or both) of the two main lua

```lua
local timeline = require("timine.def_timeline")
```

Easy way to make animation play in sequence 
like this:

```lua

    local timeline = require("timeline.def_timeline")

    local t = timeline.new()
	t.add(".", "position.x", nil, 150, nil, 2)
	t.add(".", "position.y", nil, 150, nil, 2)
	t.add(".", "position.y", nil, 0, nil, 2)
	
	t.play()
```

You can use labels to play animations together


```lua
    local timeline = require("timeline.def_timeline")

    local t = timeline.new()
	t.add(".", "position.x", nil, 150, nil, 2,'label_1')
	t.add(".", "position.y", nil, 150, nil, 2, 'label_1')
	t.add(".", "position.y", nil, 0, nil, 2)	
	t.play()
```

### Callbacks
    > On Completed timeline

```lua
    local timeline = require("timeline.def_timeline")

    local t = timeline.new()
	t.add(".", "position.x", nil, 150, nil, 2,'label_1')
	t.add(".", "position.y", nil, 150, nil, 2, 'label_1')
	t.add(".", "position.y", nil, 0, nil, 2)
	t.on_completed(
		function()
			print('the end')
		end
	)
	t.play()


```


# Def Timeline
Easy way to make animation play in sequence to Defold Engine

## Installation

You can use Timeline in your own project by adding this project as a Defold library dependency. Open your game.project file and in the dependencies field under project add:

https://github.com/AllanDouglas/deftimeline/archive/master.zip

Once added you may require either (or both) of the two main lua

```lua
local timeline = require("timine.def_timeline")
```

### Add Animation

timeline.add(url, property, playback, to, easing, duration, delay, on_completed, label)

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
t.add(".", "position.x", nil, 150, nil, 2, nil,'label_1')
t.add(".", "position.y", nil, 150, nil, 2, nil, 'label_1')
t.add(".", "position.y", nil, 0, nil, nil, 2)	
t.play()
```

### Add animation from playloads

you can use a table with then arguments names to add a animation

```lua
t.add_from_payload({
	property = "rotation",
	to = vmath.quat_rotation_z(3.141592 / 4),
	label = "label_1",
	url = ".",
	duration = 1
})

```


### Callbacks
    
#### On Complete the timeline

```lua
local timeline = require("timeline.def_timeline")

local t = timeline.new()
t.add(".", "position.x", nil, 150, nil, 2, nil,'label_1')
t.add(".", "position.y", nil, 150, nil, 2, nil, 'label_1')
t.add(".", "position.y", nil, 0, nil, 2)
t.on_completed(
	function()
		print('the end')
	end
)
t.play()
```
#### On Complete the label

```lua
t.add_end_label("test", function()
pprint("the test label over")
end)
```



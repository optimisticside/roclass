<center> <h1>Roclass</h1></center>
Roclass is a simple framework for object-oriented programming written in lua. It supports class extension, properties, and provides a clean interface.

## Usage
When the Roclass module is required, it will return a class-creation function. There is no need to pass any parameters to this function, but the first parameter is for the class's name. This is useful for when printing an object of the class.
```lua
local MyClass = class("MyClass")
```
Any super-classes of the class can also be added by adding them to the parameters.
```lua
local MyClass = class("MyClass", MyOtherClass)
```
Once you've created a class, you can treat it just as you would for a normal table, and declare members and functions. On the object construction function, you would want to call the class's `create` function, which will create the object and initialize it with the initial information you give it.
```lua
function MyClass.new(name)
	local self = MyClass:create({
		name = name
	})

	return self
end
```
## Properties

Roclass also supports properties. Properties are basically members of an object that are accessed and changed by functions. These can be declared by adding a function that begins with `get`
```lua
function MyClass:getTime()
	return self._time or tick()
end
```
Now that there is a `getTime` function, when someone tries to access a member called `time`, the function will be called.
```lua
local myObject = MyClass.new()
local currentTime = myObject.time
```
You can also create function that begin with `set` for changing members
```lua
function MyClass:setTime(newTime)
	self._time = newTime
end
```
Be sure not to try to access or modify any of these properties while inside of these functions, as they will result in a stack overflow.

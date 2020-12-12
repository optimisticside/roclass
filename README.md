<center> <h1>Roclass</h1></center>
Roclass is an extremely lightweight, simple framework for object-oriented programming written in lua. It supports class extension, properties, and provides a clean interface.

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
## Metamethods
Roclass also allows you to overload meta-methods. This can be done by simply setting the meta-method into the class table.
```lua
function MyClass:__tostring()
	return "MyClass"
end
```
You are also allowed to overload the `__index` and `__newindex` meta-methods, but this may disable some functionality (since they are used internally).
## Basetable
The base-table is the table passed when constructing an object. It is meant to be treated as a normal table, and to be used for adding members to an object upon creation. But, these can also be used for passing internal information. To add meta-methods to a created object, the special `_meta` index can be used as a table of meta-methods to be added. To add class extensions, the `_extends` method can be used as an array of super-classes to be extended from.
```lua
function MyClass.new(name)
	local self = class({
		_meta = {
			__tostring = function(self)
				return self.name
			end
		},
		_extends = {MyOtherClass}
	})
	
	return self
end
```

## FAQ

**My class already has a function called `create`, how do I use it without it interfering with Roclass's injected `create` function.**
This can be done by changing the value of the `create` index in the class to someting else, and then using that function to create the class instead.
```lua
local MyClass = class("MyClass")
MyClass.construct = MyClass.create

function MyClass:create()
	print("Created an object")
end

function MyClass.new(name)
	local self = MyClass:construct({
		name = name
	})

	return self
end
```
**My class already has members in the base-table called `_base` or `extend` and I do not want to use these methods. What can I do?**
There is another feature of base-tables for disabling all this. You can set `_disableInternal` to `true`, and these special members will be disabled. If you are *also* using `_disableInternal`, then just change it after you've used the `create` function.
```lua
function MyClass.new(name)
	local self = MyClass:create({
		_disableInternal = true,
	})
end
```

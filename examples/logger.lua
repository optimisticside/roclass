local ReplicatedStorage = game:GetService("ReplicatedStorage")
local class = require(ReplicatedStorage.Class)

local Logger = class("Logger")

function Logger:addLog(message, isErr)
    local log = {
        message = message,
        isError = isErr,
        timestamp = tick()
    }
    
    self._logs[#self._logs+1] = log
    return log
end

function Logger:log(message, isErr)
    (isErr and self.printer or self.errorer)(msg)
    return self:addLog(message, isErr)
end

function Logger:getLogs()
    return self._logs
end

function Logger.new(printFunc, errFunc)
    local self = Logger:create({
        _logs = {},
        printer = printFunc,
        errorer = errFunc
    })
    
    return self
end

return Logger

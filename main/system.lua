local DebugUtils = {}
do
	-- Print a normal message with a [DEBUG] tag
	function DebugUtils.Print(message)
		print("[DEBUG] "..tostring(message))
	end

	-- Print a warning message
	function DebugUtils.Warn(message)
		warn("[DEBUG WARNING] "..tostring(message))
	end

	-- Print an error message
	function DebugUtils.Error(message)
		error("[DEBUG ERROR] "..tostring(message))
	end

	-- Pretty-print a table
	function DebugUtils.PrintTable(tbl, indent)
		indent = indent or 0
		for k, v in pairs(tbl) do
			local formatting = string.rep("  ", indent) .. tostring(k) .. ": "
			if type(v) == "table" then
				print(formatting)
				DebugUtils.PrintTable(v, indent + 1)
			else
				print(formatting .. tostring(v))
			end
		end
	end

	-- Safe wait function (ignores executor yield issues)
	function DebugUtils.SafeWait(time)
		local t0 = tick()
		repeat task.wait() until tick() - t0 >= (time or 0)
	end

	-- Check if a global exists
	function DebugUtils.GlobalExists(name)
		return getgenv()[name] ~= nil
	end

	-- Dump all globals for debugging
	function DebugUtils.DumpGlobals()
		for k, v in pairs(getgenv()) do
			print(k, v)
		end
	end

	-- Execute a function safely with pcall
	function DebugUtils.SafeCall(func, ...)
		local success, result = pcall(func, ...)
		if not success then
			warn("[DEBUG SafeCall Error]: "..tostring(result))
		end
		return success, result
	end

	-- Print the current call stack
	function DebugUtils.StackTrace()
		print(debug.traceback("[DEBUG STACK TRACE]", 2))
	end
end
return DebugUtils

local add, now = MiniDeps.add, MiniDeps.now

now(function()
	add("echasnovski/mini.notify")

	local notify = require("mini.notify")
	notify.setup()
	
	vim.notify = notify.make_notify({
		ERROR = { duration = 20000 },
		WARN  = { duration = 20000 },
		INFO  = { duration = 5000 },
		DEBUG = { duration = 0 },
		TRACE = { duration = 0 },
		OFF   = { duration = 0 },
	})
end)

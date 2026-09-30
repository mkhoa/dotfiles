hl.workspace_rule({ workspace = "name:game", monitor = PRIMARY_MONITOR, default = true })
hl.workspace_rule({ workspace = "1", monitor = "DP-1", persistent = true })
hl.workspace_rule({ workspace = "2", monitor = "DP-1", persistent = true })

hl.workspace_rule({
	workspace = "1",
	layout = "scrolling",
})

hl.workspace_rule({
	workspace = "2",
	layout = "dwindle",
})

hl.workspace_rule({
	workspace = "3",
	layout = "dwindle",
})

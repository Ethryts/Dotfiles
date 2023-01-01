-- Initialize the components table
local components = {
    active = {},
    inactive = {}
}


vi_mode = {
    name = 'file_info',
    opts = {
        type = 'unique',
        file_modified_icon = 'M'
    }
}

-- Insert three sections (left, mid and right) for the active statusline
table.insert(components.active, {})
table.insert(components.active, {})
table.insert(components.active, {})

-- Insert two sections (left and right) for the inactive statusline
table.insert(components.inactive, {})
table.insert(components.inactive, {})


-- Insert a component that will be on the left side of the statusline
-- when the window is active:
table.insert(components.active[1], {
    provider = vi_mode,

})

-- Insert another component that will be on the left side of the statusline
-- when the window is active:
table.insert(components.active[1], {
    -- Component info here
})

-- Insert a component that will be on the middle of the statusline
-- when the window is active:
table.insert(components.active[2], {
    -- Component info here
})

-- Insert a component that will be on the right side of the statusline
-- when the window is active:
table.insert(components.active[3], {
    -- Component info here
})

-- Insert a component that will be on the left side of the statusline
-- when the window is inactive:
table.insert(components.inactive[1], {
    -- Component info here
})

-- Insert a component that will be on the right side of the statusline
-- when the window is inactive:
table.insert(components.inactive[2], {
    -- Component info here
})





require('feline').setup {
    --default_bg = colors.bg,
--    default_fg = colors.fg,
    --components = components,
  --  properties = properties,
   -- vi_mode_colors = vi_mode_colors
}

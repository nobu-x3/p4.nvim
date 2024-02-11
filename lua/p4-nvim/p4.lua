local M = {}

debug_print_enabled = false

local function split(inputstr, sep)
    if sep == nil then
        sep = "%s"
    end
    local t = {}
    for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
        table.insert(t, str)
    end
    return t
end

local function debug_print(msg)
    if debug_print_enabled then
        print(msg)
    end
end

local function get_pending_changelists(data)
    debug_print("\nGET PENDING CHANGELISTS\nDATA:\n")
    debug_print(data)
    local lines = split(data, '\n')
    debug_print("\nFIRST SPLIT\n")
    debug_print(vim.inspect(lines))
    local nums = {}
    debug_print("\nLINES:\n")
    for i, v in ipairs(lines) do
        debug_print(i .. "\t" .. v .. '\n')
        local words = split(v)
        nums[i] = words[2]
    end
    return nums
end

local changelist_number = -1

local function ask_changelist_number()
    local job = vim.fn.system('p4 changes -s pending')
    debug_print(job)
    local nums = get_pending_changelists(job)
    local prompt = "Enter changelist you wish to work in:\n"
    for cl, name in ipairs(nums) do
        prompt = prompt .. cl .. ":\t" .. name .. "\n"
    end
    vim.ui.input({ prompt = prompt }, function(input)
        changelist_number = tonumber(input)
    end)
    return nums[changelist_number]
end

function M.checkout()
    local cl_num = ask_changelist_number()
    local bufname = vim.fn.bufname()
    local cmd = "p4 edit -c " .. tostring(cl_num) .. " " .. bufname
    debug_print(cmd)
    local job = vim.fn.system(cmd)
    vim.notify("\n" .. job)
end

function M.changelists()
    local job = vim.fn.system('p4 changes -s pending')
    debug_print(job)
    local nums = get_pending_changelists(job)
    debug_print("\nAFTER GETTING PENDING CHANGELISTS\n")
    vim.notify(vim.inspect(nums))
end

function M.add()
    local cl_num = ask_changelist_number()
    local bufname = vim.fn.bufname()
    local cmd = 'p4 add -d -f -c ' .. tostring(cl_num) .. " " .. bufname
    local job = vim.fn.system(cmd)
    vim.notify("\n" .. job)
end


return M

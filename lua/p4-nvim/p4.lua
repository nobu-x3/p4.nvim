local M = {}

local function split (inputstr, sep)
        if sep == nil then
                sep = "%s"
        end
        local t={}
        for str in string.gmatch(inputstr, "([^"..sep.."]+)") do
                table.insert(t, str)
        end
        return t
end


local function print_stdout(chan_id, data, name)
    print("stdout:")
    print(data[1])
end

function get_latest_changelist_nr(data)
    local words = split(data[1])
    local num = tonumber(words[2])
    return num
end

function checkout_callback(chan_id, data, name)
    local bufname = vim.fn.bufname()
    local num = get_latest_changelist_nr(data)
    if not num == nil then
        local cmd = "p4 edit -c " .. tostring(num) .. " " .. bufname
        print(cmd)
        vim.fn.jobstart(cmd, {on_stdout = print_stdout})
    end
end

function M.checkout()
    print("checkout")
    vim.fn.jobstart('p4 changelists', {on_stdout = checkout_callback})
    --
    -- local obj = vim.system({'echo', 'hello'}, { text = true }):wait()
    -- local obj = vim.system({'p4', 'changelists'}, {stdout = true}):wait()
    -- print(obj.stdout)
end

local function add_callback(chan_id, data, name)
    local bufname = vim.fn.bufname()
    local num = get_latest_changelist_nr(data)
    local cmd = 'p4 add -d -f -c ' .. num .. " " .. bufname
    vim.fn.jobstart(cmd, {on_stdout = print_stdout})
end

function M.add()
    vim.fn.jobstart('p4 changelists', {on_stdout = add_callback})
end
return M

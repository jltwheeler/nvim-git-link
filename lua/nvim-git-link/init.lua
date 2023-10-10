local function strip_string_whitespace(str)
  local s = string.gsub(str, '^%s+', '')
  s = string.gsub(s, '%s+$', '')
  s = string.gsub(s, '[\n\r]+', ' ')
  return s
end

local function split_string(str, delimeter, index)
  local pattern = '([^' .. delimeter .. ']+)'
  local result = {}
  for word in string.gmatch(str, pattern) do
    table.insert(result, word)
  end
  return result[index]
end

local function run_shell_command(cmd, is_multiline_stdout)
  local f = assert(io.popen(cmd, 'r'))

  if is_multiline_stdout then
    -- Return multiline stdout as array of strings
    return f:lines()
  else
    local s = assert(f:read('*a'))
    f:close()
    return strip_string_whitespace(s)
  end
end

local function is_linux()
  local op_system = run_shell_command("uname -s", false)
  if op_system == 'Linux' then
    return true
  else
    return false
  end
end

local function open_browser(url)
  if is_linux() then
    run_shell_command("xdg-open " .. url .. ' 1>/dev/null 2>/dev/null', false)
  else
    run_shell_command("open " .. url, false)
  end
end

local function get_remote_link(opts)
  local opts = opts or { open_browser = true }

  local is_not_git_repo = string.find(run_shell_command("git status 2>&1", false), 'fatal')

  if is_not_git_repo then
    print('Oops, this is not a git repo')
    return
  end

  local is_git_file = false
  local root_dir = run_shell_command("git rev-parse --show-toplevel", false)
  local file_dir = vim.fn.expand("%:p")
  local files = run_shell_command("git ls-files --full-name root_dir " .. root_dir, true)
  local file_name = ""

  for file in files do
    local abs_path = root_dir .. '/' .. file
    if abs_path == file_dir then
      is_git_file = true
      file_name = file
    end
  end
  if not is_git_file then
    print('This file is not tracked in the remote repo')
    return
  end

  local line = vim.fn.line('.')
  local hash = run_shell_command("git rev-parse HEAD", false)
  local url = run_shell_command("git config --get remote.origin.url", false)
  local endpoint = split_string(url, ':', 2)
  endpoint = 'https://github.com/' .. endpoint .. '/blob/' .. hash .. '/' .. file_name .. '#L' .. line

  if opts.open_browser then
    open_browser(endpoint)
  end
  if opts.copy then
    vim.fn.setreg("+", endpoint)
  end
end

return {
  get_remote_link = get_remote_link
}

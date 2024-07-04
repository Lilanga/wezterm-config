local platform = require('utils.platform')()

local options = {
   default_prog = {},
   launch_menu = {},
}

if platform.is_win then
   options.default_prog = { 'nu' }
   options.launch_menu = {
      { label = 'PowerShell Desktop', args = { 'powershell', '-NoLogo' } },
      { label = 'PowerShell Core', args = { 'pwsh', '-NoLogo' } },
      { label = 'Command Prompt', args = { 'cmd' } },
      { label = 'Nushell', args = { 'nu' } },
      {
         label = 'Git Bash',
         args = { 'C:/Program Files/Git/bin/bash.exe' },
      },
      {
         label = 'WSL Ubuntu',
         args = { 'wsl', 'bash' },
      },
      { label = 'Yori', args = { 'C:/Users/lilan/AppData/Local/Yori/Yori.exe' } }, 
      { label = 'Python', args = { 'python' } },
      { label = 'Node.js', args = { 'node' } },
      { label = 'Deno', args = { 'deno' } },
   }
elseif platform.is_mac then
   options.default_prog = { '/opt/homebrew/bin/fish', '-l' }
   options.launch_menu = {
      { label = 'Bash', args = { 'bash', '-l' } },
      { label = 'Fish', args = { '/opt/homebrew/bin/fish', '-l' } },
      { label = 'Nushell', args = { '/opt/homebrew/bin/nu', '-l' } },
      { label = 'Zsh', args = { 'zsh', '-l' } },
   }
elseif platform.is_linux then
   options.default_prog = { 'fish', '-l' }
   options.launch_menu = {
      { label = 'Bash', args = { 'bash', '-l' } },
      { label = 'Fish', args = { 'fish', '-l' } },
      { label = 'Zsh', args = { 'zsh', '-l' } },
   }
end

return options

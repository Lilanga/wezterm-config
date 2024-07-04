return {
   -- ref: https://wezfurlong.org/wezterm/config/lua/SshDomain.html
   ssh_domains = {
      {
         name = 'RPI1',
         remote_address = '192.168.1.21',
         username = 'pi',
      },
      {
         name = 'RPI2',
         remote_address = '192.168.1.22',
         username = 'pi',
      },
      {
         name = 'RPI3',
         remote_address = '192.168.1.23',
         username = 'pi',
      },
      {
         name = 'RPI4',
         remote_address = '192.168.1.24',
         username = 'pi',
      },
   },

   -- ref: https://wezfurlong.org/wezterm/multiplexing.html#unix-domains
   unix_domains = {},

   -- ref: https://wezfurlong.org/wezterm/config/lua/WslDomain.html
   wsl_domains = {
      {
         name = 'WSL:Ubuntu',
         distribution = 'Ubuntu',
         username = 'lilanga',
         default_cwd = '/home/lilanga',
         default_prog = { 'fish', '-l' },
      },
   },
}

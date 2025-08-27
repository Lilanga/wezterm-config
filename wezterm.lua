local Config = require('config')

require('utils.backdrops'):set_files():random()

require('events.right-status').setup()
require('events.left-status-tab').setup()
require('events.left-status').setup()
-- require('events.tab-title').setup()  -- Disabled in favor of left-status-tab
require('events.new-tab-button').setup()

return Config:init()
   :append(require('config.appearance'))
   :append(require('config.bindings'))
   :append(require('config.domains'))
   :append(require('config.fonts'))
   :append(require('config.general'))
   :append(require('config.launch')).options

###
Load in config.coffee from /config and then overwrite with the contents of config-<env>.coffee
###

env = process.env.APP_ENV || "dev"
global.env = env
global.config = require "./config/config-#{env}.coffee"

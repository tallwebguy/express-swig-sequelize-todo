fs = require "fs"
path = require "path"
async = require "async"

#go into the modules directory and include everything in there..
class ModLoader

	getFiles : () =>
		return fs.readdirSync path.join __dirname, "modules"
	
	configure : (app, next) =>
		modules = []
		files = @.getFiles()
		for f in files
			file = path.join __dirname, "modules", f
			stat = fs.statSync file
			if stat.isDirectory()
				console.log "Loading : #{file}"
				modules[f] = require file
				try
					modules[f].configure app
				catch error
					console.log "Could not load : #{f}"
					console.log error
					process.exit 1
		next()

module.exports = ModLoader

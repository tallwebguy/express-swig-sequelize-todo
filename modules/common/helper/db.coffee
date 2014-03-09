seq = require "sequelize"

logging = false
logging = console.log if global.config.site.verbose_db
connectionString = "postgres://#{global.config.database.username}:#{global.config.database.password}@#{global.config.database.host}:#{global.config.database.port}/#{global.config.database.db}"
Seq = new seq connectionString, {
	dialect : "postgres"
	logging : logging
	define : 
		underscored : true,
		timestamps : false
	pool: { maxConnections: 2, maxIdleTime: 30 }
}

module.exports = Seq
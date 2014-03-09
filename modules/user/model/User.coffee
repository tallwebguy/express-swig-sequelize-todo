crypto = require "crypto"
sha1 = require "sha1"

user = (db, seq) =>
	db.define "usr", {
		#minimum information
		id :
			type : seq.INTEGER
			autoIncrement : true
			primaryKey : true
		email :
			type : seq.TEXT
			allowNull : false
		password :
			type : seq.TEXT
			allowNull : false
		salt :
			type : seq.TEXT
			allowNull : false
	}, {
		setterMethods :
			password : (passwd) ->
				@.salt = crypto.randomBytes(48).toString('base64').substring(0, saltLen)
				@.password = sha1(@.salt+":"+passwd)
				return @
	}

module.exports = user
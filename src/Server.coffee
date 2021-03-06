hapi =			require 'hapi'
path =			require 'path'

orm =			require 'shout-orm'
error =			require './error'

pages =
	register:	require './register'
	activate:	require './activate'
	group:		require './group'





module.exports =



	routes: [
		{
			path:		'/register'
			method:		'POST'
			handler:	pages.register
			config:
				payload:
					parse:	true
					output:	'data'
		}, {
			path:		'/activate'
			method:		'POST'
			handler:	pages.activate
			config:
				payload:
					parse:	true
					output:	'data'
		}, {
			path:		'/{group}'
			method:		'GET'
			handler:	pages.group
		}
	],

	server:		null
	orm:		orm



	init: (cert, key, port) ->
		if not cert? then throw new Error 'Missing `cert` argument.'
		if not key? then throw new Error 'Missing `key` argument.'
		if not port? then throw new Error 'Missing `port` argument.'

		@server = server = new hapi.Server()
		server.connection
			tls:
			 	cert:			cert
			 	key:			key
			port:				port
		server.bind this
		server.ext 'onPreResponse', error
		server.route @routes

		@orm.connect()

		return this



	start: (cb = ()->) ->
		@server.start cb
		return this

	stop: (cb = ()->) ->
		@server.stop cb
		return this

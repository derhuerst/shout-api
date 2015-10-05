hapi =			require 'hapi'
path =			require 'path'

orm =			require 'shout-orm'

pages =
	register:	require './register'
	activate:	require './activate'
	group:		require './group'





module.exports =



	routes: [
		{
			path:		'/register'
			method:		'POST'
			handler:	api.register
		}, {
			path:		'/activate'
			method:		'POST'
			handler:	api.activate
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
		server.route @routes

		@orm.connect()

		return this



	start: (cb = ()->) ->
		@server.start cb
		return this

	stop: (cb = ()->) ->
		@server.stop cb
		return this

boom =			require 'boom'
shortHash =		require 'short-hash'





module.exports = (req, reply) ->
	if not req.payload.system then return reply boom.badRequest 'Missing `system` parameter.'
	if not req.payload.token then return reply boom.badRequest 'Missing `token` parameter.'

	id = shortHash req.payload.token
	@orm.registrations.activate id, req.payload.system, req.payload.token
	.then () -> reply {}
	.catch (err) -> throw err

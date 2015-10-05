boom =			require 'boom'
shortHash =		require 'short-hash'





module.exports = (req, reply) ->
	if not req.payload.token then return reply boom.badRequest 'Missing `token` parameter.'

	id = shortHash req.payload.token
	@orm.registrations.add id, req.payload.token
	.then () -> reply {}
	.catch (err) -> throw err

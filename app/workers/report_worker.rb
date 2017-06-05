class ReportWorker
	include Sidekiq::Worker


	require 'mqtt'
	require 'uri'

	# Create a hash with the connection parameters from the URL



	def perform()
		uri = URI.parse ENV['CLOUDMQTT_URL'] || 'mqtt://localhost:1883'
      conn_opts = {
        remote_host: uri.host,
        remote_port: uri.port,
        username: uri.user,
        password: uri.password,
      }
      @states = State.all
    

      
end







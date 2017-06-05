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
      @states.each do |st|
      Thread.new do
        MQTT::Client.connect(conn_opts) do |c|
          # The block will be called when you messages arrive to the topic
          c.get(st.gear) do |topic, message|
                if message.to_s.split(':')[0] == st.property
                  st.state = message.to_s.split(':')[1]
                  st.save
            end
          end
          end
        end
      end

      

      
end







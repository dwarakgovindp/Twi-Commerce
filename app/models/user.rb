class User < ActiveRecord::Base
	def twitter_client
		client = Twitter::REST::Client.new do |config|
			config.consumer_key = "ILkgbjVkhexfBJH5lIDlc9eHJ"
			config.consumer_secret = "7mIoXXiGqyhpzgno9IGqqaUwrpICS30kXcC4qDFwftM1T2SsOC"
			config.access_token = self.access_token
			config.access_token_secret = self.access_secret
		end
	end
end

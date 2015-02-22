class DashboardController < ApplicationController
	include ActionView::Helpers::DateHelper
	def dashboard

	end

	def add_posts
		since_id = Advertisement.order("created_at").last
		if since_id.nil?
			posts =  User.first.twitter_client.search("@twi_commerce -rt").attrs[:statuses]
		else
			posts =  User.first.twitter_client.search("@twi_commerce -rt",{:since_id => (since_id.post_id.to_i + 1)}).attrs[:statuses]
		end
		posts.each do |post|

			tokens = post[:text].split "|"
			if tokens.length == 6
				handle = post[:user][:screen_name]
				country = post[:user][:location]
				image = post[:user][:profile_image_url]
				unless post[:entities][:media].nil?
					prod_img =  post[:entities][:media][0][:media_url]
				else
					prod_img = "NULL"
				end
				prod_name = tokens[0]
				spec = tokens[1]
				quoted_price = tokens[2]
				category = tokens[3]
				phone = tokens[4]
				posted_at = post[:created_at]
				post_id = post[:id]

				new_ad = Advertisement.create(
							twitter_handle:handle.strip,
							country:country.strip,
							img:image.strip,
							prod_img:prod_img.strip,
							spec:prod_name.strip + spec.strip,
							quoted_price:quoted_price.strip,
							category:category.strip,
							posted_at: Time.parse(posted_at),
							post_id: post_id,
							phone:phone
						)
			else
				next
			end
		end
	end

	def show_posts
		category = params[:category].downcase
		ads = Advertisement.where(category:category)
		puts "* "*50
		puts category
		ads_list = []
		ads.each do |ad|
			ads_list << {
				twitter_handle: ad.twitter_handle,
				country: ad.country,
				img: ad.img,
				prod_img: ad.prod_img,
				spec: ad.spec,
				quoted_price: ad.quoted_price,
				category: ad.category,
				posted_at: time_ago_in_words(Time.parse(ad.posted_at.to_s)),
				post_id: ad.post_id,
				phone: ad.phone
			}
		end
		render json: ads_list
	end

	def send_tweet
		buyer = User.find(session[:id])
		seller = Advertisement.find_by(post_id:params[:post_id])
		tweet = "@" + seller.twitter_handle + " I would like to buy your article mentioned in the tweet http://twitter.com/" + seller.twitter_handle + "/status/" + seller.post_id + " reply soon :)"
		buyer.twitter_client.update(tweet)
		render json: {message: "tweet successfully posted!"}
	end

end

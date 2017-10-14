require 'http'
require_relative 'new_articles.rb'
require_relative 'category.rb'
module News
	class NewsAPI

		module Errors
	      class NotFound < StandardError; end
	      class Unauthorized < StandardError; end
	    end

	    HTTP_ERROR = {
	      401 => Errors::Unauthorized,
	      404 => Errors::NotFound
	    }.freeze

		def initialize(token)
			@news_token = token
		end

		def news_use(source, sortBy)
			url = news_api_path(source, sortBy)
			news_data = call_news_url(url).parse
			Category.new(news_data)
		end

		private

		def news_api_path(source = 'techradar', sortBy = 'top') #create url where News you want
			'https://newsapi.org/v1/articles?source=' + source + '&sortBy=' + sortBy
		end

		def call_news_url(url) #use key and dump raw data
			result = HTTP.headers("x-api-key" => @news_token).get(url)

			successful?(result) ? result : raise_error(result)
		end

		def successful?(result)
	      HTTP_ERROR.keys.include?(result.code) ? false : true
	    end

	    def raise_error(result)
	      raise(HTTP_ERROR[result.code])
	    end
	end
end

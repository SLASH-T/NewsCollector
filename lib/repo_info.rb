require 'http'
require 'yaml'

#source = ['abc-news-au', 'the-economist', 'techradar']
config = YAML.safe_load(File.read('config/secrets.yml'))

news_reponse = {}
news_result = {}

def news_api_path(source = 'techradar', sortBy = 'top') #create url where News you want
	'https://newsapi.org/v1/articles?source=' + source + '&sortBy=' + sortBy
end

def call_news_url(config, url) #use key and dump raw data
	HTTP.headers("x-api-key" => config['news_token']).get(url)
end

repo_url = news_api_path('techradar', 'latest')
news_reponse[repo_url] = call_news_url(config, repo_url)
repo = news_reponse[repo_url].parse #turn to hash class
news_result['status'] = repo['status'] 
news_result['source'] = repo['source']
news_result['sortBy'] = repo['sortBy']
news_result['articles'] = repo['articles']

File.write('spec/fixtures/result.yml', news_result.to_yaml) 




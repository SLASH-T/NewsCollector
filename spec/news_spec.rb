# This is a testing script for the overal work

require 'minitest/autorun'
require 'minitest/rg'
require 'yaml'
require_relative '../lib/'

describe 'Tests if the News API is correctly called' do
  NEWS_SOURCE = 'techradar'.freeze
  SORTBY = 'latest'.freeze
  CONFIG = YAML.safe_load(File.read('config/secrets.yml'))
  NEWS_TOKEN = CONFIG['news_token']
  CORRECT = YAML.safe_load(File.read('spec/fixtures/gh_results.yml'))

  before do
    @news = News::NewsAPI.new(NEWS_TOKEN).news_api_path(NEWS_SOURCE, SORTBY)
  end

  it 'Checking Status' do
    _(@news.status).must_equal CORRECT['status']
  end

  it 'Checking Souce' do
    _(@news.source).must_equal CORRECT['source']
  end

  it 'Check Sorting Fetures' do
    _(@news.sortBy).must_equal CORRECT['sortBy']
  end
end

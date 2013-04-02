require 'nokogiri'
require 'rest_client'
require 'json'
require 'redis'

    doc = Nokogiri::HTML(RestClient.get('http://sh.189.cn/zxdt/yhycx/'))

    lists = []
    doc.css('.yhycx_list a')[0..4].each do |link|
      content =  link.content
      if link['href'] =~ /^http/
        href = link['href']
      else
        href = "http://sh.189.cn#{link['href']}"
      end
      lists << {href: href, content: content}
    end

    p lists.to_json

    redis = Redis.new 
    redis.set "dtxx", lists.to_json if lists.size > 0


require 'nokogiri'
require 'httparty'
require 'byebug'

def scraper
  url = "https://www.ebay.com/sch/i.html?_nkw=thinkpad+x250&_ipg=25"
  raw = HTTParty.get(url)
  parsed = Nokogiri::HTML(raw)

  results = parsed.css("ul.srp-results > li.s-item")

  listings = []

  results.each do |result|
    listing = {
      title: result.xpath(".//h3[@class = 's-item__title']/text()"),
      price: result.css("span.s-item__price").text,
      url: result.xpath(".//a[@class = 's-item__link']")[0]["href"][/(.+)(?=\?)/]
    }
    listings << listing
  end
  byebug
end

scraper

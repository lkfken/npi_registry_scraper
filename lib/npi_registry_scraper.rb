require 'bundler'
Bundler.require
require_relative 'npi_registry_scraper/url'
require_relative 'npi_registry_scraper/resource'
require_relative 'npi_registry_scraper/deserialization'

module NPIRegistryScraper
  def self.get_taxonomies(npi:)
    json_object(npi: npi).taxonomies
  end
  def self.json_object(npi:)
    url = NPIRegistryScraper::URL.new(npi: npi)
    resource = NPIRegistryScraper::Resource.new(url: url.get)
    json = MultiJson.load(resource.get)
    NPIRegistryScraper::Deserialization.new(json: json)
  end
end

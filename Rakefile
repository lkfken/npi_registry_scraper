require_relative 'lib/npi_registry_scraper'
require 'pp'

namespace :npi do
  desc 'show taxonomies given the NPI'
  task :taxonomy do
    npi_keys = IO.readlines('input/npi_list.txt').map(&:chomp)
    objs = npi_keys.map {|npi| NPIRegistryScraper.json_object(npi: npi)}
    rows = objs.flat_map(&:to_a)
    headings = %w[NPI NAME CODE DESC PRIMARY]
    File.open('taxonomy.txt', 'w') {|f| f.puts Terminal::Table.new(rows: rows, headings: headings)}
  end
end
require 'rspec'
require_relative '../lib/npi_registry_scraper'

describe NPIRegistryScraper do
  let(:npi) {'1437189966'}
  let(:url) {NPIRegistryScraper::URL.new(npi: npi)}
  let(:resource) {NPIRegistryScraper::Resource.new(url: url.get)}
  let(:json) {MultiJson.load(resource.get)}
  let(:deserialize_object) {NPIRegistryScraper::Deserialization.new(json: json)}

  it 'should get the NPI from the url' do
    expect(resource.npi).to eq(npi)
  end

  it 'should get the json resource' do
    expect(deserialize_object.result_count).to eq(1)
  end

  it 'should get the results' do
    expect(deserialize_object.results.size).to eq(1)
  end

  it 'should get the taxonomies' do
    expect(deserialize_object.taxonomies.size).to eq(2)
  end
end
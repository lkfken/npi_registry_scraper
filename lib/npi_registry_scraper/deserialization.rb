module NPIRegistryScraper
  class Deserialization
    attr_reader :json

    def initialize(json:)
      @json = json
    end

    def to_a
      @to_a ||= valid? ? taxonomies.map {|t| [npi, name, t['code'], t['desc'], t['primary']]} : []
    end

    def name
      if only_1_record?
        @name ||= [name_prefixes.first, first_names.first, middle_names.first, last_names.first].compact.join(' ')
      end
    end

    def first_names
      basic.map {|result| result.fetch('first_name')}
    end

    def last_names
      basic.map {|result| result.fetch('last_name')}
    end

    def middle_names
      basic.map {|result| result.fetch('middle_name', nil)}
    end

    def name_prefixes
      basic.map {|result| result.fetch('name_prefix', nil)}
    end

    def credentials
      basic.map {|result| result.fetch('credential')}
    end

    def basic
      results.map {|result| result.fetch('basic')}
    end

    def taxonomies
      results.flat_map {|result| result.fetch('taxonomies')}
    end

    def results
      (0..result_count - 1).map {|index| json.fetch('results')[index]}
    end

    def npi
      all_npi = results.map {|result| result.fetch('number')}
      only_1_record? ? all_npi.first : all_npi
    end

    def valid?
      result_count > 0
    end

    def only_1_record?
      result_count == 1
    end

    def result_count
      @result_count ||= json.fetch('result_count', 0)
    end
  end
end
module NPIRegistryScraper
  class Resource
    attr_reader :cached_dir, :url

    def initialize(url:, cached_dir: Pathname.new(__FILE__).parent.parent.parent + 'tmp')
      @url = url
      @cached_dir = cached_dir
    end

    def npi
      @npi ||= begin
        re = url.match(/\A.*?number=(?<npi>\d{10})&/)
        re.nil? ? raise("This URL #{url} has no NPI") : re[:npi]
      end
    end

    def get
      @response ||= begin
        cached_file = cached_dir + "#{npi}.json"
        if File.exist?(cached_file)
          IO.read(cached_file)
        else
          warn "#{npi} reading from the Internet"
          resp = HTTP.get(url)
          File.open(cached_file, 'w') {|f| f.puts resp.to_s}
          resp
        end
      end
    end
  end
end
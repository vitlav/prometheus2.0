require 'csv'
require 'net/http'

class BugsImport
  attr_reader :url

  def initialize(url)
    @url = url
  end

  def execute
    ActiveRecord::Base.transaction do
      Bug.delete_all

      CSV.parse(data, headers: true) do |row|
        Bug.create!(row.to_hash)
      end
    end
  end

  def data
    uri = URI.parse(url)
    http = Net::HTTP.new(uri.host, uri.port)
    http.use_ssl = true
    http.ca_file = 'altlinux.ca'
    http.get(uri.request_uri).body
  end
end
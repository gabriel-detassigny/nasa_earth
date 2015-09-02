require 'net/http'
require 'json'

class NasaEarth
  attr_accessor :api_key

  def initialize options = {}
    @api_key = options[:api_key]
  end

  def imagery params
    params[:api_key] = @api_key unless @api_key.nil?
    uri = URI('https://api.nasa.gov/planetary/earth/imagery')
    uri.query = URI.encode_www_form(params)

    res = Net::HTTP.get_response(uri)
    response = {
      'code'  => res.code,
      'message' => res.message
    }
    if res.is_a? Net::HTTPSuccess
      response['content'] = JSON.load(res.body)
    end
    return response
  end
end

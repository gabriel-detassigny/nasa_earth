require 'net/http'
require 'json'
require 'boolean'

class NasaEarth
  attr_accessor :api_key

  VALIDATORS = {
    api_key:     { mandatory: true, type: String },
    lat:         { mandatory: true, type: Float },
    lon:         { mandatory: true, type: Float },
    dim:         { mandatory: false, type: Float },
    date:        { mandatory: false, type: String },
    begin:       { mandatory: false, type: String },
    end:         { mandatory: false, type: String },
    cloud_score: { mandatory: false, type: Boolean },
  }

  def initialize options = {}
    @api_key = options[:api_key]
  end

  def imagery params
    params[:api_key] = @api_key unless @api_key.nil?
    _check_params params
    uri = URI('https://api.nasa.gov/planetary/earth/imagery')
    uri.query = URI.encode_www_form(params)
    return _get_response uri
  end

  def assets params
    params[:api_key] = @api_key unless @api_key.nil?
    _check_params params
    uri = URI('https://api.nasa.gov/planetary/earth/assets')
    uri.query = URI.encode_www_form(params)
    return _get_response uri
  end

  private
  def _get_response uri
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

  def _check_params params
    VALIDATORS.each do |name, conditions|
      if params.has_key? name
        unless params[name].is_a? conditions[:type]
          raise ArgumentError, "'#{name}' should be a #{conditions[:type].to_s}"
        end
      elsif conditions[:mandatory]
        raise ArgumentError, "Argument '#{name}' is mandatory"
      end
    end
  end
end

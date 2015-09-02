require 'minitest/autorun'
require 'nasa_earth'

class NasaEarthTest < Minitest::Test
  def setup
     File.open(File.join(File.dirname(__FILE__), 'api_key.txt')) do |file|
       @api_key = file.read
     end
     @client = NasaEarth.new api_key: @api_key
  end

  def test_api_key_setup
    assert_equal @api_key, @client.api_key
  end

  def test_imagery_endpoint
    response = @client.imagery lat: 10, lon: 10
    assert_equal '200', response['code']
    assert_equal 'OK', response['message']
    assert_includes response['content'], 'url'
  end

  def test_assets_endpoint
    response = @client.assets lat: 10, lon: 10
    assert_equal '200', response['code']
    assert_equal 'OK', response['message']
  end
end

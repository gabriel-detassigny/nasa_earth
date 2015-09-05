require 'minitest/autorun'
require 'nasa_earth'

class NasaEarthTest < Minitest::Test
  def setup
    api_key_file = File.join(File.dirname(__FILE__), 'api_key.txt')

    unless File.exists? api_key_file
      raise "Please put your API key inside a file named #{api_key_file}"
    end

     File.open(api_key_file) do |file|
       @api_key = file.read
     end
     @client = NasaEarth.new api_key: @api_key
  end

  def test_api_key_setup
    assert_equal @api_key, @client.api_key
  end

  def test_imagery_endpoint
    response = @client.imagery lat: 10.0, lon: 10.0
    assert_equal '200', response['code']
    assert_equal 'OK', response['message']
    assert_includes response['content'], 'url'
  end

  def test_imagery_endpoint_missing_parameters
    assert_raises(ArgumentError) do
      @client.imagery dim: 10.0
    end
  end

  def test_imagery_endpoint_invalid_parameters
    assert_raises(ArgumentError) do
      @client.imagery lat: 'invalid', lon: 10.0
    end
  end

  def test_assets_endpoint
    response = @client.assets lat: 10.0, lon: 10.0
    assert_equal '200', response['code']
    assert_equal 'OK', response['message']
  end

  def test_assets_endpoint_missing_parameters
    assert_raises(ArgumentError) do
      @client.assets dim: 10.0
    end
  end

  def test_imagery_endpoint_invalid_parameters
    assert_raises(ArgumentError) do
      @client.assets lat: 'invalid', lon: 10.0
    end
  end
end

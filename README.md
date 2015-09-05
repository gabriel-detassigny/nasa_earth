## NASA Earth

This is a wrapper for the [NASA earth API](https://api.nasa.gov/api.html#earth).

This allows to retrieve pictures taken by the satellite **Landsat 8** for any coordinates on Earth, and at any point in time!

Note : You will need to [request an API key](https://api.nasa.gov/index.html#apply-for-an-api-key) from NASA to use this gem.

### Installation

Simply type :
```
gem install nasa_earth
```

Or add this line to your Gemfile :
```
gem 'nasa_earth'
```

### Imagery endpoint

Retrieve an URL of an image at specific coordinates.

#### Example
``` ruby
require 'nasa_earth'
n = NasaEarth.new api_key: 'your_api_key'
n.imagery lat: 48.8583701, lon: 2.2944813

=> {"code"=>"200", "message"=>"OK", "content"=>{
    "date"=>"2015-08-26T10:40:37",
    "url"=>"https://earthengine.googleapis.com/api/thumb?thumbid=d29fb6c5e2259cc02a7634c3f63b1265&token=13516c99554e9196d4e4c50e5c171c92",
    "id"=>"LC8_L1T_TOA/LC81990262015238LGN00"}}
```

#### Parameters

| Parameter | Type | Mandatory | Description |
| --------- |:----:| ---------:| -----------:|
| lat | Float | Yes | Latitude |
| lon | Float | Yes | Longitude |
| dim | Float | No | width and height in degrees |
| date | String (format YYYY-MM-DD) | No | date of image |
| cloud_score | Boolean | No | calculate the percentage of  cloud |


### Assets endpoint

Retrieve different date-time for available imagery at specific coordinates

#### Example

``` ruby
require 'nasa_earth'
n = NasaEarth.new
n.api_key = 'your_api_key'
n.assets lon: 10.0, lat: 11

=> {"code"=>"200", "message"=>"OK", "content"=>{"count"=>46, "results"=>
  [{"date"=>"2013-05-12T09:38:57", "id"=>"LC8_L1T_TOA/LC81870522013132LGN01"},
   {"date"=>"2013-05-28T09:39:04", "id"=>"LC8_L1T_TOA/LC81870522013148LGN00"},
   {"date"=>"2013-06-13T09:39:00", "id"=>"LC8_L1T_TOA/LC81870522013164LGN00"},
   ...
  ]}}
```

#### Parameters

| Parameter | Type | Mandatory | Description |
| --------- |:----:| ---------:| -----------:|
| lat | Float | Yes | Latitude |
| lon | Float | Yes | Longitude |
| begin | String (format YYYY-MM-DD) | No | beginning of date range |
| end | String (format YYYY-MM-DD) | No | end of date range |

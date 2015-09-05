Gem::Specification.new do |s|
  s.name        = 'nasa_earth'
  s.version     = '0.0.1'
  s.date        = '2015-09-02'
  s.summary     = "NASA Earth API"
  s.description = "An unofficial NASA Earth API wrapper. It can be used to display images for a specific location at different period in time."
  s.authors     = ["Gabriel de Tassigny"]
  s.email       = 'gabriel@multivac.cc'
  s.files       = ["lib/nasa_earth.rb"]
  s.homepage    =
    'https://github.com/gabriel-detassigny/nasa_earth'
  s.license       = 'MIT'
  s.add_runtime_dependency 'boolean', '~> 1.0'
end

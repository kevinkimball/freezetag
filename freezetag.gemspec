Gem::Specification.new do |s|
  s.name        = 'freezetag'
  s.version     = '0.0.1'
  s.date        = '2015-06-04'
  s.summary     = ''
  s.description = ''
  s.authors     = ['Kevin Kimball']
  s.email       = 'kwkimball@gmail.com'
  s.homepage    = 'http://www.freezetag.io'

  s.files = [
    'lib/freezetag.rb'
  ]

  s.add_runtime_dependency 'httparty', ['>= 0.13.5']
end

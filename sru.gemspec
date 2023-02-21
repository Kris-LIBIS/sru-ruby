spec = Gem::Specification.new do |s|
  s.name = "sru"
  s.version = "0.0.9"
  s.author = "Kris Dekeyser"
  s.email = "kris.dekeyser@kuleuven.be"
  s.homepage = "http://github.com/Kris-LIBIS/sru-ruby"
  s.platform = Gem::Platform::RUBY
  s.summary = "a Ruby library for the Search/Retrieve via URL (SRU) protocol"
  s.description = <<~EOF
    Client for the Search/Retrieve via URL (SRU) protocol.
    http://www.loc.gov/standards/sru/
  EOF
  s.files = Dir.glob("{lib,test}/**/*")
  s.require_path = "lib"
  s.add_dependency "libxml-ruby"
  s.add_development_dependency "bundler", ">= 1.1.4"
  s.add_development_dependency "rake"
  s.add_development_dependency "redcarpet"
  s.add_development_dependency "vcr"
  s.add_development_dependency "webmock"
  s.add_development_dependency "yard"
  s.add_development_dependency "rspec"
  s.add_development_dependency "rspec_junit_formatter"
  s.add_development_dependency "standardrb"
end

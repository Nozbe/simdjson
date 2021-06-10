require "json"

package = JSON.parse(File.read(File.join(__dir__, 'package.json')))

Pod::Spec.new do |s|
  s.name         = "simdjson"
  s.version      = package["version"]
  s.summary      = package["description"]
  s.description  = package["description"]
  s.homepage     = package["homepage"]
  s.license      = package["license"]
  s.author       = { "author" => package["author"] }
  s.platforms    = { :ios => "9.0", :tvos => "9.0" }
  s.source = { :git => "https://github.com/Nozbe/simdmjson.git", :tag => "v#{s.version}" }
  s.source_files = "src/*.{h,cpp}"
  s.public_header_files = 'src/simdjson.h'
  s.requires_arc = true
  s.compiler_flags = '-Os'
end

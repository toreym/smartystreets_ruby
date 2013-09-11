require 'yard'

YARD::Rake::YardocTask.new(:doc) do |t|
  version = SmartyStreets::GEM_VERSION
  t.options = ["--title", "SmartyStreets #{version}", "--files", "LICENSE"]
end

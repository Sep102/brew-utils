require 'formula'

Dir.chdir HOMEBREW_PREFIX do
  Dir.mkdir 'doc' unless File.directory? 'doc'
  Dir['Library/*'].each do |dir|
    system 'rdoc', "-odoc/#{File.basename dir}", dir
  end

  # Remove directories nothing was generated in
  Dir['doc/*'].each { |dir| Pathname.new(dir).rmdir_if_possible }
end

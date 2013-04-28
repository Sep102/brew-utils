require 'formula'

module Homebrew extend self
  def sped
    ARGV.formulae.each do |f|
      puts f
      recursive_reverse_deps(Formula.factory(f), 1)
      puts
    end
  end

private
  @installed = HOMEBREW_CELLAR.children.
    select{ |pn| pn.directory? }.
    collect { |pn| pn.basename.to_s }

  def recursive_reverse_deps(formula, level)
    @installed.collect { |f| Formula.factory f }.each do |f|
      if Dependency.expand(f).include?(formula) then
        puts "> "*level+f.name
        recursive_reverse_deps(f, level+1)
      end
    end rescue return
  end
end

Homebrew.sped

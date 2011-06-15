require 'formula'

module Homebrew extend self
  def reversedeps
    ARGV.formulae.each do |f|
      puts f
      recursive_reverse_deps(f, 1)
      puts
    end
  end

private
  @installed = HOMEBREW_CELLAR.children.
    select{ |pn| pn.directory? }.
    collect { |pn| pn.basename.to_s }

  def recursive_reverse_deps(formula, level)
    @installed.each do |f|
      f = Formula.factory f rescue next

      if f.deps.find { |dep| dep == formula.name } != nil
        puts "> "*level+f.name
        recursive_reverse_deps(f, level+1)
      end
    end
  end
end

Homebrew.reversedeps

$:.unshift(File.dirname(__FILE__) << '/rtex')

require 'document'
require 'version'
require 'rubygems'
require 'RedCloth'

module RTeX
  
  # Load code to initialize RTeX for framework 
  def self.framework(name)
    require File.dirname(__FILE__) << "/rtex/framework/#{name}"
    framework = ::RTeX::Framework.const_get(name.to_s.capitalize)
    framework.setup
  end
  
  def self.filters #:nodoc:
    @filters ||= {}
  end
  
  def self.basic_layout #:nodoc:
    "\\documentclass[12pt]{article}\n\\begin{document}\n<%= yield %>\n\\end{document}"
  end
  
  # Define a processing filter
  # call-seq:
  #   filter(:name) { |text_to_transform| ... } # => result
  def self.filter(name, &block)
    filters[name.to_s] = block
  end

  filter :textile do |source|
    RedCloth.new(source).to_latex
  end

end

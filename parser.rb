require 'rubygems'
require 'treetop'

require_relative 'nodes.rb'

class Parser

  def self.load  
    base_path = File.expand_path(File.dirname(__FILE__))
    Treetop.load(File.join(base_path, 'apex.treetop'))
#   Treetop.load(File.join(base_path, 'keywords.treetop'))
    @@parser = ApexParser.new
  end

  def self.parse(data,options={})
    tree = @@parser.parse(data,options)
    
    if(tree.nil?)
      raise Exception, "Parse error at offset: #{@@parser.index}
			#{@@parser.failure_reason}
			#{@@parser.failure_line}
			#{@@parser.failure_column}"
    end

    self.clean_tree(tree)

    return tree
  end

  private

  def self.clean_tree(root_node)
    return if(root_node.elements.nil?)
    root_node.elements.delete_if{|node| node.class.name == "Treetop::Runtime::SyntaxNode" && node.extension_modules.empty? }
    root_node.elements.each {|node| self.clean_tree(node) }
  end
end



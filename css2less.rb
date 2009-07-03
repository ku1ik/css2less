#!/usr/bin/ruby
require 'enumerator'

def add_rule(tree, selectors, style)
  if selectors.empty?
    (tree[:style] ||= ';') << style
  else
    first, rest = selectors.first, selectors[1..-1]
    node = (tree[first] ||= {})
    add_rule(node, rest, style)
  end
end

def print_css(tree, indent=0)
  tree.each do |element, children|
    puts ' ' * indent + element + " {\n"
    style = children.delete(:style)
    if style
      puts style.split(';').map { |s| s.strip }.reject { |s| s.empty? }.map { |s| ' ' * (indent+2) + s + ';' }.join("\n")
    end
    print_css(children, indent + 2)
    puts ' ' * indent + "}\n"
  end
end

tree = {}
css = File.read(ARGV[0])

css.split("\n").map { |l| l.strip }.join.gsub(/\/\*+[^\*]*\*+\//, '').split(/[\{\}]/).each_slice(2) do |style|
  rules = style[0].strip
  if rules.include?(',') # leave multiple rules alone
    add_rule(tree, [rules], style[1])
  else
    add_rule(tree, rules.split(/\s+/), style[1])
  end
end

print_css(tree)
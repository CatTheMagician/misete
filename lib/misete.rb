# frozen_string_literal: true

require 'misete/version'
require 'misete/schema_parser'
require 'misete/schema_printer'
require 'misete/version'

module Misete
  def self.schema(options = {})
    schema_path = options.delete(:input) || File.join(Dir.pwd, 'db/schema.rb')
    options.delete(:tables) if options[:tables].empty?
    parsed_schema = Misete::SchemaParser.parse(schema_path, options)
    Misete::SchemaPrinter.show(parsed_schema)
  end
end

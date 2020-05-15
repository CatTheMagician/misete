require 'minitest/autorun'
require 'json'
require_relative '../lib/misete'

class TestMisete < Minitest::Test

  def test_full_parsing
    file = File.join(file_path('fixtures/schema.rb'))
    parsed_file = Misete.schema(file)

    assert_equal JSON.pretty_generate(parsed_file), strict_schema
  end

  def test_parsing_with_table_names
    file = File.join(file_path('fixtures/schema.rb'))
    parsed_file = Misete.schema(file, table_names: ['users'])

    assert_equal JSON.pretty_generate(parsed_file), filtered_schema
  end

  def strict_schema
    File.read(file_path('fixtures/schema.json'))
  end

  def filtered_schema
    File.read(file_path('fixtures/filtered_schema.json'))
  end

  def file_path(file)
    File.join(File.dirname(__FILE__), file)
  end
end

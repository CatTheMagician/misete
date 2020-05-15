require 'minitest/autorun'
require 'json'
require_relative '../lib/misete'

class TestMisete < Minitest::Test

  def test_parsing
    file = File.join(file_path('fixtures/schema.rb'))
    parsed_file = Misete::Parser.parse(file)

    assert_equal JSON.pretty_generate(parsed_file), strict_schema
  end

  def strict_schema
    File.read(file_path('fixtures/schema.json'))
  end

  def file_path(file)
    File.join(File.dirname(__FILE__), file)
  end
end

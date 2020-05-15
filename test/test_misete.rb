# Copyright (c) 2020 Konstantin Ermolchev
#
# Permission is hereby granted, free of charge, to any person obtaining a copy
# of this software and associated documentation files (the 'Software'), to deal
# in the Software without restriction, including without limitation the rights
# to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
# copies of the Software, and to permit persons to whom the Software is
# furnished to do so, subject to the following conditions:
#
# The above copyright notice and this permission notice shall be included in all
# copies or substantial portions of the Software.
#
# THE SOFTWARE IS PROVIDED 'AS IS', WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
# IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
# FITNESS FOR A PARTICULAR PURPOSE AND NONINFINGEMENT. IN NO EVENT SHALL THE
# AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
# LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
# OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN THE
# SOFTWARE.

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

  def test_print_schema
    file = File.join(file_path('fixtures/schema.rb'))
    parsed_file = Misete.schema(file)
    Misete::SchemaPrinter.show(parsed_file)
  end

  def strict_schema
    File.read(file_path('fixtures/schema.json'))
  end

  def filtered_schema
    File.read(file_path('fixtures/filtered_schema.json'))
  end
  def schema_output
    File.read(file_path('fixtures/output.txt'))
  end

  def file_path(file)
    File.join(File.dirname(__FILE__), file)
  end
end

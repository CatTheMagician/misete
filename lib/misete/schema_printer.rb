# frozen_string_literal: true

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

class Misete::SchemaPrinter
  def self.show(parsed_schema)
    max_indent = calc_indent(parsed_schema)
    parsed_schema[:tables].each do |name, data|
      print_table_header(name)
      data[:columns].each do |name, data|
        print_column(name, data, max_indent)
      end
      print "#\n"
      print "\n"
    end
  end

    private

  def self.calc_indent(parsed_schema)
    parsed_schema[:tables].map { |_, data| data.dig(:columns)&.keys }.flatten.map(&:size).max
  end

  def self.print_table_header(name)
    print "\n"
    print "# Table name: #{name}\n"
    print "#\n"
  end

  def self.print_column(name, data, indent)
    print "# #{name.ljust(indent)} :#{data.values_at(:type, :params).compact.join(', ')}\n"
  end
end

# frozen_string_literal: true

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
    print "# #{name.ljust(indent)} :#{data[:type]}, #{data[:params]}\n"
  end
end

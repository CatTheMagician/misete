# frozen_string_literal: true

require 'misete/version'

module Misete
  class Parser
    def initialize(schema_path)
      @schema = {}
      @schema_path = schema_path
    end

    def parse
      file.each_line { |line| process_line(line) }
      @schema
    end

    def self.parse(filename)
      new(filename).parse
    end

    private

    def file
      File.open(@schema_path)
    end

    def process_line(line)
      if table?
        process_columns(line)
      else
        process_table_name(line)
      end
    end

    def process_columns(line)
      add_column(extract_column(line))
      end_table if line.strip == 'end'
    end

    def extract_column(line)
      column, options = line.split(',', 2)
      column_type, column_name = column.match(/t.(?<type>\w+) "(?<name>\S+)"/).to_a.last(2)

      return {} unless column_name

      {}.tap do |hash|
        hash[column_name] = { type: column_type.strip }
        hash[column_name].merge!({ params: options.strip }) if options
      end
    end

    def add_column(column)
      @schema[@current_table].merge!(column)
    end

    def process_table_name(line)
      table_name = extract_table_name(line)
      begin_table(table_name) if table_name
    end

    def extract_table_name(line)
      matches = line.match(/create_table "(?<table_name>\S+)",/)
      matches[:table_name].strip if matches
    end

    def begin_table(table_name)
      @current_table = table_name
      @schema[table_name] = {}
    end

    def end_table
      @current_table = nil
    end

    def table?
      @current_table
    end
  end
end

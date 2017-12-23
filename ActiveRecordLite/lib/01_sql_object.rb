require_relative 'db_connection'
require 'active_support/inflector'
require 'byebug'
# NB: the attr_accessor we wrote in phase 0 is NOT used in the rest
# of this project. It was only a warm up.

class SQLObject
  def self.columns
    # ...
    return @columns unless @columns.nil?

    @columns = DBConnection.execute2(<<-SQL).first
      SELECT
        *
      FROM
        #{self.table_name}
      LIMIT
        0
    SQL
    @columns.map!(&:to_sym)

  end

  def self.finalize!
    self.columns.each do |name|
      define_method(name) { self.attributes[name] }

      define_method("#{name}=") do |value|
        self.attributes[name] = value
      end

    end
  end

  def self.table_name=(table_name)
    # ...
    @table_name = table_name
  end

  def self.table_name
    # ...
    if @table_name
      @table_name
    else
      self.name.underscore.pluralize
    end

  end

  def self.all
    # ...
  end

  def self.parse_all(results)
    # ...
  end

  def self.find(id)
    # ...
  end

  def initialize(params = {})
    # ...

    params.each do |attr_name, val|

      attr_name_sym = attr_name.to_sym
      if self.class.columns.include?(attr_name_sym)
        self.send("#{attr_name_sym}=", val)
      else
        raise "unknown attribute '#{attr_name_sym}'"
      end
    end
  end

  def attributes
    # ...
    @attributes ||= {}
  end

  def attribute_values
    # ...
  end

  def insert
    # ...
  end

  def update
    # ...
  end

  def save
    # ...
  end
end

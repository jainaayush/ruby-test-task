# frozen_string_literal: true

# app/serializer.rb
class Serializer
  class << self; attr_reader :attributes end

  attr_reader :object

  def initialize(object)
    @object = object
  end

  def self.attribute(name, &block)
    @attributes ||= {}
    @attributes[name] = block
  end

  def serialize
    attrs = {}

    self.class.attributes.each do |key, proc|
      attrs[key] = proc.nil? ? object.public_send(key) : instance_eval(&proc)
    end

    attrs
  end
end

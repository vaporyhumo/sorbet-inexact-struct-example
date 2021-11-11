# typed: strict

class SomeStruct < T::InexactStruct
  extend T::Sig

  sig { params(props: T::Array[T.untyped]).void }
  def self.register(props)
    props.each do |name, type|
      prop name, type
    end
  end
end

SomeStruct.register [[:one, String], [:two, String]]

SomeStruct.new() # This would raise an error on runtime because of missing arguments, but not on static check
SomeStruct.new(one: '', two: '') # works on runtime, no static error
SomeStruct.new(one: '', two: 1)  # fails on runtime because of type mismatch, no static error
SomeStruct.new(one: '', two: '', three: '') # fails on runtime because of extra argument, no static error

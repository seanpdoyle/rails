# frozen_string_literal: true

require_relative "abstract_unit"
require "active_support/core_ext/object/with_arguments"

class WithArgumentsTest < ActiveSupport::TestCase
  def test_method_with_arguments_and_block_with_argument_partially_applies_methods
    with_arguments 1 do |object|
      assert_equal [1], method_with_one_argument(1)
      assert_equal [1], object.method_with_one_argument
      assert_equal [1, 2], method_with_two_arguments(1, 2)
      assert_equal [1, 2], object.method_with_two_arguments(2)
      assert_equal [1, ["2"]], method_with_two_arguments(1, ["2"])
      assert_equal [1, ["2"]], object.method_with_two_arguments(["2"])
      assert_equal [1, { "option" => true }], method_with_one_argument_and_options(1, { "option" => true })
      assert_equal [1, { "option" => true }], object.method_with_one_argument_and_options("option" => true)
      assert_equal [1, { option: true }], method_with_one_argument_and_kwargs(1, option: true)
      assert_equal [1, { option: true }], object.method_with_one_argument_and_kwargs(option: true)
      assert_equal [1, nil, { option: true }], method_with_optional_argument_and_kwargs(1, option: true)
      assert_equal [1, nil, { option: true }], object.method_with_optional_argument_and_kwargs(option: true)
      assert_equal [1], method_with_one_argument_and_block(1, &:itself)
      assert_equal [1], object.method_with_one_argument_and_block(&:itself)
    end
  end

  def test_method_with_arguments_and_block_without_argument_partially_applies_methods
    test = self

    with_arguments 1 do
      test.assert_equal [1], test.method_with_one_argument(1)
      test.assert_equal [1], method_with_one_argument
      test.assert_equal [1, 2], test.method_with_two_arguments(1, 2)
      test.assert_equal [1, 2], method_with_two_arguments(2)
      test.assert_equal [1, ["2"]], test.method_with_two_arguments(1, ["2"])
      test.assert_equal [1, ["2"]], method_with_two_arguments(["2"])
      test.assert_equal [1, { "option" => true }], test.method_with_one_argument_and_options(1, { "option" => true })
      test.assert_equal [1, { "option" => true }], method_with_one_argument_and_options("option" => true)
      test.assert_equal [1, { option: true }], test.method_with_one_argument_and_kwargs(1, option: true)
      test.assert_equal [1, { option: true }], method_with_one_argument_and_kwargs(option: true)
      test.assert_equal [1, nil, { option: true }], test.method_with_optional_argument_and_kwargs(1, option: true)
      test.assert_equal [1, nil, { option: true }], method_with_optional_argument_and_kwargs(option: true)
      test.assert_equal [1], test.method_with_one_argument_and_block(1, &:itself)
      test.assert_equal [1], method_with_one_argument_and_block(&:itself)
    end
  end

  def test_method_with_arguments_partially_applies_methods
    object = with_arguments 1

    assert_equal [1], method_with_one_argument(1)
    assert_equal [1], object.method_with_one_argument
    assert_equal [1, 2], method_with_two_arguments(1, 2)
    assert_equal [1, 2], object.method_with_two_arguments(2)
    assert_equal [1, ["2"]], method_with_two_arguments(1, ["2"])
    assert_equal [1, ["2"]], object.method_with_two_arguments(["2"])
    assert_equal [1, { "option" => true }], method_with_one_argument_and_options(1, { "option" => true })
    assert_equal [1, { "option" => true }], object.method_with_one_argument_and_options("option" => true)
    assert_equal [1, { option: true }], method_with_one_argument_and_kwargs(1, option: true)
    assert_equal [1, { option: true }], object.method_with_one_argument_and_kwargs(option: true)
    assert_equal [1, nil, { option: true }], method_with_optional_argument_and_kwargs(1, option: true)
    assert_equal [1, nil, { option: true }], object.method_with_optional_argument_and_kwargs(option: true)
    assert_equal [1], method_with_one_argument_and_block(1, &:itself)
    assert_equal [1], object.method_with_one_argument_and_block(&:itself)
  end

  def method_with_one_argument(argument)
    [argument]
  end

  def method_with_one_argument_and_block(argument, &block)
    yield [argument]
  end

  def method_with_two_arguments(first, second)
    [first, second]
  end

  def method_with_optional_argument_and_kwargs(first, second = nil, **options)
    [first, second, options]
  end

  def method_with_one_argument_and_options(argument, options = {})
    [argument, options]
  end

  def method_with_one_argument_and_kwargs(argument, **options)
    [argument, options]
  end
end

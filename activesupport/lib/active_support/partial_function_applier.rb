# frozen_string_literal: true

module ActiveSupport
  class PartialFunctionApplier #:nodoc:
    instance_methods.each do |method|
      undef_method(method) unless method.start_with?("__", "instance_eval", "class", "object_id")
    end

    def initialize(context, arguments)
      @context, @arguments = context, arguments
    end

    private
      def method_missing(method, *arguments, **options, &block)
        @context.__send__(method, *@arguments, *arguments, **options, &block)
      end
  end
end

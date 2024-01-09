# frozen_string_literal: true

module ActionView
  class Template
    # = Action View Renderable Template for objects that respond to #render_in
    class Renderable # :nodoc:
      def initialize(renderable, &block)
        @renderable = renderable
        @block = block
      end

      def identifier
        @renderable.class.name
      end

      def render(context, locals)
        options =
          if @renderable.method(:render_in).arity == 1
            ActionView.deprecator.warn <<~WARN
              Action View's support for #render_in without options is deprecated.

              Change #render_in to accept keyword arguments.
            WARN

            {}
          else
            { locals: locals }
          end

        @renderable.render_in(context, **options, &@block)
      end

      def format
        @renderable.try(:format)
      end
    end
  end
end

# frozen_string_literal: true

class TestRenderable
  def render_in(view_context, locals: {}, formats: nil, **options, &block)
    if block
      view_context.render plain: block.call
    elsif Array(formats).first == :json
      json = { greeting: "Hello, #{locals.fetch(:name, "World")}!" }

      view_context.render plain: json.to_json
    else
      view_context.render inline: <<~ERB.strip, locals: locals
        Hello, <%= local_assigns.fetch(:name, "World") %>!
      ERB
    end
  end
end

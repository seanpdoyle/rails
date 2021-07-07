# frozen_string_literal: true

require "active_support/partial_function_applier"

class Object
  #   <%# app/views/posts/new.html.erb %>
  #   <% form_with model: Post.new do |form| %>
  #     <%= render "labelled_input", form: form.with_arguments(:title) %>
  #
  #     <%= render "labelled_input", form: form.with_arguments(:author) %>
  #
  #     <% form.with_arguments :publish do |publish| %>
  #       <div class="flex space-x-4">
  #         <%= publish.check_box %>
  #         <%= publish.label %>
  #       </div>
  #     <% end %>
  #
  #     <% form.with_arguments :channel do |channel| %>
  #       <div class="flex space-x-4">
  #         <%= channel.radio_button "Ruby" %>
  #         <%= published.label value: "Ruby"%>
  #       </div>
  #
  #       <div class="flex space-x-4">
  #         <%= channel.radio_button "Rails" %>
  #         <%= published.label value: "Rails"%>
  #       </div>
  #
  #       <div class="flex space-x-4">
  #         <%= channel.radio_button "JavaScript" %>
  #         <%= published.label value: "JavaScript"%>
  #       </div>
  #     <% end %>
  #   <% end %>
  #
  #   <%# app/views/application/_labelled_input.html.erb %>
  #   <div class="space-y-2">
  #     <%= form.label %>
  #     <%= form.text_field %>
  #   </div>
  #
  def with_arguments(*arguments, &block)
    partial_function_applier = ActiveSupport::PartialFunctionApplier.new(self, arguments)

    if block.nil?
      partial_function_applier
    else
      block.arity.zero? ? partial_function_applier.instance_eval(&block) : block.call(partial_function_applier)
    end
  end
end

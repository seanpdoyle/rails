*   Add default `#render_in` implementation to `ActiveModel::Conversion`

    With the following view partial:

    ```erb
    <%# app/views/people/_person.html.erb %>
    <% local_assigns.with_defaults(shout: false) => { shout: } %>

    <%= shout ? person.name.upcase : person.name %>
    ```

    Callers can render an instance of `Person` as a positional argument or a
    `:renderable` option:

    ```ruby
    person = Person.new(name: "Ralph")

    render person                                       # => "Ralph"
    render person, shout: true                          # => "RALPH"
    render renderable: person                           # => "Ralph"
    render renderable: person, locals: { shout: true }  # => "RALPH"
    ```

    *Sean Doyle*

*   Port the `type_for_attribute` method to Active Model. Classes that include
    `ActiveModel::Attributes` will now provide this method. This method behaves
    the same for Active Model as it does for Active Record.

      ```ruby
      class MyModel
        include ActiveModel::Attributes

        attribute :my_attribute, :integer
      end

      MyModel.type_for_attribute(:my_attribute) # => #<ActiveModel::Type::Integer ...>
      ```

    *Jonathan Hefner*

Please check [7-1-stable](https://github.com/rails/rails/blob/7-1-stable/activemodel/CHANGELOG.md) for previous changes.

# frozen_string_literal: true

require "test_helper"

class ActionText::EditorTest < ActionView::TestCase
  TestEditor = Class.new(ActionText::Editor)

  test "#to_action_text_html transforms Content to a String" do
    expected = "<div>hello, world</div>"
    content = Content.new(expected)
    editor = TestEditor.new

    actual = editor.to_action_text_html(content)

    assert_kind_of String, actual
    assert_dom_equal expected, actual
  end

  test "#to_editor_html transforms Content to a String" do
    expected = "<div>hello, world</div>"
    content = Content.new(expected)
    editor = TestEditor.new

    actual = editor.to_editor_html(content)

    assert_kind_of String, actual
    assert_dom_equal expected, actual
  end

  test "#canonicalize_fragment returns the Fragment" do
    expected = "<div>hello, world</div>"
    fragment = Fragment.wrap(expected)
    editor = TestEditor.new

    actual = editor.canonicalize_fragment(fragment)

    assert_kind_of Fragment, actual
    assert_dom_equal expected, actual
  end

  test "#editor_name removes the Editor suffix" do
    editor = TestEditor.new

    assert_equal "test", editor.editor_name
  end

  test "#editor_tag returns a renderable" do
    editor = TestEditor.new
    editor_tag = editor.editor_tag(id: "test_editor_id", name: "message[body]", value: "<div>hello</div>")

    render(editor_tag)

    element = rendered.html.at("test-editor")
    assert_not element.key?("name")
    assert_equal "message[body]", editor_tag.name
    assert_equal "test_editor_id", element["id"]
    assert_equal "test-content", element["class"]
    assert_equal "<div>hello</div>", element["value"]
  end
end

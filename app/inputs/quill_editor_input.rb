class QuillEditorInput < Formtastic::Inputs::TextInput
  def to_html
    input_wrapping do
      label_html <<
      builder.text_area(method, input_html_options) <<
      quill_editor_js
    end
  end

  private

  def quill_editor_js
    <<-HTML.html_safe
      <script>
        document.addEventListener("DOMContentLoaded", function() {
          var quill = new Quill('##{dom_id}', {
            theme: 'snow'
          });
        });
      </script>
    HTML
  end

  def dom_id
    "#{object_name}_#{method}"
  end
end

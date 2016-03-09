module Components
  module Todos
    class TodoItem < React::Component::Base

      param :todo, type: Todo

      # param :my_param
      # param param_with_default: "default value"
      # param :param_with_default2, default: "default value" # alternative syntax
      # param :param_with_type, type: Hash
      # param :array_of_hashes, type: [Hash]
      # collect_all_other_params_as :attributes  #collects all other params into a hash

      # The following are the most common lifecycle call backs,
      # the following are the most common lifecycle call backs# delete any that you are not using.
      # call backs may also reference an instance method i.e. before_mount :my_method

      before_mount do
        # any initialization particularly of state variables goes here.
        # this will execute on server (prerendering) and client.
      end

      after_mount do
        # any client only post rendering initialization goes here.
        # i.e. start timers, HTTP requests, and low level jquery operations etc.
      end

      before_update do
        # called whenever a component will be re-rerendered
      end

      after_update do
        if state.editing
          edit_input = Element[".edit"]
          edit_input.focus
          `#{edit_input}[0].setSelectionRange(edit_input.val().length, edit_input.val().length)`
          # TODO replace with a select all
        end
      end

      before_unmount do
        # cleanup any thing (i.e. timers) before component is destroyed
      end

      def handle_blur
        state.editing! false
      end

      def handle_enter
        state.editing! false
      end

      def render
        li(class:"#{params.todo.complete ? "completed" : ""} #{state.editing ? "editing" : ""}") do
          if state.editing
            TitleEdit todo: params.todo, on_blur: -> {handle_blur}, on_enter: -> {handle_enter}, css_class: "edit"
          else
            div class: "view" do
              input(type: "checkbox", (params.todo.complete ? :defaultChecked : :unchecked) => true, class: "toggle").on(:click) do
                params.todo.complete = !params.todo.complete
                params.todo.save
              end
              label do
                params.todo.title
              end.on(:doubleClick) do
                state.editing! true
              end
              a(href:"", class: "destroy").on(:click) do
                params.todo.destroy
              end
            end
          end
        end
      end
    end
  end
end

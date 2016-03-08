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

      after_update do
        # called whenever a component will be re-rerendered
        if state.editing
          edit_element = Element[".edit"]
          edit_element.focus
          `#{edit_element}[0].setSelectionRange(edit_element.val().length, edit_element.val().length)`
        end
      end

      before_unmount do
        # cleanup any thing (i.e. timers) before component is destroyed
      end

      def render
        li(class: "#{params.todo.complete ? "completed" : ""} #{state.editing ? "editing" : ""}") do
          if state.editing
            input(class: 'edit', defaultValue: params.todo.title).on(:blur) do
              state.editing! false if state.editing
            end.on(:change) do |e|
              params.todo.title = e.target.value
            end.on(:key_down) do |e|
              if e.key_code == 13
                params.todo.save
                state.editing! false
              end
            end
          else
            div(class: "view")do
              input(type: :checkbox, (params.todo.complete ? :defaultChecked : :unchecked) => true, :class => "toggle").on(:click) do
                # alert("Yala!")
                params.todo.complete = !params.todo.complete
                params.todo.save
              end
              label do
                params.todo.title
              end.on(:doubleClick) do
                state.editing! true
              end
              a(class: :destroy).on(:click) do
                params.todo.destroy
              end
            end
          end
        end
      end
    end
  end
end

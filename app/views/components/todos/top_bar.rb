module Components
  module Todos
    class TopBar < React::Component::Base

      define_state :todo, type: Todo
      define_state editing: false

      before_mount do
        renew_todo
      end

      def renew_todo
        state.todo! Todo.new
      end

      def render
        TitleEdit todo: state.todo, on_blur: -> { renew_todo }, on_enter: -> { renew_todo }, css_class: "new-todo"
      end
    end
  end
end

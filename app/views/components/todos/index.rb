module Components
  module Todos
    class Index < React::Component::Base
      param :scope
      param :todos
      param :uncomplete_todo

      def render
        section class: "todoapp" do
          header class: "header" do
            h1 do
              "Todos"
            end
            TopBar()
          end

          section(class: "main", style: {display: "block"}) do
            ul class: "todo-list" do
              params.todos.each do |todo|
                TodoItem todo: todo
              end
            end
          end
          Footer(scope: params.scope, uncomplete_todo: params.uncomplete_todo)
        end
      end
    end
  end
end

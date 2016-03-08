module Components
  module Todos
    class Footer < React::Component::Base

      param :scope
      param :uncomplete_todo
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

      before_unmount do
        # cleanup any thing (i.e. timers) before component is destroyed
      end

      def render

        footer(class: "footer", style: {display: "block"}) do
          span(class: "todo-count") do
            "#{params.uncomplete_todo.count} #{params.uncomplete_todo.count > 1 ? "items" : "item"} left"
          end
          ul(class: "filters") do
            li { a(class: "#{'selected' if params.scope == "all"}", href: "/todos") { "All" }}
            li { a(class: "#{'selected' if params.scope == "complete"}", href: "/todos?scope=complete") { "Completed" }}
            li { a(class: "#{'selected' if params.scope == "active"}", href: "/todos?scope=active") { "Active" }}
          end
          button(class: "clear-completed", style: {display: "none"}) { "clear completed" }
        end

      end
    end
  end
end

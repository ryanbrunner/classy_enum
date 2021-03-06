class <%= class_name %> < ClassyEnum::Base
  enum_classes <%= args.map {|a| ":#{a}"}.join(", ") %>
end
<% args.each do |arg| %>
class <%= class_name + arg.camelize %> < <%= class_name %>
end
<% end %>

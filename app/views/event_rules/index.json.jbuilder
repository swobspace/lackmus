json.array!(@event_rules) do |event_rule|
  json.extract! event_rule, :id, :position, :filter, :action, :severity, :valid_until
  json.url event_rule_url(event_rule, format: :json)
end

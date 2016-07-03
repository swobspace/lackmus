class ApplyEventRuleService
  Result = ImmutableStruct.new( :success?, :error_messages, :event )

  def initialize(options = {})
    @options = options.symbolize_keys!
  end

  def call(event)
    @event = assign_filter(event)
    if @event.event_rule_id.nil?
      @event = check_signature_action(@event)
      result = Result.new(success: true, error_messages: [], event: @event)
    elsif @event.event_rule.action == "drop"
      result = Result.new(success: true, error_messages: [], event: nil)
    else
      if @event.event_rule.action == "ignore"
        @event.ignore = true
      end
      result = Result.new(success: true, error_messages: [], event: @event)
    end
  end

private

  def assign_filter(event)
    EventRule.order(:position).each do |event_rule|
      if Hash[event_rule.filter] == strattributes(event).slice(*event_rule.filter.keys)
        event.event_rule_id = event_rule.id
        break
      end
    end
    event
  end

  def strattributes(event)
    @strattributes ||= event.attributes.map{|k,v| [k, v.to_s]}.to_h
  end

  def check_signature_action(event)
    return event if event.signature.blank? 
    return nil   if event.signature.action == 'drop'
    if event.signature.action == 'ignore'
      event.ignore = true
    end
    event
  end

end

class CreateEventService
  Result = ImmutableStruct.new( :success?, :error_messages, :event )

  def initialize(options = {})
    @event_attributes = options
  end

  def call
    event = Event.new(event_attributes)
    apply_result = apply_event_rule.call(event)
    if apply_result.success?
      event = apply_result.event
      if event.save
        return_result = Result.new(success: true, error_messages: [], event: event)
      else
        return_result = Result.new(success: false, error_messages: event.errors.messages)
      end
    else
      return_result = Result.new(success: false, error_messages: apply_result.error_messages)
    end
  end

private
  attr_reader :reader, :event_attributes

  def apply_event_rule
    @apply_event_rule ||= ApplyEventRuleService.new
  end

end

class CreateEventService
  Result = ImmutableStruct.new( :success?, :error_messages, :event )

  def initialize(options = {})
    @event_attributes = options
  end

  def call
    @event = Event.new(event_attributes)
    if @event.save
      result = Result.new(success: true, error_messages: [], event: event)
    else
      result = Result.new(success: false, error_messages: @event.errors.messages)
    end
  end

private
  attr_reader :reader, :event_attributes, :event

end

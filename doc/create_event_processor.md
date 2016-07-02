CreateEventService
=====================

  instance = CreateEventService.new(event_attributes)

  # call processes and returns a immutable struct
  result = instance.call

  if result.success?
    # ...
  else
    flash[:error] = result.error_messages.join(", ")
    redirect_to 'new' # or something else
  end

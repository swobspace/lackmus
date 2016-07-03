ProcessEventRuleService
=====================

  instance = ProcessEventRuleService.new

  # call processes and returns a immutable struct
  result = instance.call(event)

  if result.success?
    # ...
    event = result.event
  else
    flash[:error] = result.error_messages.join(", ")
    redirect_to 'new' # or something else
  end

success? == true
  - no event rule found
  - event rule found, action processed, event may be dropped by rule


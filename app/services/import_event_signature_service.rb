class ImportEventSignatureService
  Result = ImmutableStruct.new( :success?, :error_messages, :signature )

  def initialize(options = {})
    @options = options.symbolize_keys!
    @signature_attributes = options
  end

  def call(event)
    @event = event
    @signature = Signature.create_with(signature_attributes).
                           find_or_initialize_by(signature_id: event.alert_signature_id)

    if signature.persisted?
      @signature = update_signature(signature, event)
      result = Result.new(success: true, error_messages: [], signature: signature)
    elsif signature.save
      result = Result.new(success: true, error_messages: [], signature: signature)
    else
      result = Result.new(success: false, error_messages: signature.errors.messages)
    end
  end

private
  attr_reader :reader, :signature_attributes, :event, :signature, :options

  def signature_attributes
    {
      signature_id: event.alert_signature_id,
      signature_info: event.alert_signature,
      action: options.fetch(:action, 'normal'),
      category: event.alert_category,
      severity: event.alert_severity,
      events_count: 1
    }
  end

  def update_signature(sig, ev)
    if sig.category.blank?
      sig.category = ev.alert_category
    end
    if sig.severity.blank?
      sig.severity = ev.alert_severity
    end
    sig
  end

end

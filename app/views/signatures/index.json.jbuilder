json.array!(@signatures) do |signature|
  json.extract! signature, :id, :signature_id, :signature_info, :references, :action
  json.url signature_url(signature, format: :json)
end

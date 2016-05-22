module EventConcerns
  extend ActiveSupport::Concern

  included do
  end

  def connection
    "#{proto.upcase} #{src_ip}:#{src_port} -> #{dst_ip}:#{dst_port}"
  end

  def payload_printable
    Base64.decode64(payload).gsub(/[^[:print:]\n]/,'.')
  end
end


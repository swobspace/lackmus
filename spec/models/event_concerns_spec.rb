require 'rails_helper'

RSpec.describe EventConcerns, type: :model do
  describe "#match_filter" do
    let(:event) { FactoryBot.create(:event, 
     'sensor' => 'mysensor',
     'src_ip' => '192.0.2.71',
     'src_port' => '1234',
     'dst_ip' => '198.51.100.33',
     'dst_port' => '1704',
     'proto' => 'PROTO',
     'alert_signature_id' => '47110815',
     'alert_category' => 'AlertCategory',
     'alert_severity' => 'AlertSeverity',
     'http_hostname' => 'webhost.example.com',
     'http_xff' => 'NNNN',
     'http_content_type' => 'plain/text',
     'http_status' => '201',
     'http_protocol' => '1.1',
     'http_method' => 'PUSH'
    )}

    it "matches identical filter" do
      filter = { 
        'sensor' => 'mysensor', 
        'src_ip' => '192.0.2.71',
        'src_port' => '1234',
        'dst_ip' => '198.51.100.33',
        'dst_port' => '1704',
        'proto' => 'PROTO'
      }

      expect(event.match_filter(filter)).to be_truthy
    end
  end
end

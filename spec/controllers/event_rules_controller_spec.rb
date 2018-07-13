require 'rails_helper'

# This spec was generated by rspec-rails when you ran the scaffold generator.
# It demonstrates how one might use RSpec to specify the controller code that
# was generated by Rails when you ran the scaffold generator.
#
# It assumes that the implementation code is generated by the rails scaffold
# generator.  If you are using any extension libraries to generate different
# controller code, this generated spec may or may not pass.
#
# It only uses APIs available in rails and/or rspec-rails.  There are a number
# of tools you can use to make these specs even more expressive, but we're
# sticking to rails and rspec-rails APIs to keep things simple and stable.
#
# Compared to earlier versions of this generator, there is very limited use of
# stubs and message expectations in this spec.  Stubs are only used when there
# is no simpler way to get a handle on the object needed for the example.
# Message expectations are only used when there is no simpler way to specify
# that an instance is receiving a specific message.

RSpec.describe EventRulesController, type: :controller do
  login_admin

  # This should return the minimal set of attributes required to create a valid
  # EventRule. As you add validations to EventRule, be sure to
  # adjust the attributes here as well.
  let(:valid_attributes) {
    FactoryBot.attributes_for(:event_rule)
  }

  let(:invalid_attributes) {
    { action: 'invalid' }
  }

  # This should return the minimal set of values that should be in the session
  # in order to pass any filters (e.g. authentication) defined in
  # EventRulesController. Be sure to keep this updated too.
  let(:valid_session) { {} }

  describe "GET #index" do
    it "assigns all event_rules as @event_rules" do
      event_rule = EventRule.create! valid_attributes
      get :index
      expect(assigns(:event_rules)).to eq([event_rule])
    end
  end

  describe "GET #show" do
    it "assigns the requested event_rule as @event_rule" do
      event_rule = EventRule.create! valid_attributes
      get :show, params: {:id => event_rule.to_param}
      expect(assigns(:event_rule)).to eq(event_rule)
    end
  end

  describe "GET #new" do
    context "without event" do
      it "assigns a new event_rule as @event_rule" do
	get :new, params: {}
	expect(assigns(:event_rule)).to be_a_new(EventRule)
      end
    end

    context "with event" do
      let(:event) { FactoryBot.create(:event, 'src_ip' => '192.0.2.7',
                      'dst_ip' => '198.51.100.3', 'src_port' => 1234, 'dst_port' => 99,
                      'sensor' => 'sentinel') }
      before(:each) do
        get :new, params: {event_id: event.to_param}
      end

      it { expect(assigns(:event_rule).filter['src_ip']).to eq('192.0.2.7') }
      it { expect(assigns(:event_rule).filter['src_port']).to eq(1234) }
      it { expect(assigns(:event_rule).filter['dst_ip']).to eq('198.51.100.3') }
      it { expect(assigns(:event_rule).filter['dst_port']).to eq(99) }
      it { expect(assigns(:event_rule).filter['sensor']).to eq('sentinel') }
    end
  end


  describe "GET #edit" do
    it "assigns the requested event_rule as @event_rule" do
      event_rule = EventRule.create! valid_attributes
      get :edit, params: {:id => event_rule.to_param}
      expect(assigns(:event_rule)).to eq(event_rule)
    end
  end

  describe "POST #create" do
    context "with valid params" do
      it "creates a new EventRule" do
        expect {
          post :create, params: {:event_rule => valid_attributes}
        }.to change(EventRule, :count).by(1)
      end

      it "assigns a newly created event_rule as @event_rule" do
        post :create, params: {:event_rule => valid_attributes}
        expect(assigns(:event_rule)).to be_a(EventRule)
        expect(assigns(:event_rule)).to be_persisted
        expect(assigns(:event_rule).filter.class.name).to eq('ActiveSupport::HashWithIndifferentAccess')
      end

      it "redirects to the created event_rule" do
        post :create, params: {:event_rule => valid_attributes}
        expect(response).to redirect_to(EventRule.last)
      end
    end

    context "with invalid params" do
      it "assigns a newly created but unsaved event_rule as @event_rule" do
        post :create, params: {:event_rule => invalid_attributes}
        expect(assigns(:event_rule)).to be_a_new(EventRule)
      end

      it "re-renders the 'new' template" do
        post :create, params: {:event_rule => invalid_attributes}
        expect(response).to render_template("new")
      end
    end
  end

  describe "PUT #update" do
    context "with valid params" do
      let(:new_attributes) {
        { severity: 99 }
      }

      it "updates the requested event_rule" do
        event_rule = EventRule.create! valid_attributes
        put :update, params: {:id => event_rule.to_param, :event_rule => new_attributes}
        event_rule.reload
        expect(event_rule.severity).to eq 99
      end

      it "assigns the requested event_rule as @event_rule" do
        event_rule = EventRule.create! valid_attributes
        put :update, params: {:id => event_rule.to_param, :event_rule => valid_attributes}
        expect(assigns(:event_rule)).to eq(event_rule)
      end

      it "redirects to the event_rule" do
        event_rule = EventRule.create! valid_attributes
        put :update, params: {:id => event_rule.to_param, :event_rule => valid_attributes}
        expect(response).to redirect_to(event_rule)
      end
    end

    context "with invalid params" do
      it "assigns the event_rule as @event_rule" do
        event_rule = EventRule.create! valid_attributes
        put :update, params: {:id => event_rule.to_param, :event_rule => invalid_attributes}
        expect(assigns(:event_rule)).to eq(event_rule)
      end

      it "re-renders the 'edit' template" do
        event_rule = EventRule.create! valid_attributes
        put :update, params: {:id => event_rule.to_param, :event_rule => invalid_attributes}
        expect(response).to render_template("edit")
      end
    end
  end

  describe "DELETE #destroy" do
    it "destroys the requested event_rule" do
      event_rule = EventRule.create! valid_attributes
      expect {
        delete :destroy, params: {:id => event_rule.to_param}
      }.to change(EventRule, :count).by(-1)
    end

    it "redirects to the event_rules list" do
      event_rule = EventRule.create! valid_attributes
      delete :destroy, params: {:id => event_rule.to_param}
      expect(response).to redirect_to(event_rules_url)
    end
  end

end

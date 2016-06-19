class EventRulesController < ApplicationController
  before_action :set_event_rule, only: [:show, :edit, :update, :destroy]
  before_action :add_breadcrumb_show, only: [:show]

  # GET /event_rules
  def index
    @event_rules = EventRule.all
    respond_with(@event_rules)
  end

  # GET /event_rules/1
  def show
    respond_with(@event_rule)
  end

  # GET /event_rules/new
  def new
    @event_rule = EventRule.new
    respond_with(@event_rule)
  end

  # GET /event_rules/1/edit
  def edit
  end

  # POST /event_rules
  def create
    @event_rule = EventRule.new(event_rule_params)

    @event_rule.save
    respond_with(@event_rule)
  end

  # PATCH/PUT /event_rules/1
  def update
    @event_rule.update(event_rule_params)
    respond_with(@event_rule)
  end

  # DELETE /event_rules/1
  def destroy
    @event_rule.destroy
    respond_with(@event_rule)
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_event_rule
      @event_rule = EventRule.find(params[:id])
    end

    # Only allow a trusted parameter "white list" through.
    def event_rule_params
      params.require(:event_rule).permit(:position, :filter, :action, :severity, :valid_until)
    end
end

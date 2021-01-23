class GroupEventsController < ApplicationController
  before_action :set_group_event, only: %i[show update destroy]

  # GET /group_events
  def index
    @group_events = GroupEvent.available.to_show

    render json: @group_events
  end

  # GET /group_events/1
  def show
    render json: @group_event.to_show
  end

  # POST /group_events
  def create
    @group_event = GroupEvent.new(group_event_params)

    if @group_event.save
      render json: @group_event, status: :created, location: @group_event, message: 'Event published successfully.'
    else
      @group_event.status = :draft
      @group_event.save(validate: false)
      render json: @group_event, status: :created, location: @group_event, message: 'Event created as draft.'
    end
  end

  # PATCH/PUT /group_events/1
  def update
    if @group_event.update_attributes(group_event_params)
      render json: @group_event
    else
      render json: @group_event.errors, status: :unprocessable_entity
    end
  end

  # DELETE /group_events/1
  def destroy
    @group_event.discarded!
    render json: {}, status: :ok
  end

  private

  # Use callbacks to share common setup or constraints between actions.
  def set_group_event
    @group_event = GroupEvent.find(params[:id])
  end

  # Only allow a trusted parameter "white list" through.
  def group_event_params
    params.fetch(:group_event, {}).permit!
  end
end

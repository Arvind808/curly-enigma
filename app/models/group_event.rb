class GroupEvent < ApplicationRecord
  include ActionView::Helpers::TextHelper

  enum status: %i[draft published discarded]

  before_validation :assign_values, on: %i[create update]

  scope :available, -> { where.not(status: 'discarded') }

  validates_presence_of :name, :description, :location, :start_at, :end_at, :duration, :status

  def to_duration
    "#{duration} Days"
  end

  def to_description
    self.description = simple_format(description)
  end

  def self.to_show
    all.map(&:to_show)
  end

  def to_show
    attributes[:description] = to_description
    attributes[:duration] = to_duration
    attributes
  end

  private

  def assign_values
    self.start_at ||= end_at - duration.to_i if end_at
    self.end_at ||= start_at + duration.to_i if start_at
    self.duration = (end_at - start_at).to_i if start_at && end_at
  end
end

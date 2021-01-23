require 'rails_helper'

RSpec.describe GroupEvent, type: :model do
  subject do
    described_class.new({
                          name: 'name',
                          description: 'desc',
                          start_at: 2.days.ago,
                          end_at: Date.today,
                          duration: 2,
                          location: 'location',
                          status: 0
                        })
  end
  it 'is valid with valid attributes' do
    expect(subject).to be_valid
  end

  it 'is not valid without a name' do
    subject.name = nil
    expect(subject).not_to be_valid
  end

  it 'is not valid without a description' do
    subject.description = nil
    expect(subject).not_to be_valid
  end

  it 'is not valid without a status' do
    subject.status = nil
    expect(subject).not_to be_valid
  end

  it 'is not valid without a location' do
    subject.location = nil
    expect(subject).not_to be_valid
  end

  it 'should auto calculate start_at' do
    subject.start_at = nil
    expect(subject).to be_valid
  end

  it 'should auto calculate end_at' do
    subject.end_at = nil
    expect(subject).to be_valid
  end

  it 'should auto calculate duration' do
    subject.duration = nil
    expect(subject).to be_valid
  end

  it 'triggers assign_values before validating record' do
    expect(subject).to receive(:assign_values)
    subject.save
  end

  describe '.to_description' do
    it 'should return formatted description' do
      expect(subject.to_description).to eq('<p>desc</p>')
    end
  end

  describe '.to_duration' do
    it 'should return duration in days' do
      expect(subject.to_duration).to eq('2 Days')
    end
  end

  describe '.to_show' do
    it 'should return hash with transformed output' do
      expect(subject).to receive(:to_duration)
      expect(subject).to receive(:to_description)
      subject.to_show
    end
  end
end

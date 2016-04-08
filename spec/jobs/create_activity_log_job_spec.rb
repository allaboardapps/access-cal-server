require 'rails_helper'

RSpec.describe CreateActivityLogJob, type: :job do
  include ActiveJob::TestHelper
  let(:creator) { FactoryGirl.create :user }
  let(:event) { FactoryGirl.create :event }
  let(:action) { ActivityActionTypes::CREATE }
  let(:description) { Faker::Hipster.words(9) }

  subject(:job) { described_class.perform_later(creator.id, event, action, description) }

  it "queues the job" do
    expect { job }.to change(ActiveJob::Base.queue_adapter.enqueued_jobs, :size).by(1)
  end

  it "matches with enqueued job" do
    expect {
      described_class.perform_later
    }.to have_enqueued_job(described_class)
  end

  it "is in default queue" do
    expect(described_class.new.queue_name).to eq("default")
  end

  it "executes perform" do
    perform_enqueued_jobs { job }
    expect(Activity.count).to eq 1
  end

  after do
    clear_enqueued_jobs
    clear_performed_jobs
  end
end

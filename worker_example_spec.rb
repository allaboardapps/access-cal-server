require "rails_helper"

describe WorkerExample, type: :worker do
  describe "#perform_async" do
    # it "creates a worker process to remove one_time_events" do
    #   expect { WorkerExample.perform_async }.to change(WorkerExample.jobs, :size).by 1
    # end

    # it "closes unended tutor sessions" do
    #   expect(TutorSession.all.count).to eq 1
    #   WorkerExample.perform_async
    #   expect(WorkerExample.jobs.size).to eq 1
    #   WorkerExample.drain
    #   expect(TutorSession.where(end_time: nil).count).to eq 0
    #   expect(WorkerExample.jobs.size).to eq 0
    # end

    # it "closes tutor sessions that lack an end_time value" do
    #   expect(running_tutor_sessions.count).to eq 2
    #   WorkerExample.perform_async
    #   WorkerExample.drain
    #   expect(running_tutor_sessions.count).to eq 1
    # end

    # it "adds jobs to the default queue" do
    #   WorkerExample.perform_async
    #   expect(WorkerExample).to be_processed_in :default
    # end

    # it "is retryable" do
    #   WorkerExample.perform_async
    #   expect(WorkerExample).to be_retryable 3
    # end

    # it "is retryable" do
    #   WorkerExample.perform_async
    #   expect(WorkerExample).to be_unique
    # end
  end
end

# require "rails_helper"

# describe WorkerExample, type: :worker do
#   describe "#perform_async" do
#     it "creates a worker process to update something" do
#       expect { WorkerExample.perform_async(1) }.to change(WorkerExample.jobs, :size).by 1
#     end

#     it "adds jobs to the default queue" do
#       WorkerExample.perform_async 1
#       expect(WorkerExample).to be_processed_in :bulk
#     end

#     it "is retryable" do
#       WorkerExample.perform_async 1
#       expect(WorkerExample).to be_retryable 3
#     end

#     it "is unique" do
#       WorkerExample.perform_async 1
#       expect(WorkerExample).to be_unique
#     end
#   end
# end

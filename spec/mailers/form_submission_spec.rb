require "rails_helper"

describe FormSubmissionMailer do
  describe "support" do
    # let(:user) { FactoryGirl.create :user }
    # let(:email) { FormSubmissionMailer.support user }

    # xit "renders the subject" do
    #   expect(email.subject).to eq "Events Server: Help"
    # end

    # xit "renders the receiver email" do
    #   expect(email.to).to eql user.email
    # end

    # xit "renders the sender email" do
    #   expect(email.from).to eq ["randy@innovationsforlearning.org"]
    # end

    # xit "assigns @full_name" do
    #   expect(email.body.encoded).to match user.full_name
    # end
  end

  describe "delay" do
    # xit "should send delayed emails to sidekiq queue" do
    #   expect { FormSubmissionMailer.delay.support("content")}.to change(Sidekiq::Extensions::DelayedMailer.jobs, :size).by(1)
    # end
  end
end

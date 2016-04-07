class FormSubmissionMailer < ActionMailer::Base
  def support(params)
    # mail(
    #   from: "no-reply@eventserver.com", # params[:form_submission][:email],
    #   to: "wrburgess@gmail.com", #AppSettings[:support_email],
    #   subject: "Events Server: Help",
    #   template_path: "mailers",
    #   template_name: "support"
    # )
  end
end

class ReportsController < ApplicationController
  # layout "reports"

  # before_action :authenticate_user!
  # skip_before_filter :verify_authenticity_token, only: [:export, :save]

  # def index
  #   @saved_reports = current_user.reports.active.where(report_request_type: ReportRequestTypes::SAVED).order(created_at: :desc)
  #   @viewed_reports = current_user.reports.active.where(report_request_type: ReportRequestTypes::VIEW).limit(10).order(created_at: :desc)
  #   @exported_reports = current_user.reports.active.where(report_request_type: ReportRequestTypes::EXPORT).limit(10).order(created_at: :desc)
  # end

  # def create
  #   report = Report.create(
  #     user_id: current_user.id,
  #     report_type: params[:report_type],
  #     report_request_type: ReportRequestTypes::VIEW,
  #     options: Report.get_options(request_params, current_user)
  #   )

  #   redirect_to reports_view_path(report_id: report.id)
  # end

  # def show
  #   @report = Report.find_by(id: params[:report_id], user: current_user)
  #   @sort_direction = get_alt_sort_direction

  #   if @report.present?
  #     @results = @report.get_results(params)
  #     @filters = Report.get_select_options(current_user.permissions)

  #     redirect_to reports_path, alert: "Report contents not available for that request." if @results.empty?
  #   else
  #     redirect_to reports_path, alert: "Report contents not available for that request."
  #   end
  # end

  # def save
  #   report = Report.find_by(id: params[:report_id], user: current_user)

  #   if report.present?
  #     Report.create(
  #       user_id: current_user.id,
  #       name: report.name,
  #       report_type: report.report_type,
  #       report_request_type: ReportRequestTypes::SAVED,
  #       options: report.options
  #     )

  #     redirect_to reports_path, alert: "Your report has been saved for easy retrieval."
  #   else
  #     redirect_to root_path, alert: "Report contents not available for your request."
  #   end
  # end

  # def export
  #   report = Report.find_by(id: params[:report_id], user: current_user)

  #   if report.present?
  #     exported_report = Report.create(
  #       user_id: current_user.id,
  #       report_type: report.report_type,
  #       report_request_type: ReportRequestTypes::EXPORT,
  #       options: report.options,
  #       download_url: "pending"
  #     )

  #     ReportExport.perform_async(exported_report.id, current_user.id)

  #     redirect_to reports_path, alert: "Your report export has been queued for processing."
  #   else
  #     redirect_to root_path, alert: "Report contents not available for your request."
  #   end
  # end

  # def delete
  #   report = Report.find_by(id: params[:id], user: current_user.id)

  #   if report.present?
  #     report.update_attribute(:archived, true)
  #     redirect_to reports_path, alert: "Report deleted"
  #   else
  #     redirect_to root_path
  #   end
  # end

  # private

  # def get_alt_sort_direction
  #   if params[:sort_direction] == "ASC"
  #     { sort_direction: "DESC" }
  #   else
  #     { sort_direction: "ASC" }
  #   end
  # end

  # def create_params
  #   params.permit(:name, :user_id, :report_type, :report_request_type, :options)
  # end

  # def request_params
  #   params.permit(:report_id, :report_type, :organization_id, :tutor_group_id, :district_id, :area_id, :school_id, :classroom_id, :start_date, :end_date, :sort_by, :sort_direction, :page)
  # end
end

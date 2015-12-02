class Report < ActiveRecord::Base

  # belongs_to :user

  # after_create :update_name

  # scope :active, -> { where(archived: false, test: false) }
  # scope :archived, -> { where(archived: true) }
  # scope :test, -> { where(test: true) }

  # def get_results(params)
  #   sort = Report.get_sorting(params)
  #   report_model = model_name

  #   results = case options["entity"]
  #   when "none"
  #     report_model.select(report_model.presented_columns).none
  #   when "any"
  #     report_model.select(report_model.presented_columns).order(sort).page(params[:page])
  #   else
  #     report_model.select(report_model.presented_columns).where("#{options['entity']}_id = ?", options["id"]).order(sort).page(params[:page])
  #   end

  #   return results
  # end

  # def get_export_results
  #   report_model = model_name

  #   results = case options["entity"]
  #   when "none"
  #     report_model.select(report_model.presented_columns).none
  #   when "any"
  #     report_model.select(report_model.presented_columns)
  #   else
  #     report_model.select(report_model.presented_columns).where("#{options['entity']}_id = ?", options["id"])
  #   end

  #   return results
  # end

  # def self.generate_and_export(report, user)
  #   time_stamp = Time.now.strftime("%Y%m%d-%H%M%S")
  #   file_name = "#{report.report_type}_#{user.id}_#{time_stamp}.csv"
  #   file_path = "#{Rails.root}/tmp/#{file_name}"
  #   key_name = "reports/#{file_name}"

  #   Report.generate_csv(report, file_path)
  #   csv_file = File.read(file_path)

  #   exported_file = Report.export_to_s3(csv_file, key_name)
  #   presigned_url = Report.get_presigned_url(exported_file)

  #   report.update_attribute(:download_url, presigned_url)

  #   ReportExportNotificationMailer.delay.notify(report.id, user.id)
  # end

  # def self.get_presigned_url(file)
  #   file.presigned_url(:get, expires_in: 3600)
  # end

  # def self.export_to_s3(csv_file, key_name)
  #   creds = Aws::Credentials.new(ENV["AWS_ACCESS_KEY_ID_REPORTS"], ENV["AWS_SECRET_ACCESS_KEY_REPORTS"])
  #   s3_client = Aws::S3::Client.new(region: AppSettings.aws_s3_west_region, credentials: creds)

  #   s3_client.put_object(
  #     bucket: AppSettings.central_station_reports_bucket,
  #     body: csv_file,
  #     key: key_name,
  #     content_type: AppSettings.reports_content_type
  #   )

  #   obj = Aws::S3::Object.new(
  #     bucket_name: AppSettings.central_station_reports_bucket,
  #     key: key_name,
  #     client: s3_client
  #   )
  # end

  # def self.generate_csv(report, file_path)
  #   results = report.get_export_results

  #   if results.any?
  #     columns = results.presented_columns.map{ |c| c.to_s }

  #     file_as_string = CSV.generate do |csv|
  #       csv << columns
  #       results.each do |ts|
  #         csv << ts.attributes.values_at(*columns)
  #       end
  #     end
  #   end

  #   File.open(file_path, "w"){ |csv| csv << file_as_string }
  # end

  # def self.get_options(params, current_user)
  #   filter = get_filter(params, current_user)

  #   { report_type: params[:report_type] }.merge(filter)
  # end

  # def self.get_select_options(permits)
  #   {
  #     organizations: permits["organizations"].map{ |e| [e["abbreviation"], e["id"]] },
  #     tutor_groups: permits["tutor_groups"].map{ |e| [e["name"], e["id"]] },
  #     districts: permits["districts"].map{ |e| [e["abbreviation"], e["id"]] },
  #     areas: permits["areas"].map{ |e| [e["abbreviation"], e["id"]] },
  #     schools: permits["schools"].map{ |e| [e["abbreviation"], e["id"]] },
  #     classrooms: permits["classrooms"].map{ |e| [e["name"], e["id"]] }
  #   }
  # end

  # def model_name
  #   "#{report_type.to_s.downcase.camelize}Report".constantize
  # end

  # def has_filter?(filter_type)
  #   model_name.filters.include? filter_type
  # end

  # def self.get_filter(params, current_user)
  #   permission = case
  #   when params[:organization_id].present?
  #     { entity: "organization", id: params[:organization_id] }
  #   when params[:tutor_group_id].present?
  #     { entity: "tutor_group", id: params[:tutor_group_id] }
  #   when params[:classroom_id].present?
  #     { entity: "classroom", id: params[:classroom_id] }
  #   when params[:school_id].present?
  #     { entity: "school", id: params[:school_id] }
  #   when params[:area_id].present?
  #     { entity: "area", id: params[:area_id] }
  #   when params[:district_id].present?
  #     { entity: "district", id: params[:district_id] }
  #   when current_user.staff?
  #     { entity: "any" }
  #   when current_user.is?(Roles::STUDENT)
  #     { entity: "none" }
  #   else
  #     current_user.highest_permission
  #   end

  #   unless current_user.has_permission?(permission)
  #     permission = { entity: "none" }
  #   end

  #   permission
  # end

  # def self.get_sorting(params)
  #   params[:sort_direction] ||= "ASC"

  #   if params[:sort_by].present?
  #     "#{params[:sort_by]} #{params[:sort_direction]}"
  #   else
  #     "1"
  #   end
  # end

  # def description
  #   case options["entity"]
  #   when "any", "none", nil
  #     "#{report_type.humanize.titleize} Report, No Filter"
  #   else
  #     entity = options["entity"].singularize.camelize.constantize.find(options["id"])
  #     "#{report_type.humanize.titleize} Report, Filtered by #{options["entity"].titleize}: #{(entity.abbreviation || entity.name)}"
  #   end
  # end

  # private

  # def update_name
  #   update_attribute(:name, description)
  # end
end

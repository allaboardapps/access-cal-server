require "rails_helper"

describe Report, type: :model do

  # it "has a valid factory" do
  #   expect(FactoryGirl.create :report).to be_valid
  # end

  # describe "#description" do
  #   before do
  #     @organization = FactoryGirl.create :organization
  #     @tutor_group = FactoryGirl.create :tutor_group
  #     @district = FactoryGirl.create :district
  #     @area = FactoryGirl.create :area
  #     @school = FactoryGirl.create :school
  #     @classroom = FactoryGirl.create :classroom
  #   end

  #   it "returns the correct description based on filter type" do
  #     test_setup = [
  #       { name: "Organization", object: @organization, params: { report_type: "classrooms", entity: "organization", id: @organization.id } },
  #       { name: "Tutor Group", object: @tutor_group, params: { report_type: "classrooms", entity: "tutor_group", id: @tutor_group.id } },
  #       { name: "District", object: @district, params: { report_type: "classrooms", entity: "district", id: @district.id } },
  #       { name: "Area", object: @area, params: { report_type: "classrooms", entity: "area", id: @area.id } },
  #       { name: "School", object: @school, params: { report_type: "classrooms", entity: "school", id: @school.id } },
  #       { name: "Classroom", object: @classroom, params: { report_type: "classrooms", entity: "classroom", id: @classroom.id } }
  #     ]
  #     test_setup.each do |test|
  #       report = FactoryGirl.create :report, options: test[:params]
  #       expect(report.description).to eq "#{report.report_type.titleize} Report, Filtered by #{test[:params][:entity].titleize}: #{test[:object].abbreviation}"
  #     end
  #   end

  #   it "returns the correct description based on filter type" do
  #     test_setup = [
  #       { name: "Classroom", object: @classroom, params: { report_type: "classrooms", entity: "any" } },
  #       { name: "Classroom", object: @classroom, params: { report_type: "classrooms", entity: "none" } }
  #     ]
  #     test_setup.each do |test|
  #       report = FactoryGirl.create :report, options: test[:params]
  #       expect(report.description).to eq "#{report.report_type.humanize.titleize} Report, No Filter"
  #     end
  #   end

  #   it "returns a description of unknown filter if not valid" do
  #     report = FactoryGirl.create :report, options: { report_type: ReportTypes::TUTOR_SESSIONS }
  #     expect(report.description).to eq "Tutor Sessions Report, No Filter"
  #   end
  # end

  # describe "#model_name" do
  #   xit "returns the correct model name for a report" do
  #     ReportTypes.constants.each do |report_type|
  #       report = FactoryGirl.create :report, report_type: ReportTypes.const_get(report_type.to_s)
  #       expect(report.model_name).to eq "#{report_type.to_s.downcase.camelize}Report".constantize
  #     end
  #   end
  # end

  # describe ".get_results" do
  #   xit "returns valid results for a requested report" do
  #     user = FactoryGirl.create :user
  #     classroom = FactoryGirl.create :classroom
  #     report = FactoryGirl.create :report, user: user, report_type: ReportTypes::CLASSROOMS, report_request_type: ReportRequestTypes::VIEW, options: { "entity" => "classroom", "id" => classroom.id, "page" => 1 }
  #     expect(report.get_results.count).to eq 2
  #   end
  # end

  # describe ".get_filter" do
  #   before do
  #     @organization = FactoryGirl.create :organization
  #     @tutor_group = FactoryGirl.create :tutor_group
  #     @district = FactoryGirl.create :district
  #     @area = FactoryGirl.create :area
  #     @school = FactoryGirl.create :school
  #     @classroom = FactoryGirl.create :classroom
  #   end

  #   it "returns the properly formatted filter hash" do
  #     user = FactoryGirl.create :user, roles: [UserRoles::STAFF]
  #     test_setup = [
  #       { name: "organization", entity: "any", id: @organization.id, object: @organization, params: { organization_id: @organization.id } },
  #       { name: "tutor_group", entity: "any", id: @tutor_group.id, object: @tutor_group, params: { tutor_group_id: @tutor_group.id } },
  #       { name: "district", entity: "any", id: @district.id, object: @district, params: { district_id: @district.id } },
  #       { name: "area", entity: "any", id: @area.id, object: @area, params: { area_id: @area.id } },
  #       { name: "school", entity: "any", id: @school.id, object: @school, params: { school_id: @school.id } },
  #       { name: "classroom", entity: "any", id: @classroom.id, object: @classroom, params: { classroom_id: @classroom.id } },
  #       { name: "any", entity: "any", id: nil, object: @classroom, params: { } }
  #     ]
  #     test_setup.each do |test|
  #       filter = Report.get_filter(test[:params], user)
  #       expect(filter[:entity]).to eq test[:name]
  #       expect(filter[:id]).to eq test[:id]
  #     end
  #   end

  #   it "returns the filter hash for a student" do
  #     user = FactoryGirl.create :user, roles: [UserRoles::STUDENT]
  #     FactoryGirl.create :classroom_user, user: user, classroom: @classroom, role: ClassroomUserRoles::STUDENT
  #     test_setup = [
  #       { name: "organization", entity: "none", id: nil, object: @organization, params: { organization_id: @organization.id } },
  #       { name: "tutor_group", entity: "none", id: nil, object: @tutor_group, params: { tutor_group_id: @tutor_group.id } },
  #       { name: "district", entity: "none", id: nil, object: @district, params: { district_id: @district.id } },
  #       { name: "area", entity: "none", id: nil, object: @area, params: { area_id: @area.id } },
  #       { name: "school", entity: "none", id: nil, object: @school, params: { school_id: @school.id } },
  #       { name: "classroom", entity: "none", id: nil, object: @classroom, params: { classroom_id: @classroom.id } },
  #       { name: "any", entity: "none", id: nil, object: @classroom, params: { } }
  #     ]
  #     test_setup.each do |test|
  #       filter = Report.get_filter(test[:params], user)
  #       expect(filter[:entity]).to eq test[:entity]
  #       expect(filter[:id]).to eq test[:id]
  #     end
  #   end

  #   it "returns the filter hash for a tutor without a role" do
  #     user = FactoryGirl.create :user, roles: [UserRoles::TUTOR]
  #     FactoryGirl.create :tutor_group_user, user: user, tutor_group: @tutor_group, role: TutorGroupUserRoles::TUTOR
  #     test_setup = [
  #       { name: "organization", entity: "none", id: nil, object: @organization, params: { organization_id: @organization.id } },
  #       { name: "tutor_group", entity: "none", id: nil, object: @tutor_group, params: { tutor_group_id: @tutor_group.id } },
  #       { name: "district", entity: "none", id: nil, object: @district, params: { district_id: @district.id } },
  #       { name: "area", entity: "none", id: nil, object: @area, params: { area_id: @area.id } },
  #       { name: "school", entity: "none", id: nil, object: @school, params: { school_id: @school.id } },
  #       { name: "classroom", entity: "none", id: nil, object: @classroom, params: { classroom_id: @classroom.id } }
  #     ]
  #     test_setup.each do |test|
  #       filter = Report.get_filter(test[:params], user)
  #       expect(filter[:entity]).to eq test[:entity]
  #       expect(filter[:id]).to eq test[:id]
  #     end
  #   end

  #   it "returns the filter hash for a tutor" do
  #     user = FactoryGirl.create :user, roles: [UserRoles::TUTOR]
  #     FactoryGirl.create :tutor_group_user, user: user, tutor_group: @tutor_group, role: TutorGroupUserRoles::COORDINATOR
  #     test_setup = [
  #       { name: "organization", entity: "none", id: nil, object: @organization, params: { organization_id: @organization.id } },
  #       { name: "tutor_group", entity: "tutor_group", id: @tutor_group.id, object: @tutor_group, params: { tutor_group_id: @tutor_group.id } },
  #       { name: "district", entity: "none", id: nil, object: @district, params: { district_id: @district.id } },
  #       { name: "area", entity: "none", id: nil, object: @area, params: { area_id: @area.id } },
  #       { name: "school", entity: "none", id: nil, object: @school, params: { school_id: @school.id } },
  #       { name: "classroom", entity: "none", id: nil, object: @classroom, params: { classroom_id: @classroom.id } }
  #     ]
  #     test_setup.each do |test|
  #       filter = Report.get_filter(test[:params], user)
  #       expect(filter[:entity]).to eq test[:entity]
  #       expect(filter[:id]).to eq  test[:id]
  #     end
  #   end

  #   it "returns the filter hash for a teacher" do
  #     user = FactoryGirl.create :user, roles: [UserRoles::TEACHER]
  #     FactoryGirl.create :classroom_user, user: user, classroom: @classroom, role: ClassroomUserRoles::PRIMARY_TEACHER
  #     UserUpdatePermissionsWorker.drain
  #     test_setup = [
  #       { name: "organization", entity: "none", id: nil, object: @organization, params: { organization_id: @organization.id } },
  #       { name: "tutor_group", entity: "none", id: nil, object: @tutor_group, params: { tutor_group_id: @tutor_group.id } },
  #       { name: "district", entity: "none", id: nil, object: @district, params: { district_id: @district.id } },
  #       { name: "area", entity: "none", id: nil, object: @area, params: { area_id: @area.id } },
  #       { name: "school", entity: "none", id: nil, object: @school, params: { school_id: @school.id } },
  #       { name: "classroom", entity: "classroom", id: @classroom.id, object: @classroom, params: { classroom_id: @classroom.id } }
  #     ]
  #     test_setup.each do |test|
  #       filter = Report.get_filter(test[:params], user.reload)
  #       expect(filter[:entity]).to eq test[:entity]
  #       expect(filter[:id]).to eq test[:id]
  #     end
  #   end
  # end

  # describe ".has_filter" do
  #   it "indicates inclusion of provided report filter type for classroom report" do
  #     test_setup = [
  #       { filter: ReportFilterTypes::CLASSROOM, result: be_truthy },
  #       { filter: ReportFilterTypes::SCHOOL, result: be_truthy },
  #       { filter: ReportFilterTypes::AREA, result: be_truthy },
  #       { filter: ReportFilterTypes::DISTRICT, result: be_truthy },
  #       { filter: ReportFilterTypes::TUTOR_GROUP, result: be_falsey },
  #       { filter: ReportFilterTypes::ORGANIZATION, result: be_falsey },
  #     ]
  #     report = FactoryGirl.create :report, report_type: ReportTypes::CLASSROOMS
  #     test_setup.each do |test|
  #       expect(report.has_filter?(test[:filter])).to test[:result]
  #     end
  #   end

  #   it "indicates inclusion of provided report filter type for tutor report" do
  #     test_setup = [
  #       { filter: ReportFilterTypes::CLASSROOM, result: be_falsey },
  #       { filter: ReportFilterTypes::SCHOOL, result: be_falsey },
  #       { filter: ReportFilterTypes::AREA, result: be_falsey },
  #       { filter: ReportFilterTypes::DISTRICT, result: be_falsey },
  #       { filter: ReportFilterTypes::TUTOR_GROUP, result: be_truthy },
  #       { filter: ReportFilterTypes::ORGANIZATION, result: be_truthy },
  #     ]
  #     report = FactoryGirl.create :report, report_type: ReportTypes::TUTORS
  #     test_setup.each do |test|
  #       expect(report.has_filter?(test[:filter])).to test[:result]
  #     end
  #   end
  # end

  # describe ".get_sorting" do
  #   it "returns a 1 to signify sort by first column if no sort_by param provided" do
  #     params = { sort_direction: "ASC" }
  #     expect(Report.get_sorting(params)).to eq "1"
  #   end

  #   it "returns a 1 to signify sort by first column if no sort params provided" do
  #     params = { sort_direction: "DESC" }
  #     expect(Report.get_sorting(params)).to eq "1"
  #   end

  #   it "returns a properly formatted sort clause which is ascending" do
  #     params = { sort_by: "classroom_name", sort_direction: "ASC" }
  #     expect(Report.get_sorting(params)).to eq "classroom_name ASC"
  #   end

  #   it "returns a properly formatted sort clause which is descending" do
  #     params = { sort_by: "classroom_name", sort_direction: "DESC" }
  #     expect(Report.get_sorting(params)).to eq "classroom_name DESC"
  #   end
  # end

  # describe ".get_select_options" do
  #   it "returns properly formatted filter arrays" do
  #     @organization = FactoryGirl.create :organization
  #     @tutor_group = FactoryGirl.create :tutor_group
  #     @district = FactoryGirl.create :district
  #     @area = FactoryGirl.create :area
  #     @school = FactoryGirl.create :school
  #     @classroom = FactoryGirl.create :classroom
  #     permits = { "organizations" => [@organization], "tutor_groups" => [@tutor_group], "districts" => [@district], "areas" => [@area], "schools" => [@school], "classrooms" => [@classroom] }
  #     select_options = Report.get_select_options(permits)

  #     expect(select_options[:organizations]).to eq [[@organization.abbreviation, @organization.id]]
  #     expect(select_options[:tutor_groups]).to eq [[@tutor_group.name, @tutor_group.id]]
  #     expect(select_options[:districts]).to eq [[@district.abbreviation, @district.id]]
  #     expect(select_options[:areas]).to eq [[@area.abbreviation, @area.id]]
  #     expect(select_options[:schools]).to eq [[@school.abbreviation, @school.id]]
  #     expect(select_options[:classrooms]).to eq [[@classroom.name, @classroom.id]]
  #   end

  #   it "returns properly formatted filter arrays for non-entities" do
  #     @district = FactoryGirl.create :district
  #     @area = FactoryGirl.create :area
  #     @school = FactoryGirl.create :school
  #     @classroom = FactoryGirl.create :classroom
  #     permits = { "organizations" => [], "tutor_groups" => [], "districts" => [@district], "areas" => [@area], "schools" => [@school], "classrooms" => [@classroom] }
  #     select_options = Report.get_select_options(permits)

  #     expect(select_options[:organizations]).to eq []
  #     expect(select_options[:tutor_groups]).to eq []
  #     expect(select_options[:districts]).to eq [[@district.abbreviation, @district.id]]
  #     expect(select_options[:areas]).to eq [[@area.abbreviation, @area.id]]
  #     expect(select_options[:schools]).to eq [[@school.abbreviation, @school.id]]
  #     expect(select_options[:classrooms]).to eq [[@classroom.name, @classroom.id]]
  #   end
  # end

  # it { is_expected.to belong_to :user }
end

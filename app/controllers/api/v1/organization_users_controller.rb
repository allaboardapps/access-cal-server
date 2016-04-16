class Api::V1::OrganizationUsersController < Api::V1::ApiController
  def create
    organization_user = OrganizationUser.find_or_create_by(create_params)
    render json: organization_user, each_serializer: OrganizationUserSerializer, status: :created
  end

  def destroy
    organization_user = OrganizationUser.find_by(id: params[:id])
    organization_user.destroy
    render json: {}, status: :accepted
  end

  private

  def create_params
    params.permit(
      :organization_id, :user_id, :role,
      :archived, :test, :dummy
    )
  end

  def destroy_params
    params.permit(
      :id
    )
  end
end

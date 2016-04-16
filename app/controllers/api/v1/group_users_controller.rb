class Api::V1::GroupUsersController < Api::V1::ApiController
  def create
    group_user = GroupUser.find_or_create_by(create_params)
    render json: group_user, each_serializer: GroupUserSerializer, status: :created
  end

  def destroy
    group_user = GroupUser.find_by(id: params[:id])
    group_user.destroy
    render json: {}, status: :accepted
  end

  private

  def create_params
    params.permit(
      :group_id, :user_id, :role,
      :archived, :test, :dummy
    )
  end

  def destroy_params
    params.permit(
      :id
    )
  end
end

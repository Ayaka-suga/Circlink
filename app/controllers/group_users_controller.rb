class GroupUsersController < ApplicationController

  def switch
    group_id = params[:id].to_i

    # current_user のサークルID一覧（純粋な groups.id）に含まれているか検証
    if current_user.groups.pluck(:id).include?(group_id)
      session[:current_group_id] = group_id
    end

    redirect_back(fallback_location: root_path)
  end

  def create
    @group = Group.find(params[:group_id])

    current_user.group_users.find_or_create_by(
      group: @group
    )

    redirect_to @group
  end
end
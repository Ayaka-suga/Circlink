class GroupsController < ApplicationController
    def index
        @groups = Group.all
    end

    def show
        @group = Group.find(params[:id])
        @tweets = @group.tweets
    end

    def new 
        @group = Group.new 
    end

    def create
        @group = Group.new(group_params)

        if @group.save
            redirect_to @group
        else
            render :new
        end
        
    end

    def switch
        # ユーザーが所属しているグループのIDリストを取得
        user_group_ids = current_user.groups.pluck("groups.id")
        target_id = params[:id].to_i

        # ターミナルにデバッグ情報を出力（原因特定用）
        Rails.logger.debug "=== [SWITCH DEBUG] 受け取ったID: #{params[:id]} (変換後: #{target_id}) ==="
        Rails.logger.debug "=== [SWITCH DEBUG] 所属グループID一覧: #{user_group_ids.inspect} ==="

        if user_group_ids.include?(target_id)
        session[:current_group_id] = target_id
        Rails.logger.debug "=== [SWITCH DEBUG] セッション更新成功: #{session[:current_group_id]} ==="
        else
        Rails.logger.debug "=== [SWITCH DEBUG] 警告: 所属していないグループIDが指定されました ==="
        end

        # Turboキャッシュによる表示崩れを防ぐため status: :see_other を指定
        redirect_back(fallback_location: root_path, status: :see_other)
    end

    private
    def group_params
        params.require(:group).permit(:circle)
    end
end

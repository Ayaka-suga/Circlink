class HomesController < ApplicationController
  def index
    return unless user_signed_in?

    @my_groups = current_user.groups

    # @current_group は ApplicationController で既にセットされているため
    # 選択中サークルの今後のイベントのみを取得
    if @current_group
      @tweets = @current_group.tweets
                              .where("start_time >= ? OR start_time IS NULL", Time.current)
                              .order(start_time: :asc)
    else
      @tweets = Tweet.none
    end
  end
end
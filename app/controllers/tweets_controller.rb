class TweetsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_tweet, only: [:show, :edit, :update, :destroy]

def index
    return @tweets = Tweet.none unless @current_group

    @tweets = @current_group.tweets

    if params[:tab] == "past"
      @tweets = @tweets.where("start_time < ?", Time.current).order(start_time: :desc)
    else
      @tweets = @tweets.where("start_time >= ? OR start_time IS NULL", Time.current).order(start_time: :asc)
    end

    if params[:keyword].present?
      @tweets = @tweets.where("event LIKE ?", "%#{params[:keyword]}%")
    end

    if params[:category].present?
      @tweets = @tweets.where(category: params[:category])
    end
  end

  def new
    @tweet = Tweet.new
  end

  def create
    return redirect_to groups_path, alert: "サークルを選択してください" unless @current_group

    @tweet = Tweet.new(tweet_params)
    @tweet.user_id = current_user.id
    @tweet.group = @current_group # ★ 選択中サークルをセット

    if @tweet.save
      redirect_to tweets_path, notice: "イベントを作成しました"
    else
      render :new, status: :unprocessable_entity
    end
  end

  def calendar
    @tweets = @current_group ? @current_group.tweets : Tweet.none
  end

  def show
    # before_action で set_tweet が実行されるため、中身は空でも問題ありません。
    # もし before_action を使わない場合は、以下の1行を直接記述してください。
    # @tweet = Tweet.find(params[:id])
  end

  def edit
  end

  def update
    if @tweet.update(tweet_params)
      redirect_to tweet_path(@tweet), notice: "イベントを更新しました"
    else
      render :edit, status: :unprocessable_entity
    end
  end

  def destroy
    @tweet.destroy
    redirect_to tweets_path, notice: "イベントを削除しました"
  end 
  

  private

  def set_tweet
    @tweet = Tweet.find(params[:id])
  end

  def tweet_params
    params.require(:tweet).permit(:event, :category, :date, :datetime, :about, :start_time, :end_time, :place, :deadline, :image)
  end
end
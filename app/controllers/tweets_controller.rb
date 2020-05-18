class TweetsController < ApplicationController
  before_action :authenticate_user!
  before_action :set_tweet, only: [:show, :update, :destroy]
  before_action :set_organization
  before_action :tweet_edit_allowed, only: [:edit, :update, :destroy]

  # GET /tweets
  def index
    @tweets = Tweet.where(organization_id: @organization.id)
    render json: @tweets
  end

  def all
    if policy.is_admin?(current_user)
      @tweets = Tweet.all
      render json: @tweets
    else
      render json: 'Unauthrised', status: :unprocessable_entity
    end
  end

  def my_tweets
    @tweets = current_user.tweets
    render json: @tweets

  end

  # GET /tweets/1
  def show
    render json: @tweet
  end

  # POST /tweets
  def create
    @tweet = Tweet.new(tweet_params.merge(user_id: current_user.id, organization_id: @organization.id))

    if @tweet.save
      render json: @tweet, status: :created, location: @tweet
    else
      render json: @tweet.errors, status: :unprocessable_entity
    end
  end

  # PATCH/PUT /tweets/1
  def update
    if @tweet.update(tweet_params)
      render json: @tweet
    else
      render json: @tweet.errors, status: :unprocessable_entity
    end
  end

  # DELETE /tweets/1
  def destroy
      @tweet.destroy
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_tweet
      @tweet = Tweet.find(params[:id])
    end

    def set_organization
      puts current_user.id
      @organization = current_user.organization
    end

    def policy
      Policy::TweetPolicy.new
    end

    def tweet_edit_allowed
      unless policy.edit_allowed?(@tweet, current_user)
        return render json: 'Unauthrised', status: :unprocessable_entity
      end
    end

    # Only allow a trusted parameter "white list" through.
    def tweet_params
      params.require(:tweet).permit(:message)
    end
end

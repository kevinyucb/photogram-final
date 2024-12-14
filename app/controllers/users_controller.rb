class UsersController < ApplicationController
  skip_before_action(:authenticate_user!, { :only => [:index] })
  def index
    matching_users = User.all
    @list_of_users = matching_users.order({ :username => :asc })
    render({ :template => "users/index" })
  end

  def show
    @the_username = params.fetch("username")

    @user = User.find_by(username: params[:username])

    @list_of_photos = Photo.where(owner_id: @user).order(updated_at: :desc)

    render({ :template => "users/show" })
  end

  def liked_photos
    @the_username2 = params.fetch("username")

    @user2 = User.find_by(username: params[:username])

    @list_of_photos_2 = Like.where(fan_id: @user2)

    render({ :template => "users/liked_photos" })
  end

  def feed
    @the_username3 = params.fetch("username")

    @user3 = User.find_by(username: params[:username])

    following_ids = FollowRequest.where(sender_id: @user3.id, status: "accepted").pluck(:recipient_id)

    @list_of_photos3 = Photo.where(owner_id: following_ids).order(created_at: :desc)

    render({ :template => "users/feed" })

    #use params hash and then fetch. 
  end


  def discover
    @the_username4 = params.fetch("username")

    @user4 = User.find_by(username: params[:username])

    following_ids = FollowRequest.where(sender_id: @user4.id, status: "accepted").pluck(:recipient_id)
    liked_photo_ids = Like.where(fan_id: following_ids).pluck(:photo_id)
    @list_of_photos4 = Photo.where(id: liked_photo_ids).order(created_at: :desc)

    render({ :template => "users/discover" })

  end
end

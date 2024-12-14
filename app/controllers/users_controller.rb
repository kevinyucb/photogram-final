class UsersController < ApplicationController
  def index
    matching_users = User.all

    @list_of_users = matching_users.order({ :created_at => :desc })

    render({ :template => "users/index" })
  end

  def show
    the_id = params.fetch("path_id")

    matching_users = User.where({ :id => the_id })

    @the_user = matching_users.at(0)

    render({ :template => "users/show" })
  end

  def create
    the_user = User.new
    the_user.comments_count = params.fetch("query_comments_count")
    the_user.email = params.fetch("query_email")
    the_user.encrypted_password = params.fetch("query_encrypted_password")
    the_user.likes_count = params.fetch("query_likes_count")
    the_user.private = params.fetch("query_private", false)
    the_user.remember_created_at = params.fetch("query_remember_created_at")
    the_user.reset_password_sent_at = params.fetch("query_reset_password_sent_at")
    the_user.reset_password_token = params.fetch("query_reset_password_token")
    the_user.username = params.fetch("query_username")
    the_user.own_photos_count = params.fetch("query_own_photos_count")

    if the_user.valid?
      the_user.save
      redirect_to("/users", { :notice => "User created successfully." })
    else
      redirect_to("/users", { :alert => the_user.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_user = User.where({ :id => the_id }).at(0)

    the_user.comments_count = params.fetch("query_comments_count")
    the_user.email = params.fetch("query_email")
    the_user.encrypted_password = params.fetch("query_encrypted_password")
    the_user.likes_count = params.fetch("query_likes_count")
    the_user.private = params.fetch("query_private", false)
    the_user.remember_created_at = params.fetch("query_remember_created_at")
    the_user.reset_password_sent_at = params.fetch("query_reset_password_sent_at")
    the_user.reset_password_token = params.fetch("query_reset_password_token")
    the_user.username = params.fetch("query_username")
    the_user.own_photos_count = params.fetch("query_own_photos_count")

    if the_user.valid?
      the_user.save
      redirect_to("/users/#{the_user.id}", { :notice => "User updated successfully."} )
    else
      redirect_to("/users/#{the_user.id}", { :alert => the_user.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_user = User.where({ :id => the_id }).at(0)

    the_user.destroy

    redirect_to("/users", { :notice => "User deleted successfully."} )
  end
end

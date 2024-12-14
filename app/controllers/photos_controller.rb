class PhotosController < ApplicationController
  skip_before_action(:authenticate_user!, { :only => [:index] })
  def index
    #matching_photos = Photo.all

    matching_photos = Photo.joins(:owner)
                           .where(users: { private: false })
                           .order(created_at: :desc)

    @list_of_photos = matching_photos.order({ :created_at => :desc })

    render({ :template => "photos/index" })
  end

  def show
    ### needs to redirect to the photo when I decide to actually sign in ###
    if current_user != nil
      the_id = params.fetch("path_id")

      matching_photos = Photo.where({ :id => the_id })

      @the_photo = matching_photos.at(0)

      current_id = @the_photo.owner_id
      
      @current_name = User.find(current_id).username

      @list_of_comments = Comment.where({ :photo_id => @the_photo.id }).order(created_at: :asc)
    
      render({ :template => "photos/show" })
    else
      flash[:alert] = "You need to sign in or sign up before continuing."
      redirect_to "/users/sign_in"
    end
  end

  def create
    the_photo = Photo.new
    the_photo.caption = params[:photo][:caption]
    the_photo.comments_count = params[:photo][:comments_count]
    the_photo.likes_count = params[:photo][:likes_count]
    the_photo.owner_id = params[:photo][:owner_id]
  
    the_photo.image = params[:photo][:image]
    
    if the_photo.valid?
      the_photo.save
      redirect_to("/photos", { :notice => "Photo created successfully." })
    else
      redirect_to("/photos", { :alert => the_photo.errors.full_messages.to_sentence })
    end
  end

  def update
    the_id = params.fetch("path_id")
    the_photo = Photo.where({ :id => the_id }).at(0)

    the_photo.caption = params.fetch("query_caption")
    the_photo.comments_count = params.fetch("query_comments_count")
    the_photo.image = params.fetch("query_image")
    the_photo.likes_count = params.fetch("query_likes_count")
    the_photo.owner_id = params.fetch("query_owner_id")

    if the_photo.valid?
      the_photo.save
      redirect_to("/photos/#{the_photo.id}", { :notice => "Photo updated successfully."} )
    else
      redirect_to("/photos/#{the_photo.id}", { :alert => the_photo.errors.full_messages.to_sentence })
    end
  end

  def destroy
    the_id = params.fetch("path_id")
    the_photo = Photo.where({ :id => the_id }).at(0)

    the_photo.destroy

    redirect_to("/photos", { :notice => "Photo deleted successfully."} )
  end
end

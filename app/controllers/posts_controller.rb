class PostsController < ApplicationController
  before_action :set_post, only: %i[ show edit update destroy ]
  before_action :require_admin, only: [:new, :create, :update, :edit, :destroy]

  # GET /posts or /posts.json
  def index
    if current_user && current_user.admin?
      @posts = Post.all
    else
      @posts = Post.where(hidden: false )
    end
  end

  # GET /posts/1 or /posts/1.json
  def show
    @post = Post.find(params[:id])
    
   
  end
  
  # GET /posts/new
  def new
    @post = Post.new
    @categories = Category.all
  end

  # GET /posts/1/edit
  def edit
    @categories = Category.all
  end

  # POST /posts or /posts.json
  def create
    @post = current_user.posts.new(post_params)

    respond_to do |format|
      if @post.save
        @post.save_post_images
        format.html { redirect_to post_url(@post), notice: "Post was successfully created." }
        format.json { render :show, status: :created, location: @post }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /posts/1 or /posts/1.json
  def update
    respond_to do |format|
      if @post.update(post_params)
        @post.save_post_images
        format.html { redirect_to post_url(@post), notice: "Post was successfully updated." }
        format.json { render :show, status: :ok, location: @post }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /posts/1 or /posts/1.json
  def destroy
    @post.destroy!

    respond_to do |format|
      format.html { redirect_to posts_url, notice: "Post was successfully destroyed." }
      format.json { head :no_content }
    end
  end

  def upload_image
    image = params[:image]

    if image.nil?
      render json: { success: 0, error: "No image found in request" }
      return
    end

    # Use Active Storage to attach the image without an associated post
    uploaded_image = PostImage.create!(image: image)

    # Generate a URL for the uploaded image
    stored_image_url = rails_blob_url(uploaded_image.image)

    render json: { success: 1, file: { url: stored_image_url } }
  rescue StandardError => e
    render json: { success: 0, error: e.message }
  end
  
  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post
      @post = Post.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def post_params
      params.require(:post).permit(:category_id, :title, :content, :cover_image, :description, :hidden)
    end

    def require_admin
      unless current_user && current_user.admin?
        render 'errors/error', status: :forbidden
      end
    end


end

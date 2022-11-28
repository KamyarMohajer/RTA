class ArticlesController < ApplicationController

  before_action :set_article, only: %i[ show edit update destroy ]
  before_action :authenticate_user!
  before_action :check_user_role,only: %i[edit update destroy]
  
  # GET /articles or /articles.json
  def index
    @articles = Article.where(user_id: 
    current_user.id)
  end

  # GET /articles/1 or /articles/1.json
  def show
  end

  # GET /articles/new
  def new
    @article = Article.new
  end

  # GET /articles/1/edit
  def edit
  end

  # POST /articles or /articles.json
  def create
    @article = current_user.
    articles.build(article_params)

    respond_to do |format|
      if @article.save
        format.html { redirect_to article_url(@article), notice: { message: "Article was successfully created.", color: "success" } }
        format.json { render :show, status: :created, location: @article }
      else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /articles/1 or /articles/1.json
  def update
    respond_to do |format|
      if @article.update(article_params)
        format.html { redirect_to article_url(@article), notice: { message: "Article was successfully updated.", color: "warning" } }
        format.json { render :show, status: :ok, location: @article }
      else
        format.html { render :edit, status: :unprocessable_entity }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # DELETE /articles/1 or /articles/1.json
  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to articles_url, notice: { message: "Article was successfully destroyed.", color: "danger" } }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_article
      @article = Article.find(params[:id])
    end

    # Only allow a list of trusted parameters through.
    def article_params
      params.require(:article).permit(:title, :description)
    end

    def check_user_role 
      if !(current_user.admin?)
        redirect_to root_path, notice: { message: "Access denied, Only Admins are allowed", color: "danger" }
      end
    end
end
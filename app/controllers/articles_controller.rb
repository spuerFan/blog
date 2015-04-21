class ArticlesController < ApplicationController

   #http_basic_authenticate_with name: "dhh", password: "secret", except: [:index, :show]

	def new
		if not current_user
			flash[:notice] = "warn.abc"
			redirect_to :root
			return
		else
		  @article = Article.new
		end
	end

	def index
		@articles = Article.all
		
	end

	def edit
		if not current_user 
		  flash[:notice] = "warn.abc"
		  redirect_to :root
		  return
		else 
		  @article = Article.find(params[:id])
          if @article.user != current_user
              flash[:notice] = "warn.abcd"
              redirect_to :root
		      return
		    end
		end 
		
	end

	def create

		@article = Article.new(article_params)

		
		if @article.save
		   redirect_to @article
		else
			render 'new'
		end
	end

	def show
		if not current_user
			flash[:notice] = "login.nouser"
			redirect_to :root
			return
		else
		  @article = Article.find(params[:id])
		end
		
	end

    def destroy
    	@article = Article.find(params[:id])
    	if current_user && current_user == @article.user
    	  @article.destroy
    	else
          flash[:notice] = "warn.abce" 
        end
    	  redirect_to articles_path
    	
    end

    def update
    	@article = Article.find(params[:id])

    	if @article.update(article_params)
    		redirect_to @article
    	else
    		render 'edit'
    	end
    end
	private
	  def article_params

	  	params.require(:article).permit(:titile, :text, :user_id)
	  	
	  end
end

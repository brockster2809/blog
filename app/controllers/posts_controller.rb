class PostsController < ApplicationController

before_action :authenticate_user!, except: [:index, :show]
before_action :seek_post, only: [:destroy, :edit, :show, :update]
def index
	@posts = Post.all.order("created_at desc")
end

def show
end

def new
	@post = Post.new
end

def create
	@post = Post.new(post_params)
	
	respond_to do |format|
		if @post.save
			flash[:success] = 'Post was successfully created.'
			format.html { redirect_to @post }
		else
			flash[:danger] = 'There was some problem creating the Post'
			format.html { render 'new'}
		end
	end
end

def edit
end

def update
	respond_to do |format|
		if @post.update(params[:post].permit(:title,:body))
			flash[:success] = 'Post was successfully updated.'
			format.html {redirect_to @post}
		else
			flash[:danger] = 'There was some problem while updating Post'
			format.html {render 'edit'}
		end
	end
end

def destroy
	@post.destroy
	flash[:success] = 'Post was successfully deleted.'
	respond_to do |format|
		format.html {redirect_to root_path}
	end
end

def seek_post
	@post = Post.find(params[:id])
end

def post_params
	params.require(:post).permit(:title, :body)
end

end

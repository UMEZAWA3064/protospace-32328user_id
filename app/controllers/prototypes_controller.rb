class PrototypesController < ApplicationController
  # before_action :authenticate_user!でログインしていないユーザーをログインページの画面に促す
  before_action :authenticate_user!, except: [:index, :show]  #exceptでログインしていない状態でもトップページ、詳細ページ、新規登録、ログインページに飛べる
  before_action :set_prototype, only: [:edit, :show]          #edit,showは同じ記述なのでset_prototypeとしてprivateメソッドに移し替える
  before_action :move_to_index, except: [:index, :show]       #未ログインユーザーが投稿画面などに直接アクセスしてきたらindexに遷移するようにする。index,showは除外
  before_action :correct_user,only: :edit                     #URL直打ち禁止にする。他のユーザーが編集できないようにする。


  def index
    @prototypes = Prototype.all
  end

  def new
    @prototype = current_user.prototypes.build
  end

  def create
    @prototype = Prototype.new(prototype_params)
    if @prototype.save
      redirect_to root_path
    else
      render :new
    end
  end

  def destroy
    prototype = Prototype.find(params[:id])
    prototype.destroy
    redirect_to root_path
  end

  def show
    @comment = Comment.new
    @comments = @prototype.comments.includes(:user)
  end

  def edit
    
  end

  def update
    @prototype = Prototype.find(params[:id])
    if @prototype.update(prototype_params)
      redirect_to prototype_path
    else
      render :edit
    end
  end

  def correct_user                         #他のユーザーがURLを直接打っても編集できないようにする
    @prototype = Prototype.find(params[:id])
    unless @prototype.user.id == current_user.id
  redirect_to action: :index
    end
  end

  private
  def prototype_params                     #def createの(prototype_params)の中身
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image).merge(user_id: current_user.id)
  end

  def set_prototype                         #edit,showを省略した内容
    @prototype = Prototype.find(params[:id])
  end

  def move_to_index                        #ログインしているユーザーでない時はindexに遷移する
    unless user_signed_in?
      redirect_to action: :index
    end
  end
end

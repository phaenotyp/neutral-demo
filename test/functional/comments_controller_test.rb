require 'test_helper'

class CommentsControllerTest < ActionController::TestCase
  def test_index
    get :index
    assert_template 'index'
  end

  def test_show
    @user = User.find(1)
    sign_in @user 
    get :show, :id => Comment.first
    assert_template 'show'
  end

  def test_new
    @user = User.find(1)
    sign_in @user
    get :new
    assert_template 'new'
  end

  def test_create_invalid
    @user = User.find(1)
    sign_in @user
    Comment.any_instance.stubs(:valid?).returns(false)
    post :create
    assert_template 'new'
  end

  def test_create_valid
    @user = User.find(1)
    sign_in @user
    Comment.any_instance.stubs(:valid?).returns(true)
    post :create
    assert_redirected_to comment_url(assigns(:comment))
  end

  def test_edit
    @user = User.find(1)
    sign_in @user
    get :edit, :id => Comment.first
    assert_template 'edit'
  end

  def test_update_invalid
    @user = User.find(1)
    sign_in @user
    Comment.any_instance.stubs(:valid?).returns(false)
    put :update, :id => Comment.first
    assert_template 'edit'
  end

  def test_update_valid
    @user = User.find(1)
    sign_in @user
    Comment.any_instance.stubs(:valid?).returns(true)
    put :update, :id => Comment.first
    assert_redirected_to comment_url(assigns(:comment))
  end

  def test_destroy
    @user = User.find(1)
    sign_in @user
    comment = Comment.first
    delete :destroy, :id => comment
    assert_redirected_to comments_url
    assert !Comment.exists?(comment.id)
  end
end

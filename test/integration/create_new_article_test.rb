require 'test_helper'

class CreateNewArticleTest < ActionDispatch::IntegrationTest
  setup do
    @user = User.create(username: 'johndoe', email:'johndoe@example.com',
    password: 'password')
    sign_in_as(@user)
  end
  test "create new article" do
    get '/articles/new'
    assert_response :success
    assert_difference "Article.count", 1 do
      post articles_path, params:{article: {title:'New article', description:'New article desc', category: 'Travel'}}
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success
    assert_match "New article", response.body
  end
end

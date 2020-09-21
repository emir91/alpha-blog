require 'test_helper'

class CreateNewUserTest < ActionDispatch::IntegrationTest
  test "sign up new user" do
    get "/signup"
    assert_response :success
    assert_difference  "User.count", 1 do
      post users_path, params: {user: {username: 'John Doe', email: 'john.doe@example.com', password: 'password'}}
      assert_response :redirect
    end
    follow_redirect!
    assert_response :success
    assert_match "John Doe", response.body
  end
end

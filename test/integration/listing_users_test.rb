require 'test_helper'

class ListingUsersTest < ActionDispatch::IntegrationTest
	setup { host! 'api.firmaexpress.dev' }

	test 'returns list of all users' do
		get '/users'
		assert_equal 200, response.status
		refute_empty response.body
	end

	test 'returns one single user by id' do
		user = User.find(1)
		get "/users/#{user.id}"
		assert_equal 200, response.status
		refute_empty response.body

		user_response = JSON.parse(response.body, symbolize_names: true)
		assert_equal user.id, user_response[:id]
	end
end
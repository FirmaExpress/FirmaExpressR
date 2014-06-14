require 'test_helper'

class ListingUsersTest < ActionDispatch::IntegrationTest
	setup { host! 'api.firmaexpress.dev' }

	test 'returns list of all users' do
		get '/users', {}, { 'Accept' => Mime::JSON }
		assert_equal 200, response.status
		refute_empty response.body
		assert_equal Mime::JSON, response.content_type
	end

	test 'returns one single user by id' do
		user = User.find(1)
		get "/users/#{user.id}", {}, { 'Accept' => Mime::JSON }
		assert_equal 200, response.status
		refute_empty response.body
		assert_equal Mime::JSON, response.content_type

		user_response = json(response.body)
		assert_equal user.id, user_response[:id]
	end
end
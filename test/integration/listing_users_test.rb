require 'test_helper'

class ListingUsersTest < ActionDispatch::IntegrationTest
	setup { host! 'api.firmaexpress.dev' }

	#users#index
	test 'returns list of all users: status ok' do
		get '/users', {}, { 'Accept' => Mime::JSON }
		assert_equal 200, response.status
	end

	test 'returns list of all users: response body is not empty' do
		get '/users', {}, { 'Accept' => Mime::JSON }
		refute_empty response.body
	end

	test 'returns list of all users: content_type JSON' do
		get '/users', {}, { 'Accept' => Mime::JSON }
		assert_equal Mime::JSON, response.content_type
	end

	#users#show
	test 'returns one single user by id: status ok' do
		user = User.find(1)
		get "/users/#{user.id}", {}, { 'Accept' => Mime::JSON }
		assert_equal 200, response.status
	end

	test 'returns one single user by id: response body is not empty' do
		user = User.find(1)
		get "/users/#{user.id}", {}, { 'Accept' => Mime::JSON }
		refute_empty response.body
	end

	test 'returns one single user by id: content_type JSON' do
		user = User.find(1)
		get "/users/#{user.id}", {}, { 'Accept' => Mime::JSON }
		assert_equal Mime::JSON, response.content_type
	end

	test 'returns one single user by id: gives the right user' do
		user = User.find(1)
		get "/users/#{user.id}", {}, { 'Accept' => Mime::JSON }

		user_response = json(response.body)
		assert_equal user.id, user_response[:id]
	end
end
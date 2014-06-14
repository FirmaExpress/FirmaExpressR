require 'test_helper'

class ListingUsersTest < ActionDispatch::IntegrationTest
	setup { host! 'api.firmaexpress.dev' }

	test 'returns list of all users' do
		get '/users'
		assert_equal 200, response.status
		refute_empty response.body
	end
end
require 'test_helper'

class ListingDocumentsTest < ActionDispatch::IntegrationTest
	setup { host! 'api.firmaexpress.dev' }

	test 'returns the documents of one single user' do
		user = User.find(1)
		get "/users/#{user.id}/documents", {}, { 'Accept' => Mime::JSON }
		assert_equal 200, response.status
		refute_empty response.body
		assert_equal Mime::JSON, response.content_type
	end
end
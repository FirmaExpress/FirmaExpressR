require 'test_helper'

class ListingDocumentsTest < ActionDispatch::IntegrationTest
	setup { host! 'api.firmaexpress.dev' }

	#documents#index
	test 'returns the documents of one single user: status ok' do
		user = User.find(1)
		get "/users/#{user.id}/documents", {}, { 'Accept' => Mime::JSON }
		assert_equal 200, response.status
	end

	test 'returns the documents of one single user: response body is not empty' do
		user = User.find(1)
		get "/users/#{user.id}/documents", {}, { 'Accept' => Mime::JSON }
		refute_empty response.body
	end

	test 'returns the documents of one single user: content_type JSON' do
		user = User.find(1)
		get "/users/#{user.id}/documents", {}, { 'Accept' => Mime::JSON }
		assert_equal Mime::JSON, response.content_type
	end

	test 'returns the documents of one single user: gives the documents of the right user' do
		user = User.find(1)
		get "/users/#{user.id}/documents", {}, { 'Accept' => Mime::JSON }

		documents_response = json(response.body)
		user_doc_relationships = documents_response.collect { |d| Participant.where(user_id: user.id, document_id: d[:id]).exists? }
		refute_includes user_doc_relationships, false
	end

	#documents#show
	test 'returns one single document: status ok' do
		document = Document.find(1)
		get "/documents/#{document.id}", {}, { 'Accept' => Mime::JSON }
		assert_equal 200, response.status
	end
	
	test 'returns one single document: response body is not empty' do
		document = Document.find(1)
		get "/documents/#{document.id}", {}, { 'Accept' => Mime::JSON }
		refute_empty response.body
	end
	
	test 'returns one single document: content_type JSON' do
		document = Document.find(1)
		get "/documents/#{document.id}", {}, { 'Accept' => Mime::JSON }
		assert_equal Mime::JSON, response.content_type
	end
	
	test "returns one single document: return the document when it belongs to the user who's logged in" do
		user = User.find(1)
		document = Document.find(1)
		get "/documents/#{document.id}", {}, { 'Accept' => Mime::JSON }
		document_response = json(response.body)
		puts document_response
		assert Participant.where(user_id: user.id, document_id: document_response[:id]).exists?
	end
end
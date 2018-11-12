require 'rails_helper'

RSpec.describe 'Tag management', type: :request do
  let(:data) { { attributes: { title: 'Tag1' } } }
  let(:returned_object) { parse_json(response.body)['data'] }

  describe 'creating a tag' do
    before do
      post '/api/v1/tags/', params: { data: data }
    end

    it 'creates the tag with the correct title' do
      title = returned_object['attributes']['title']

      expect(title).to eq(data[:attributes][:title])
    end

    it 'persists the tag' do
      id = returned_object['id']

      expect(id).not_to be_blank
    end
  end

  describe 'requesting the list of tags' do
    before do
      Tag.create(title: 'Tag2')
      Tag.create(title: 'Tag3')

      get '/api/v1/tags/'
    end

    it 'returns the correct number of tags' do
      expect(returned_object.count).to eq(2)
    end
  end

  describe 'updating a tag' do
    let!(:tag) { Tag.create(title: 'OldTag') }
    let(:data) { { attributes: { title: 'NewTag' } } }

    before do
      patch "/api/v1/tags/#{tag.id}/", params: { data: data }
    end

    it 'updates the tag' do
      expect(tag.reload.title).to eq(data[:attributes][:title])
    end

    it 'returns the expected tag' do
      id = returned_object['id'].to_i

      expect(id).to eq(tag.id)
    end
  end
end

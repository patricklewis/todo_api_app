require 'rails_helper'

RSpec.describe 'Task management', type: :request do
  let(:data) { { attributes: { title: 'Example task' } } }
  let(:returned_object) { parse_json(response.body)['data'] }

  describe 'creating a task' do
    before do
      post '/api/v1/tasks/', params: { data: data }
    end

    it 'creates the task with the correct title' do
      title = returned_object['attributes']['title']

      expect(title).to eq(data[:attributes][:title])
    end

    it 'persists the task' do
      id = returned_object['id']

      expect(id).not_to be_blank
    end
  end

  describe 'requesting the list of tasks' do
    before do
      Task.create(title: 'Another task')
      Task.create(title: 'A third task')

      get '/api/v1/tasks/'
    end

    it 'returns the correct number of tasks' do
      expect(returned_object.count).to eq(2)
    end
  end

  describe 'updating a task' do
    let!(:task) { Task.create(title: 'Old title') }
    let(:data) { { attributes: { title: 'New title' } } }

    before do
      patch "/api/v1/tasks/#{task.id}/", params: { data: data }
    end

    it 'updates the task' do
      expect(task.reload.title).to eq(data[:attributes][:title])
    end

    it 'returns the expected task' do
      id = returned_object['id'].to_i

      expect(id).to eq(task.id)
    end
  end

  describe 'deleting a task' do
    let!(:task) { Task.create(title: 'On borrowed time') }
    let!(:remaining_task) { Task.create(title: 'Remaining task') }

    before do
      delete "/api/v1/tasks/#{task.id}/"
    end

    it 'removes the task' do
      expect(Task.all).to contain_exactly(remaining_task)
    end
  end
end

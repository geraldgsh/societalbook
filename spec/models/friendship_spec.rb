require 'rails_helper'

RSpec.describe Friendship, type: :model do
  before :each do
    @requester = User.create(name: 'test1', email: 'test1@test.com',
                      password: '123456')
    @requestee = User.create(name: 'test2', email: 'test2@test.com',
                        password: '123456')
  end
  describe '#requestee' do
    it 'must have requestee' do
      request = @requester.friendships.build
      request.valid?
      expect(request.errors[:friend]).to include('must exist')

      request = @requester.friendships.build(friend_id: @requestee.id, status: false)
      expect(request.valid?).to eql(true)
      expect(request.errors[:friend]).to_not include('must exist')
    end

    it 'creates friendship request' do
      request = Friendship.create(user_id: @requester.id, friend_id: @requestee.id, status: false)

      expect(request.status).to eql(false)
      expect(Friendship.last.friend).to eql(@requestee)
    end
  end

  describe '#friend request' do
    before :each do
      @requestor = User.create(name: 'test4', email: 'test4@test.com', password: '123456')
      @responder = User.create(name: 'test5', email: 'test5@test.com', password: '123456')
      @friend_request = Friendship.create(user_id: @requestor.id, friend_id: @responder.id, status: false)
    end
    it 'returns requestor details on pending friendship' do
      pending_request = @responder.friend_requests
      expect(pending_request).to include(@requestor)
    end

    it 'returns no friend for requestee' do
      pending_request = @responder.friends
      expect(pending_request).to include()
    end

    it 'returns no friend for requester' do
      pending_request = @requestor.friends
      expect(pending_request).to include()
    end

    it 'returns no friend for requester' do
      pending_request = @requestor.pending_friends
      expect(pending_request).to include(@responder)
    end

    it 'returns no friend for requester' do
      pending_request = @responder.pending_friends
      expect(pending_request).to include()
    end

    it 'returns no confirmed friend in responder friend list' do
      pending_request = @responder.friend?(@requestor)
      expect(pending_request).to eql(false)
    end

    it 'returns no confirmed friend in reqeuestor friend list' do
      pending_request = @requestor.friend?(@responder)
      expect(pending_request).to eql(false)
    end

    it 'returns successfuly cancellation' do
      cancel_request = Friendship.find_by(user_id: @requestor.id, friend_id: @responder.id).destroy
      expect(cancel_request).to eql(@friend_request)
    end
  end  
end

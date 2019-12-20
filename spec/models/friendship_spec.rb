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

    it 'returns no friend for requestor' do
      pending_request = @requestor.friends
      expect(pending_request).to include()
    end

    it 'returns no pending friend for requestor' do
      pending_request = @requestor.pending_friends
      expect(pending_request).to include(@responder)
    end

    it 'returns no pending friend for responder' do
      pending_request = @responder.pending_friends
      expect(pending_request).to include()
    end

    it 'responder is not a friend of requestor' do
      pending_request = @responder.friend?(@requestor)
      expect(pending_request).to eql(false)
    end

    it 'requestor is not a friend of responder' do
      pending_request = @requestor.friend?(@responder)
      expect(pending_request).to eql(false)
    end

    it 'returns successful cancellation' do
      cancel_request = Friendship.find_by(user_id: @requestor.id, friend_id: @responder.id).destroy
      expect(cancel_request).to eql(@friend_request)
    end

    it 'friend confirmation' do
      confirm_request = @responder.confirm_friend(@requestor)
      expect(confirm_request).to eql(true)
    end
  end

  describe '#confirmed friend' do
    before :each do
      @requestor = User.create(name: 'test4', email: 'test4@test.com', password: '123456')
      @responder = User.create(name: 'test5', email: 'test5@test.com', password: '123456')
      @friend_request = Friendship.create(user_id: @requestor.id, friend_id: @responder.id, status: true)
    end
    it 'returns reponder details on friend requests' do
      pending_request = @responder.friend_requests
      expect(pending_request).to include()
    end

    it 'returns friend of requester' do
      pending_request = @requestor.friends
      responder = [@responder]
      expect(pending_request).to eql(responder)
    end

    it 'returns friend for requestee' do
      pending_request = @responder.friends
      requestor = [@requestor]
      expect(pending_request).to eql([])
    end

    it 'returns no pending friend request for requestee' do
      pending_request = @responder.pending_friends
      expect(pending_request).to include()
    end

    it 'returns no pending friend for requester' do
      pending_request = @requestor.pending_friends
      expect(pending_request).to include()
    end

    it 'returns confirmed friend in responder friend list' do
      pending_request = @responder.friend?(@requestor)
      expect(pending_request).to eql(false)
    end

    it 'returns confirmed friend in reqeuestor friend list' do
      pending_request = @requestor.friend?(@responder)
      expect(pending_request).to eql(true)
    end

    it 'returns successful friend removal' do
      cancel_friendship = Friendship.find_by(user_id: @requestor.id, friend_id: @responder.id).destroy
      expect(cancel_friendship).to eql(@friend_request)
    end
  end

  describe '#Mutual friendship' do
    before :each do
      @requestor = User.create(name: 'test4', email: 'test4@test.com', password: '123456')
      @responder = User.create(name: 'test5', email: 'test5@test.com', password: '123456')
      @friend_request = Friendship.create_friendship(@requestor.id, @responder.id)
    end
    it 'creates mutual friend request' do
      request = Friendship.create_friendship(@requestor.id, @responder.id)
      expect(request.length).to eql(2)
    end
    it 'creates mutual friend confirmation' do
      request = Friendship.confirm_friendship(@requestor.id, @responder.id)
      expect(request).to eql(true)
    end
    it 'creates mutual friend confirmation' do
      request = Friendship.delete_friendship(@requestor.id, @responder.id)
      expect(request).to eql(@friend_request[1])
    end
  end
end

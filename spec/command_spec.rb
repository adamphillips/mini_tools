require 'spec_helper'

require 'mini_tools/command'

describe MiniTools::Command do
  class TestCommand
    include MiniTools::Command

    def call param
      yield response :success, 'OK' and return if param == 1
      yield response :error, 'Fail' and return if param == 0
      yield response :unknown, 'Other' and return if param == 2
      yield response :unhandled, 'Unhandled'
    end
  end

  subject { TestCommand.new }

  describe 'response yielding' do
    describe 'when the interaction is successful' do
      it 'should yield a success response' do
        call_with 1
        assert_equal 'success', @state
        assert_equal 'OK', @message
      end
    end

    describe 'when the interaction errors' do
      it 'should yield an error response' do
        call_with 0
        assert_equal 'error', @state
        assert_equal 'Fail', @message
      end
    end

    describe 'when there is an unknown response' do
      it 'should yield an unknown response' do
        call_with 2
        assert_equal 'unknown', @state
        assert_equal 'Other', @message
      end
    end

    describe 'when the response is not explicitly handled' do
      it 'should be handled by the else response' do
        call_with 'whatever'
        assert_equal 'else', @state
        assert_equal 'Unhandled', @message
      end
    end

    describe 'when handling multiple responses with the same block' do
      it 'should work with the first case' do
        subject.call 0 do |response|
          response.on(:error, :unknown) do
            @state = 'handled'
          end
        end

        assert_equal 'handled', @state
      end

      it 'should work with the second case' do
        subject.call 2 do |response|
          response.on(:error, :unknown) do
            @state = 'handled'
          end
        end

        assert_equal 'handled', @state
      end

      it 'should not handle other cases' do
        subject.call 1 do |response|
          response.on(:error, :unknown) do
            @state = 'handled'
          end
        end

        assert_nil @state
      end
    end
  end

  def call_with param
    @state = false
    @message = nil

    subject.call param do |response|
      response.on(:success) do |m|
        @state = 'success'
        @message = m
      end

      response.on(:error) do |m|
        @state = 'error'
        @message = m
      end

      response.on(:unknown) do |m|
        @state = 'unknown'
        @message = m
      end

      response.else do |m|
        @state = 'else'
        @message = m
      end
    end
  end
end

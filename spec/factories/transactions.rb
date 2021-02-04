# frozen_string_literal: true

FactoryBot.define do
  factory :transaction, class: 'Transactions::Base' do
    user

    uuid { SecureRandom.uuid }
    customer_email { Faker::Internet.email }
    notification_url { 'somevalue'}
  
    factory :authorize, parent: :transaction, class: 'Transactions::Authorize' do
      amount { 110 }
      status { :pending }
    end

    factory :capture, class: 'Transactions::Capture' do
      amount { 110 }
      authorize { association :authorize, user: user,  created_at: created_at }
    end

    factory :refund, class: 'Transactions::Refund' do
      amount { 110 }
      capture { association :capture, status: :captured, user: user, created_at: created_at }
    end

    factory :void, class: 'Transactions::Void' do
      amount { 20 }
      authorize { association :authorize, status: :approved, user: user, created_at: created_at }
    end
  end
end

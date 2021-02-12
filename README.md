## About
Based on the given task, its related to Simple Payment Gateway API without using any external payment gateway gems
 - has merchants, admins user roles
 - merchants has many payment transactions of different types

## Solution
- Its a Basic functionality of handling transactions
  - API for processing of authorize, capture, refund, void transactions

Transaction Logic
  - All payment transactions are stored
  - Even failur transactions are stored with error status

UI
  - Main page has Admin-login, Merchant-login, Admin dashboard links and Merchant dashboard links
  - To access admin dashboard, user should be login as admin - [list all merchants with edit and destroy](https://github.com/AlekhyaR/merchant_payment_system/app/assets/images/manage_merchants.png)
  - To access merchant dashboard, user should be login as merchant - [list all transactions of merchant](https://github.com/AlekhyaR/merchant_payment_system/app/assets/images/list_of_transactions.png)


## Implementation
  - **Additional changes**
    - Moved business logic to app/concepts folder to decouple from Rails application.
  - Used following design patterns 
    - **Service Object** : Used for JWT as authentication layer and process business logic of payments.
    - **Form Objects** : Used for validate user's input.
    - **Use Cases** : Used to handle all user related operations.
    - **Policies** : Used to handle permissions.
    - **Presenters (View Model)** : Used to shape data for presentation layer.

[Single Table Inheritance ](https://github.com/AlekhyaR/merchant_payment_system/blob/master/app/assets/images/single_table_inheritance.png)
- Transaction status are implemented with simple enums. 

## Tests:
  - Specs are covered for all business logic
    - Pending: Specs are failing due to missing of authorizing user
    - Pending: Use Capybara, for feature specs
    
## Main focus:
  - Was on Application core and its business logic
  
## How to USE:
**Prerequisites**
  - Ruby 2.6.3
  - Rails 6.0.3
  - PostgreSQL 13.0
  - nodejs 12.18.3
  - yarn 1.22.10
  - bootstrap 4
  - faker gem - to seed data

## Commands to Run
- bundle install
- install above dependencies in prerequisites
- install bootstrap jquery popperjs using yarn
- rails db:create db:migrate db:seed
- rails server - start server

## API
1. Get token
```
curl \
  -X POST http://localhost:3000/api/v1/authenticate/sign_in \
  -D - \
  -d "email=admin@test.com" \
  -d "password=admin123"
```
- Read token value and use in it payment api transaction request
```
curl -v -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: bearer <token>' -X POST -d '{"type":"authorize",uuid":"3","amount":200,"customer_email":"test@test.com","notification_url":"http://mysite/my_notification_endpoint"}' http://localhost:3000/api/v1/payments

**Example**
curl -v -H 'Content-Type: application/json' -H 'Accept: application/json' -H 'Authorization: bearer eyJhbGciOiJIUzI1NiJ9.eyJtZXJjaGFudF91c2VyX2lkIjp7Im1lcmNoYW50X3VzZXJfaWQiOjF9fQ.nWnOK6go5GdIk55KNps-faQvuoPVUEPtiWGw-k8BSDc' -X POST -d '{"type":"authorize",uuid":"3","amount":50,"customer_email":"test@test.com","notification_url":"http://mysite/my_notification_endpoint"}' http://localhost:3000/api/v1/payments
```
  **Notes:**
  - Make sure uuid is unique for each request.
  - For Capture / void add `-F "authorize=:authorized"`, where `:authorized` is `uuid` to existing authorize
  - For refund add `-F "capture=:captureId" ` where `:chargeId` is `uuid` to existing capture 




  

  

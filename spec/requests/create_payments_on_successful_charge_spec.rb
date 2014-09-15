require 'spec_helper'

describe "Create payment on successful charge" do
  let(:event_data) do
    {
        "id"=> "evt_14cL8LLYcdnh37DjnTtrg06n",
        "created"=> 1410632429,
        "livemode"=> false,
    "type"=> "charge.succeeded",
        "data"=> {
        "object"=> {
        "id"=> "ch_14cL8LLYcdnh37DjeGUwZL0v",
        "object"=> "charge",
        "created"=> 1410632429,
        "livemode"=> false,
    "paid"=> true,
    "amount"=> 999,
        "currency"=> "usd",
        "refunded"=> false,
    "card"=> {
        "id"=> "card_14cL8KLYcdnh37DjNztsyDHQ",
        "object"=> "card",
        "last4"=> "4242",
        "brand"=> "Visa",
        "funding"=> "credit",
        "exp_month"=> 9,
        "exp_year"=> 2016,
        "fingerprint"=> "bWHi70YuX8gdz3kp",
        "country"=> "US",
        "name"=> nil,
    "address_line1"=> nil,
    "address_line2"=> nil,
    "address_city"=> nil,
    "address_state"=> nil,
    "address_zip"=> nil,
    "address_country"=> nil,
    "cvc_check"=> "pass",
        "address_line1_check"=> nil,
    "address_zip_check"=> nil,
    "customer"=> "cus_4lsu4Uj5ekkxhx"
    },
        "captured"=> true,
    "refunds"=> {
        "object"=> "list",
        "total_count"=> 0,
        "has_more"=> false,
    "url"=> "/v1/charges/ch_14cL8LLYcdnh37DjeGUwZL0v/refunds",
        "data"=> []
    },
        "balance_transaction"=> "txn_14cL8LLYcdnh37DjBCcNPctK",
        "failure_message"=> nil,
    "failure_code"=> nil,
    "amount_refunded"=> 0,
        "customer"=> "cus_4lsu4Uj5ekkxhx",
        "invoice"=> "in_14cL8LLYcdnh37DjEZwUWGoW",
        "description"=> nil,
    "dispute"=> nil,
    "metadata"=> {},
        "statement_description"=> "Myflix",
        "receipt_email"=> nil
    }
    },
        "object"=> "event",
        "pending_webhooks"=> 1,
        "request"=> "iar_4lsuPFunuSqxrg"
    }
  end
  it "creates a payment with the webhook from stripe for charge succeeeded", :vcr do
    post "/stripe_events", event_data
    expect(Payment.count).to eq(1)
  end

  it "creates the payment associated with the user", :vcr do
    alice = Fabricate(:user, customer_token: "cus_4lsu4Uj5ekkxhx")
    post "/stripe_events", event_data
    expect(Payment.first.user).to eq(alice)
  end

  it "creates the payment with the amount", :vcr do
    alice = Fabricate(:user, customer_token: "cus_4lsu4Uj5ekkxhx")
    post "/stripe_events", event_data
    expect(Payment.first.amount).to eq(999)
  end

  it "creates the payment with reference id", :vcr do
    alice = Fabricate(:user, customer_token: "cus_4lsu4Uj5ekkxhx")
    post "/stripe_events", event_data
    expect(Payment.first.reference_id).to eq("ch_14cL8LLYcdnh37DjeGUwZL0v")
  end
end
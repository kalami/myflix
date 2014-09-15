require 'spec_helper'

describe "Deactivate user on failed charge" do
  let(:event_data) do
    {
        "id"=> "evt_14cTjwLYcdnh37Dj6fxjOVNF",
        "created"=> 1410665512,
        "livemode"=> false,
    "type"=> "charge.failed",
        "data"=> {
        "object"=> {
        "id"=> "ch_14cTjwLYcdnh37DjuXYC8DKk",
        "object"=> "charge",
        "created"=> 1410665512,
        "livemode"=> false,
    "paid"=> false,
    "amount"=> 999,
        "currency"=> "usd",
        "refunded"=> false,
    "card"=> {
        "id"=> "card_14cTitLYcdnh37Dj73Tqim3s",
        "object"=> "card",
        "last4"=> "0341",
        "brand"=> "Visa",
        "funding"=> "credit",
        "exp_month"=> 9,
        "exp_year"=> 2018,
        "fingerprint"=> "Uwa6qthwssZBj75w",
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
    "customer"=> "cus_4lAn9DHY801g8k"
    },
        "captured"=> false,
    "refunds"=> {
        "object"=> "list",
        "total_count"=> 0,
        "has_more"=> false,
    "url"=> "/v1/charges/ch_14cTjwLYcdnh37DjuXYC8DKk/refunds",
        "data"=> []
    },
        "balance_transaction"=> nil,
    "failure_message"=> "Your card was declined.",
        "failure_code"=> "card_declined",
        "amount_refunded"=> 0,
        "customer"=> "cus_4lAn9DHY801g8k",
        "invoice"=> nil,
    "description"=> "myflix",
        "dispute"=> nil,
    "metadata"=> {},
        "statement_description"=> "Myflix fail",
        "receipt_email"=> nil
    }
    },
        "object"=> "event",
        "pending_webhooks"=> 1,
        "request"=> "iar_4m1n6PNoJIyrGb"
    }
  end

  it "deactivates a user with the web hook data from stripe for charge failed", :vcr do
    alice = Fabricate(:user, customer_token: "cus_4lAn9DHY801g8k")
    post "/stripe_events", event_data
    expect(alice.reload).not_to be_active
  end
end
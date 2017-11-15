require "rails_helper"

RSpec.describe "Routes to books" do
  it {
    expect(get: 'books/1/reserve').to route_to({
      "controller" => "reservations",
      "action" => "reserve",
      "book_id" => "1"
    })
  }

  it {
    expect(get: 'books/1/take').to route_to({
      "controller" => "reservations",
      "action" => "take",
      "book_id" => "1"
    })
  }

  it {
    expect(get: 'books/1/give_back').to route_to({
      "controller" => "reservations",
      "action" => "give_back",
      "book_id" => "1"
    })
  }

  it {
    expect(get: 'books/1/cancel_reservation').to route_to({
      "controller" => "reservations",
      "action" => "cancel",
      "book_id" => "1"
    })
  }

  it {
    expect(get: 'users/1/reservations').to route_to({
      "controller" => "reservations",
      "action" => "users_reservations",
      "user_id" => "1"
    })
  }

  it {
    expect(get: 'google-isbn').to route_to({
      "controller" => "google_books",
      "action" => "show"
    })
  }

  it {
    expect(get: 'books').to route_to({
      "controller" => "books",
      "action" => "index"
    })
  }

  it {
    expect(get: 'books/new').to route_to({
      "controller" => "books",
      "action" => "new"
    })
  }

  it {
    expect(post: 'books').to route_to({
      "controller" => "books",
      "action" => "create"
    })
  }

  it {
    expect(get: 'books/1').to route_to({
      "controller" => "books",
      "action" => "show",
      "id" => "1"
    })
  }
end

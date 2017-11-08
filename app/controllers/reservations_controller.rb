class ReservationsController < ApplicationController
  before_action :load_user, only: [:users_reservations]

  def reserve
    book.reserve(current_user) if book.can_reserve?(current_user)
    redirect_to(book_path(book.id))
  end

  def take
    reservation_handler.take(book)
    redirect_to(book_path(book.id))
  end

  def give_back
    reservation_handler.give_back(book)
    redirect_to(book_path(book.id))
  end

  def cancel
    book.cancel_reservation(current_user)
    redirect_to(book_path(book.id))
  end

  def users_reservations
  end

  def can_reserve?(user)
    reservations.find_by(user: user, status: 'RESERVED').nil?
  end

  private

  def book
    @book ||= Book.find(params[:book_id])
  end

  def load_user
    @user = User.find(params[:user_id])
  end

  def reservation_handler
    @reservation_handler ||= ::ReservationsHandler.new(current_user)
  end
end

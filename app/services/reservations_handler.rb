class ReservationsHandler
  def initialize(user)
    @user = user
  end

  def take(book)
    return "Book is not available for reservation" unless book.can_be_taken?(user)

    if available_reservation(book).present?
      available_reservation(book).update_attributes(status: 'TAKEN')
    else
      book.reservations.create(user: user, status: 'TAKEN')
    end
  end

  def give_back(book)
    return false unless book.can_give_back?(user)
    ActiveRecord::Base.transaction do
      book.reservations.find_by(status: 'TAKEN').update_attributes(status: 'RETURNED')
      book.next_in_queue.update_attributes(status: 'AVAILABLE') if book.next_in_queue.present?
    end
  end

  def reserve(user)
    return unless can_reserve?(user)

    reservations.create(user: user, status: 'RESERVED')
  end

  def cancel_reservation(user)
    reservations.where(user: user, status: 'RESERVED').order(created_at: :asc).first.update_attributes(status: 'CANCELED')
  end

  def can_be_taken?(book)
    not_taken?(book) && ( available_for_user?(book) || reservations.empty? )
  end

  def can_give_back?(book)
    book.reservations.find_by(user: @user, status: 'TAKEN').present?
  end

  def available_for_user?(book)
    if available_reservation(book).present?
      available_reservation(book).user == @user
    else
      pending_reservations(book).nil?
    end
  end

  def available_reservation(book)
    book.reservations.find_by(status: 'AVAILABLE')
  end

  private

  attr_reader :user
end



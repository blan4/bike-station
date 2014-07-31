class RentService
  def open_rent(input)
    user = User.create(input.user.attributes)
    bike = Bike.find(input.bike_id)
    rent = Rent.new(user: user, bike: bike, openned_at: DateTime.now)
    rent if rent.save
  end

  def close_rent(rent_id)
    rent = Rent.where('closed_at is NULL').find_by(id: rent_id)
    rent.update_attribute(:closed_at, DateTime.now) if rent
    rent
  end
end
 require_relative 'station'

class Journey

  attr_reader :journey

  def initialize(station)
    @journey = {:entry_station => station.name, :entry_zone => station.zone, :exit_station => nil, :exit_zone => nil}
  end

  def finish(station)
    @journey[:exit_station] = station.name
    @journey[:exit_zone] = station.zone
  end
end

 require_relative 'station'

class Journey

  attr_reader :journey

  def initialize
    @journey = {}
  end

  def start(station)
    @journey[:entry_station] = station.name
    @journey[:entry_zone] = station.zone
  end

  def finish(station)
    @journey[:exit_station] = station.name
    @journey[:exit_zone] = station.zone
  end

  def complete?
    !(@journey[:exit_station] && @journey[:entry_station]).nil?
  end

end

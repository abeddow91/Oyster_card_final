require_relative 'journey'

class JourneyLog

  attr_reader :current_journey

  def initialize(current_journey = Journey.new)
    @current_journey = current_journey
  end

  def start(station)
    @current_journey.start(station)
  end

  def finish(station)
    @current_journey.finish(station)
  end

end

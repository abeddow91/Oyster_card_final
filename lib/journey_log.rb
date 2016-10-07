require_relative 'journey'

class JourneyLog

  attr_reader :current_journey, :journey_history

  def initialize(current_journey = Journey.new)
    @current_journey = current_journey
    @journey_history = []
  end

  def start(station)
    @current_journey.start(station)
  end

  def finish(station)
    @current_journey.finish(station)
    journey_checker
  end

  private

  def journey_checker
    @current_journey.complete? ? log_complete :  @current_journey
  end

  def log_complete
    @journey_history << @current_journey
    @current_journey = Journey.new
  end
end

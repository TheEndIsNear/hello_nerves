defmodule HelloNerves do
  alias Circuits.GPIO
  require Logger

  @output_pin 4

  def start(_type, _args) do
    spawn(fn -> init() end)
    {:ok, self()}
  end

  def init() do
    {:ok, gpio} = GPIO.open(@output_pin, :output)
    loop(gpio)
  end

  defp loop(gpio) do
    Logger.debug("Turning on the LED")
    turn_on(gpio)
    :timer.sleep(1000)
    turn_off(gpio)
    Logger.debug("Turning off the LED")
    :timer.sleep(1000)
    loop(gpio)
  end

  defp turn_on(gpio), do: GPIO.write(gpio, 1)
  defp turn_off(gpio), do: GPIO.write(gpio, 0)
end

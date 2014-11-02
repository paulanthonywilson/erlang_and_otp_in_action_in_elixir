defmodule NonOtpDiePlease do
  @sleep_time 2000

  def go do
    :timer.sleep(@sleep_time)
    :i_want_to_die = :right_now
  end
end



# Erlang logging

:error_logger.info_msg "This is logged through Erlang's error logger~n"
:error_logger.info_msg "This is logged with some ~s~n", ["Erlang formatting"]


require Logger # needed for the Elixir log macros

Logger.info "And this is a bit of Elixir logging"
Logger.info "Elixir logging doesn's seem keen on the format strings..."
Logger.info "but String interplation works so that 3 + 2 = #{3 + 2}"



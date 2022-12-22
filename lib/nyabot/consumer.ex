defmodule Nyabot.Consumer do
  @moduledoc false
  use Nostrum.Consumer

  alias Nyabot.Commands
  alias Nostrum.Api

  require Logger

  def start_link do
    Consumer.start_link(__MODULE__)
  end

  def handle_event({:READY, %{user: user} = _event, _ws_state}) do
    Commands.register_commands()
    IO.puts("#{user.username} is logged in")
    Api.update_status(:dnd, "piss baby", 2)
  end

  def handle_event({:INTERACTION_CREATE, interaction, _ws_state}) do
    Commands.handle_interaction(interaction)
  end

  def handle_event({:VOICE_SPEAKING_UPDATE, payload, _ws_state}) do
    Logger.debug("VOICE SPEAKING UPDATE #{inspect(payload)}")
  end

  def handle_event(_data) do
    :ok
  end
end

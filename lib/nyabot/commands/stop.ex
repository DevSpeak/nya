defmodule Nyabot.Commands.Stop do
  @behaviour Nyabot.Command

  alias Nyabot.Command
  alias Nostrum.Api
  alias Nostrum.Voice
  alias Nostrum.Cache.GuildCache

  @impl Nyabot.Command
  def spec(name) do
    %{
      name: name,
      description: "Stops playing",
    }
  end

  @impl Nyabot.Command
  def handle_interaction(%{guild_id: guild_id} = interaction) do
    Voice.stop(guild_id)

    Api.create_interaction_response(interaction, %{
      type: 4,
      data: %{content: "Stopped playing ( ´•̥̥̥▿•̥̥̥` )"}
    })
  end
end

defmodule Nyabot.Commands.Play do
  @behaviour Nyabot.Command

  alias Nyabot.Command
  alias Nostrum.Api
  alias Nostrum.Voice
  alias Nostrum.Cache.GuildCache

  @impl Nyabot.Command
  def spec(name) do
    %{
      name: name,
      description: "Play a song",
      options: [
        %{
          type: 3,
          name: "url",
          description: "URL to youtube video",
          required: true
        }
      ]
    }
  end

  @impl Nyabot.Command
  def handle_interaction(%{guild_id: guild_id} = interaction) do
    if Voice.ready?(guild_id) do
      Voice.play(guild_id, Command.get_option(interaction, "url").value, :ytdl)

      Api.create_interaction_response(interaction, %{
        type: 4,
        data: %{content: "Playing the requested song (๑˃̵　ᴗ　˂̵)و"}
      })
    else
      Api.create_interaction_response(interaction, %{
        type: 4,
        data: %{content: "You need to summon me first ʕ – ᴥ – ʔ"}
      })
    end
  end
end

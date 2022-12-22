defmodule Nyabot.Commands.Summon do
  @behaviour Nyabot.Command

  alias Nyabot.Command
  alias Nostrum.Api
  alias Nostrum.Voice
  alias Nostrum.Cache.GuildCache

  @impl Nyabot.Command
  def spec(name) do
    %{
      name: name,
      description: "Joins voice channel"
    }
  end

  @impl Nyabot.Command
  def handle_interaction(%{guild_id: guild_id} = interaction) do
    case get_voice_channel(interaction) do
      nil -> {:msg, "You must be in a voice channel to summon"}
      voice_channel_id -> Voice.join_channel(guild_id, voice_channel_id)
    end

    Api.create_interaction_response(interaction, %{
      type: 4,
      data: %{content: "I've been summoned (′ꈍωꈍ‵)"}
    })
  end

  @spec get_voice_channel(%{
          :guild_id => non_neg_integer,
          :user => %{:id => any, optional(any) => any},
          optional(any) => any
        }) :: any
  def get_voice_channel(%{guild_id: guild_id, user: %{id: user_id}} = _interaction) do
    guild_id
    |> GuildCache.get!()
    |> Map.get(:voice_states)
    |> Enum.find(%{}, fn v -> v.user_id == user_id end)
    |> Map.get(:channel_id)
  end
end

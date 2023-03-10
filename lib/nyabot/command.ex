defmodule Nyabot.Command do
  alias Nostrum.Struct.Interaction

  @callback spec(name :: String.t()) :: map()

  @callback handle_interaction(Interaction.t()) :: any()

  @spec get_option(Interaction.t(), String.t()) :: Nostrum.Struct.ApplicationCommandInteractionData.options() | nil

  def get_option(interaction, name),
    do: Enum.find(interaction.data.options || [], fn %{name: n} -> n == name end)
end

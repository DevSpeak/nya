defmodule Nyabot.Commands do
  @commands %{
    "greet" => Nyabot.Commands.Greet,
    "play" => Nyabot.Commands.Play,
    "summon" => Nyabot.Commands.Summon,
    "stop" => Nyabot.Commands.Stop
  }

  @command_names for {name, _} <- @commands, do: name

  def register_commands() do
    commands = for {name, command} <- @commands, do: command.spec(name)

    Nostrum.Api.bulk_overwrite_global_application_commands(commands)
  end

  def handle_interaction(interaction) do
    if interaction.data.name in @command_names do
      @commands[interaction.data.name].handle_interaction(interaction)
    else
      :ok
    end
  end
end

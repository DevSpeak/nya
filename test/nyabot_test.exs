defmodule NyabotTest do
  use ExUnit.Case
  doctest Nyabot

  test "greets the world" do
    assert Nyabot.hello() == :world
  end
end

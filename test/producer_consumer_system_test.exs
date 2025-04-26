defmodule ProducerConsumerSystemTest do
  use ExUnit.Case
  doctest ProducerConsumerSystem

  test "greets the world" do
    assert ProducerConsumerSystem.hello() == :world
  end
end

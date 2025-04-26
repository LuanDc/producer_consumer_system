defmodule ProducerConsumerSystem.Application do
  # See https://hexdocs.pm/elixir/Application.html
  # for more information on OTP Applications
  @moduledoc false

  use Application

  @impl true
  def start(_type, _args) do
    children = [
      ProducerConsumerSystem.Cache,
      {DynamicSupervisor, name: ProducerConsumerSystem.DynamicSupervisor, strategy: :one_for_one},
      {Registry, keys: :unique, name: ProducerConsumerSystem.ConsumerRegistry}
    ]

    # See https://hexdocs.pm/elixir/Supervisor.html
    # for other strategies and supported options
    opts = [strategy: :one_for_one, name: ProducerConsumerSystem.Supervisor]
    Supervisor.start_link(children, opts)
  end

  @doc """
  Starts a consumer process with a unique identifier.

  ## Parameters
  - `consumer_name`: A unique identifier for the consumer.

  ## Example
  {:ok, consumer_pid} = ProducerConsumerSystem.start_consumer(:consumer1)
  """
  def start_consumer(consumer_name) do
    DynamicSupervisor.start_child(
      ProducerConsumerSystem.DynamicSupervisor,
      {ProducerConsumerSystem.Consumer, name: consumer_name}
    )
  end

  @doc """
  Sends a message to a specified consumer.

  ## Parameters
  - `consumer_pid`: The PID of the consumer process.
  - `message`: The message to be sent.

  ## Example
  :ok = ProducerConsumerSystem.send_message(consumer_pid, "Hello, world!")
  """
  def send_message(consumer_pid, message) do
    GenServer.cast(consumer_pid, {:process_message, message})
  end

  def get_state(consumer_pid) do
    GenServer.call(consumer_pid, :get_state)
  end
end

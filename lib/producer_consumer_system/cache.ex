defmodule ProducerConsumerSystem.ConsumerMessagesCache do
  use GenServer

  @ets_table :consumer_messages

  def start_link(opts) do
    GenServer.start_link(__MODULE__, opts, name: __MODULE__)
  end

  def insert(consumer_name, message) do
    GenServer.cast(__MODULE__, {:insert, consumer_name, message})
  end

  def lookup(consumer_name) do
    :ets.lookup(@ets_table, consumer_name)
  end

  def init(_opts) do
    :ets.new(@ets_table, [:set, :protected, :named_table, {:read_concurrency, true}])
    {:ok, %{}}
  end

  def handle_cast({:insert, consumer_name, message}, state) do
    :ets.insert(@ets_table, {consumer_name, message})
    {:noreply, state}
  end
end

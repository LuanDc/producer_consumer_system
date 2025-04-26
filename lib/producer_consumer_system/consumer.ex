defmodule ProducerConsumerSystem.Consumer do
  use GenServer

  alias ProducerConsumerSystem.ConsumerMessagesCache

  # Starts the GenServer process for a consumer
  def start_link(opts) do
    GenServer.start_link(__MODULE__, opts,
      name: {:via, Registry, {ProducerConsumerSystem.ConsumerRegistry, Keyword.get(opts, :name)}}
    )
  end

  # Consumer's initialization function
  def init(opts) do
    consumer_name = Keyword.get(opts, :name)

    messages =
      case ConsumerMessagesCache.lookup(consumer_name) do
        [{^consumer_name, messages}] -> messages
        [] -> []
      end

    {:ok, %{name: consumer_name, messages: messages}}
  end

  # Handling incoming messages
  def handle_cast({:process_message, message}, state) do
    messages = [message | state.messages]
    ConsumerMessagesCache.insert(state.name, messages)
    {:noreply, %{state | messages: messages}}
  end

  # Function to retrieve the current state of messages
  def handle_call(:get_state, _from, state) do
    {:reply, state.messages, state}
  end
end

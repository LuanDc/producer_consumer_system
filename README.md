
# Producer-Consumer System in Elixir/OTP

This project is a demonstration of a producer-consumer system implemented in Elixir using OTP principles. It showcases my skills in building concurrent, fault-tolerant, and scalable applications with Elixir and OTP. The project is designed as a portfolio piece to highlight my proficiency in Elixir's concurrency model, GenServer, DynamicSupervisor, and ETS for in-memory storage.

## Overview

The Producer-Consumer System allows for the dynamic creation of consumer processes that can receive and process messages. Each consumer maintains its own message history, which is cached using an ETS table for persistence across process restarts. The system leverages OTP behaviors like `GenServer`, `DynamicSupervisor`, and `Registry` to manage concurrency and process supervision.

### Key Features
- **Dynamic Consumer Creation**: Consumers can be started dynamically with unique names using a `DynamicSupervisor`.
- **Message Processing**: Consumers receive messages asynchronously via `GenServer.cast/2` and store them in memory.
- **ETS-based Caching**: An ETS table caches messages for each consumer, ensuring message persistence if a consumer process restarts.
- **Process Supervision**: The system uses OTP's supervision tree to ensure fault tolerance.
- **State Inspection**: Consumers expose their current message state via `GenServer.call/2`.

## Project Structure

- **`application.ex`**: Defines the application entry point and supervision tree. It includes functions to start consumers and send messages.
- **`consumer.ex`**: Implements the `GenServer`-based consumer process, handling message processing and state management.
- **`cache.ex`**: Manages an ETS table for caching consumer messages, implemented as a `GenServer`.

## Getting Started

### Prerequisites
- Elixir 1.12 or higher
- Erlang/OTP 24 or higher

### Installation
1. Clone the repository:
   ```bash
   git clone https://github.com/your-username/producer-consumer-system.git
   cd producer-consumer-system
   ```
2. Install dependencies:
   ```bash
   mix deps.get
   ```
3. Start the application:
   ```bash
   iex -S mix
   ```

### Usage
1. Start a consumer:
   ```elixir
   {:ok, pid} = ProducerConsumerSystem.start_consumer(:consumer1)
   ```
2. Send a message to the consumer:
   ```elixir
   ProducerConsumerSystem.send_message(pid, "Hello, world!")
   ```
3. Retrieve the consumer's message state:
   ```elixir
   ProducerConsumerSystem.get_state(pid)
   # => ["Hello, world!"]
   ```

## OTP Concepts Demonstrated
- **GenServer**: Used for consumer processes and the ETS cache to handle concurrent message processing and state management.
- **DynamicSupervisor**: Manages dynamic consumer processes, allowing for runtime creation and supervision.
- **Registry**: Provides a unique naming mechanism for consumer processes.
- **ETS**: Implements an in-memory cache for message persistence.
- **Supervision Tree**: Ensures fault tolerance by restarting failed processes.

## Why Elixir/OTP?
This project leverages Elixir's actor-based concurrency model and OTP's robust supervision strategies to build a reliable and scalable system. The use of ETS for caching demonstrates efficient in-memory storage, while `DynamicSupervisor` and `Registry` showcase dynamic process management.

## Contributing
This is a portfolio project, but feedback and suggestions are welcome! Feel free to open an issue or submit a pull request.

## Contact
For questions or inquiries, reach out via [your-email@example.com] or [your GitHub profile](https://github.com/LuanDc).


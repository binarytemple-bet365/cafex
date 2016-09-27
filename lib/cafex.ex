defmodule Cafex do

  @type server :: {host :: String.t, port :: 0..65535}
  @type broker :: server
  @type client_id :: String.t

  def start_topic(name, brokers, opts \\ []) do
    Cafex.Supervisor.start_topic(name, brokers, opts)
  end

  @doc """
  Start a producer.

  Read `Cafex.Producer` for more details.
  """
  @spec start_producer(producer :: atom,
                       opts :: Cafex.Producer.options) :: {:ok, producer :: atom} |
                                                          {:error, reason :: term}
  def start_producer(producer, opts \\ []) do
    Cafex.Supervisor.start_producer(producer, opts)
  end
  defdelegate stop_producer(sup), to: Cafex.Supervisor

  @doc """
  Produce message to kafka server in the synchronous way.

  See `Cafex.Producer.produce/3`
  """
  def produce(producer, value, opts \\ []) do
    Cafex.Producer.produce(producer, value, opts)
  end

  @doc """
  Produce message to kafka server in the asynchronous way.

  See `Cafex.Producer.produce/3`
  """
  def async_produce(producer, value, opts \\ []) do
    Cafex.Producer.async_produce(producer, value, opts)
  end

  def fetch(topic_pid, partition, offset) when is_integer(partition)
                                           and is_integer(offset) do
    Cafex.Topic.Server.fetch topic_pid, partition, offset
  end

  @doc """
  Start a consumer.

  Read `Cafex.Consumer.Manager` for more details.
  """
  @spec start_consumer(name :: atom, Cafex.Consumer.Manager.options) :: Supervisor.on_start_child
  def start_consumer(name, opts \\ []) do
    Cafex.Supervisor.start_consumer(name, opts)
  end
  defdelegate stop_consumer(name), to: Cafex.Supervisor
end

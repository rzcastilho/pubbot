defmodule Pubbot do
  @moduledoc false

  def publish(conn, exchange, routing_key, options, template, assigns \\ []) do
    {:ok, connection} = AMQP.Connection.open(conn)
    {:ok, channel} = AMQP.Channel.open(connection)
    AMQP.Basic.publish(channel, exchange, routing_key, EEx.eval_file(template, assigns: assigns), options)
    AMQP.Connection.close(connection)
  end

end

# Pubbot

Schedule events to be published to RabbitMQ based on Elixir templates. 

### Example Configuration

```elixir
config :pubbot, Pubbot.Scheduler,
  jobs: [
    {
      # Cron expression - Every minute
      "* * * * *",
      {
        Pubbot,
        :publish,
        [
          # RabbitMQ Connection
          [username: "guest", password: "guest", virtual_host: "/", host: "localhost", port: 5672],
          # Exchange
          "amqp.notificacao",
          # Routing Key
          "",
          # Options
          [content_type: "application/json"],
          # Template file
          "templates/some_event.eex"
        ]
      }
    },
    {
      # Cron expression - Every 5 minutes
      "*/5 * * * *",
      {
        Pubbot,
        :publish,
        [
          # RabbitMQ Connection
          [username: "guest", password: "guest", virtual_host: "/", host: "localhost", port: 5672],
          # Exchange (Default Exchange)
          "",
          # Routing Key
          "source.ofertas.colaborar.campus",
          # Options
          [content_type: "application/json"],
          # Template file
          "templates/hello.eex",
          # Variables
          [name: "Pubbot"]
        ]
      }
    }
  ]
```

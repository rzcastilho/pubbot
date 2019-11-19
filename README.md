# Pubbot

Schedule events to be published to RabbitMQ based on Elixir templates. 

### Example Configuration

To use Pubbot, you must configure jobs in `releases.exs` file like below.

To see details, look at the [quantum-elixir](https://github.com/quantum-elixir/quantum-core) project.

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
          "event.exchange",
          # Routing Key
          "",
          # Options
          [content_type: "application/json"],
          # Template file
          "/app/templates/event.eex"
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
          "hello.queue",
          # Options
          [content_type: "application/json"],
          # Template file
          "/app/templates/hello.eex",
          # Variables
          [name: "Pubbot"]
        ]
      }
    }
  ]
```

### Starting Example Configuration

To start Pubbot with the example configuration, run the `docker-compose.bash` script that starts the application and prepares RabbitMQ with needed example resources.

```bash
$ ./docker-compose.bash
Creating network "pubbot_default" with the default driver
Creating pubbot_rabbitmq_1 ... done
Creating pubbot_pubbot_1   ... done
Checking RabbitMQ health status...
Checking RabbitMQ health status...
Checking RabbitMQ health status...
Checking RabbitMQ health status...
Creating RabbitMQ resources...
queue declared
exchange declared
queue declared
binding declared
Pubbot log...
13:21:11.141 [info] Application logger started on node pubbot@9c671d4da57d
13:21:11.141 [info] Application crontab started on node pubbot@9c671d4da57d
13:21:11.141 [info] Application gen_stage started on node pubbot@9c671d4da57d
13:21:11.142 [info] Application gen_state_machine started on node pubbot@9c671d4da57d
13:21:11.142 [info] Application libring started on node pubbot@9c671d4da57d

13:21:11.142 [info]  [swarm on pubbot@9c671d4da57d] [tracker:init] started
13:21:11.142 [info] Application swarm started on node pubbot@9c671d4da57d
13:21:11.152 [info] Application quantum started on node pubbot@9c671d4da57d
13:21:11.152 [info] Application combine started on node pubbot@9c671d4da57d
13:21:11.153 [info] Application gettext started on node pubbot@9c671d4da57d
13:21:11.271 [info] Application tzdata started on node pubbot@9c671d4da57d
13:21:11.271 [info] Application timex started on node pubbot@9c671d4da57d
13:21:11.271 [info] Application uuid started on node pubbot@9c671d4da57d
13:21:11.273 [info] Application pubbot started on node pubbot@9c671d4da57d

13:21:14.972 [info]  tzdata release in place is from a file last modified Tue, 26 Mar 2019 05:40:14 GMT. Release file on server was last modified Wed, 11 Sep 2019 19:35:17 GMT.

13:21:16.109 [info]  [swarm on pubbot@9c671d4da57d] [tracker:cluster_wait] joining cluster..

13:21:16.109 [info]  [swarm on pubbot@9c671d4da57d] [tracker:cluster_wait] no connected nodes, proceeding without sync

13:21:19.549 [info]  Tzdata has updated the release from 2019a to 2019c
```

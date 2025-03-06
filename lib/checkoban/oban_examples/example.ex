defmodule Checkoban.Workers.ExampleWorker do
  # this oban worker listens to the queue called default
  use Oban.Worker, queue: :default, max_attempts: 3

  # * the perform/1 callback defines the logic of the particular job
  @impl Oban.Worker
  def perform(%Oban.Job{args: %{"id" => id}}) do
    # Your job logic here
    IO.puts("Processing job with ID #{id}")
    :ok
  end
end

# Now you are going to call this from somewhere in the code or in iex
# new/1: Creates a new job with the given arguments.
# in the app Skeptic this is handled in the enqueue/1 function
# * MyApp.Workers.ExampleWorker.new(schedule_in: 60) # Schedules the job to run after 60 seconds
# * Checkoban.Workers.ExampleWorker.new(%{"id" => 123}) |> Oban.insert()

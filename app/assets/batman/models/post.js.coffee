class Illusion.Post extends Batman.Model
  @resourceName: 'posts'
  @storageKey: 'posts'

  @persist Batman.RailsStorage

  # Use @encode to tell batman.js which properties Rails will send back with its JSON.
  # @encode 'name'
  @encodeTimestamps()


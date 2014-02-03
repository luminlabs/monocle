$       = jQuery
Overlay = require('app/controllers/overlay')

class Alert extends Overlay
  className: 'alert'

  constructor: (options = {}) ->
    super()
    @on('click', '#dismiss', @close)
    console.log(options.title)
    @title = options.title
    @message = options.message

    @render()
    @open()

  render: =>
    @html(@view('alert')(this))
    @$('[data-name=title]').html(@title)
    @$('[data-name=message]').html(@message)

module.exports = Alert
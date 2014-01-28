$       = jQuery
Overlay = require('app/controllers/overlay')
User    = require('app/models/user')
State   = require('app/state')
SignUp  = require('app/controllers/users/sign_up')
SignIn  = require('app/controllers/users/sign_in')

class Authorize extends Overlay
  className: 'users-authorize'

  constructor: (@callback) ->
    super()
    $(window).on('message', @message)
    # @on('click', 'a[href]', @click)
    @on('click', '#signUp', @signUp)
    @on('click', '#signIn', @signIn)
    @render()

  render: =>
    @html(@view('users/authorize')(this))

  click: (e) =>
    e.preventDefault()

    url    = $(e.currentTarget).attr('href')
    @frame = window.open(
      url, '_blank',
      'width=600,height=500,location=yes,resizable=yes,scrollbars=yes'
    )

  signUp: (e) =>
    e.preventDefault()

    @close()
    SignUp.open()

  signIn: (e) =>
    e.preventDefault()

    @close()
    SignIn.open()

  message: (e) =>
    e = e.originalEvent

    return if e?.source isnt @frame
    return unless e.data?.briskAuth
    @frame.close()
    @frame = null
    @close()

    user = new User(e.data.user)
    State.set(user: user)
    State.trigger('authorized', user)

    @callback?(user)
    @callback = null

  release: =>
    super
    $(window).off('message', @message)

module.exports = Authorize
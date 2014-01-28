$       = jQuery
Overlay = require('app/controllers/overlay')
User    = require('app/models/user')
State   = require('app/state')

class SignUp extends Overlay
  className: 'users-sign-up'

  constructor: (@callback) ->
    super()
    @on 'submit', @submit
    @render()

  render: =>
    @html(@view('users/sign_up')(this))
    @$form  = @$('form')
    @$errors  = @$('#errors')    
    @$email = @$('input#email')
    @$password = @$('input#password')

  clearErrors: =>
    @$errors.children("ul").html("")

  addErrors: (errors) =>
    @$errors.children("ul").html("")
    for error in errors
      @$errors.children("ul").append("<li>" + error + "</li>")

  clearValues: =>
    @$email.val("")
    @$password.val("")

  submit: (e) =>
    e.preventDefault()

    user = new User
    user.fromForm(@$form)
    response = user.sign_up()

    response.fail (jqXHR, textStatus, errorThrown) =>
      @clearValues()

      errors = JSON.parse(jqXHR.responseText)
      @$errors.show()
      @clearErrors()
      @addErrors(errors)

    response.done (data, textStatus, jqXHR) =>
      user = new User(data)
      State.set(user: user)
      @close()


module.exports = SignUp
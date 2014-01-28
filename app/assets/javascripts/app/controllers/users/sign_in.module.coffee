$       = jQuery
Overlay = require('app/controllers/overlay')
User    = require('app/models/user')
State   = require('app/state')
ForgotPassword = require('app/controllers/users/forgot_password')
SignUp = require('app/controllers/users/sign_up')


class SignIn extends Overlay
  className: 'users-sign-in'

  constructor: (@callback) ->
    super()
    @on 'submit', @submit
    @on 'click', '#forgotPassword', @forgotPassword
    @on 'click', '#signUp', @signUp
    @render()

  render: =>
    @html(@view('users/sign_in')(this))
    @$form  = @$('form')
    @$errors  = @$('#errors')    
    @$email = @$('input#email')
    @$password = @$('input#password')

  clearErrors: =>
    @$errors.children("ul").html("")

  forgotPassword: =>
    @close()
    ForgotPassword.open()

  signUp: =>
    @close()
    SignUp.open()

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
    response = user.sign_in()

    response.done (data, textStatus, jqXHR) =>
      user = new User(data)
      State.set(user: user)
      @close()

    response.fail (jqXHR, textStatus, errorThrown) =>
      @clearValues()
      errors = JSON.parse(jqXHR.responseText)
      @$errors.show()
      @clearErrors()
      @addErrors(errors)

module.exports = SignIn
$       = jQuery
Overlay = require('app/controllers/overlay')
User    = require('app/models/user')
State   = require('app/state')

class ForgotPassword extends Overlay
  className: 'users-forgot-password'

  constructor: (@callback) ->
    super()
    @on 'submit', @submit
    @render()

  render: =>
    @html(@view('users/forgot_password')(this))
    @$form  = @$('form')
    @$errors  = @$('#errors')    
    @$email = @$('input#email')

  clearErrors: =>
    @$errors.children("ul").html("")

  addErrors: (errors) =>
    @$errors.children("ul").html("")
    for error in errors
      @$errors.children("ul").append("<li>" + error + "</li>")

  clearValues: =>
    @$email.val("")

  submit: (e) =>
    e.preventDefault()

    user = new User
    user.fromForm(@$form)
    response = user.forgot_password()

    response.fail (jqXHR, textStatus, errorThrown) =>
      alert("password reset failed")
      @close()

    # Ideally this would present another overlay or maybe just replace the reset password box
    # with confirmation that their password was reset.  
    response.done (data, textStatus, jqXHR) =>
      alert("password reset instructions were sent to your email")
      @close()


module.exports = ForgotPassword
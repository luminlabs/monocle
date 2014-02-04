$       = jQuery
Overlay = require('app/controllers/overlay')
User    = require('app/models/user')
State   = require('app/state')
Alert = require('app/controllers/alert')

class ChangePassword extends Overlay
  className: 'users-change-password'

  constructor: (@user) ->
    super()
    @on 'submit', @submit
    @render()

  render: =>
    # @user = State.get('user')

    @html(@view('users/change_password')(this))
    @$form  = @$('form')
    @$errors  = @$('#errors')    

    @$current_password = @$('input#current_password')
    @$new_password = @$('input#new_password')
    @$confirm_new_password = @$('input#confirm_new_password')

  clearErrors: =>
    @$errors.children("ul").html("")

  addErrors: (errors) =>
    @$errors.children("ul").html("")
    for error in errors
      @$errors.children("ul").append("<li>" + error + "</li>")

  clearValues: =>
    @$current_password.val("")
    @$new_password.val("")
    @$confirm_new_password.val("")

  submit: (e) =>
    e.preventDefault()

    response = @user.change_password(@$current_password.val(), 
                                    @$new_password.val(), 
                                    @$confirm_new_password.val())
    

    response.done (data, textStatus, jqXHR) =>
      @close()
      new Alert( title: "Success!", message: data)

    response.fail (jqXHR, textStatus, errorThrown) =>
      @clearValues()
      errors = JSON.parse(jqXHR.responseText)
      @$errors.show()
      @clearErrors()
      @addErrors(errors)

module.exports = ChangePassword
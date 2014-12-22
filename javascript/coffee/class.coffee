class Concierge

  constructor: () ->
    @showLoginModal('.pleaseLogin')

  showLoginModal: (classSelector) ->
    console.log classSelector

new Concierge

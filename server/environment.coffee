
Meteor.startup () ->
  Meteor.methods
    filepickerio: () ->
      process.env.FILEPICKERIO


describe('Haves', function() {
  beforeEach(() => {
    cy.app('clean') // have a look at cypress/app_commands/clean.rb
  })

  describe('user', function() {
    beforeEach(() => {
      cy.appFactories([['create', 'auth_billy', { uid: 'billy@email.com' } ]])
      cy.visit('/auth/developer')
      cy.findField('Name').type('Billy')
      cy.findField('Email').type('billy@email.com')
      cy.findButton('Sign In').click()
      cy.contains('Welcome, Billy Bob')
    })

    it('should list haves', function() {
      cy.visit('/')

      cy.appFactories([
        ['create', 'have', { card_name: 'Card 1', user_uid: 'billy@email.com' }],
        ['create', 'have', { card_name: 'Card 2', user_uid: 'billy@email.com' }]
      ])
      cy.findLink('I Have').click()
      cy.contains('Card 1')
      cy.contains('Card 2')
    })
  })

})

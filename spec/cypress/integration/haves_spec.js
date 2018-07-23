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

      cy.visit('/')
    })

    it('should list haves', function() {
      cy.appFactories([
        ['create', 'have', { card_name: 'Card 1', user_uid: 'billy@email.com' }],
        ['create', 'have', { card_name: 'Card 2', user_uid: 'billy@email.com' }]
      ])
      cy.findLink('I Have').click()
      cy.contains('Card 1')
      cy.contains('Card 2')
    })

    it('can create haves', function() {
      cy.findLink('I Have').click()
      cy.findLink('Add Have').click()
      cy.findField('Card name').type('Test Card')
      cy.findButton('Create Have').click()
      cy.contains('Have was successfully created.')
      cy.contains('Test Card')
    })

    it('should prevent duplicates', function() {
      cy.appFactories([
        ['create', 'have', { card_name: 'My Card', user_uid: 'billy@email.com' }],
      ])

      cy.findLink('I Have').click()
      cy.findLink('Add Have').click()
      cy.findField('Card name').type('My Card')
      cy.findButton('Create Have').click()
      cy.contains('Card name is already taken')
    })

    it('should allow to edit', function() {
      cy.appFactories([
        ['create', 'have', { id: 1, card_name: 'Duplicate', user_uid: 'billy@email.com' }],
      ])

      cy.findLink('I Have').click()
      cy.findLink('edit_have_1').click()
      cy.findField('Card name').type('Duplicate 1')
      cy.findField('Amount').type('1')
      cy.findButton('Update Have').click()
      cy.contains('Have was successfully updated.')
      cy.contains('Duplicate 1')
    })

    it('cannot edit other users haves', function() {
      cy.appFactories([
        ['create', 'have', { id: 1, card_name: 'Duplicate' }],
      ])

      cy.visit("/haves/1/edit", {failOnStatusCode: false})
      cy.contains('Not allow to edit this')
    })

    it('should allow to delete', function() {
      cy.appFactories([
        ['create', 'have', { id: 1, card_name: 'Duplicate', user_uid: 'billy@email.com' }],
      ])

      cy.findLink('I Have').click()
      cy.findLink('delete_have_1').click()
      cy.contains('Successfully deleted.')
    })
  })
})

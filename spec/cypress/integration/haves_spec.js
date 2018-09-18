describe('Haves', function() {
  beforeEach(() => {
    cy.app('clean') // have a look at cypress/app_commands/clean.rb
  })

  beforeEach(() => {
    cy.login({name: 'Billy', email: 'billy@email.com'})
    cy.visit('/')
  })

  it('should list haves', function() {
    cy.appFactories([
      ['create', 'have', { name: 'Card 1', user_uid: 'billy@email.com' }],
      ['create', 'have', { name: 'Card 2', user_uid: 'billy@email.com' }]
    ])
    cy.findLink('I Have').click()
    cy.contains('Card 1')
    cy.contains('Card 2')
  })

  it('can create haves', function() {
    cy.findLink('I Have').click()
    cy.findLink('Add Have').click()
    cy.findField('Name').type('Test Card')
    cy.findButton('Create Have').click()
    cy.contains('Have was successfully created.')
    cy.contains('Test Card')
  })

  it('should prevent duplicates', function() {
    cy.appFactories([
      ['create', 'have', { name: 'My Card', user_uid: 'billy@email.com' }],
    ])

    cy.findLink('I Have').click()
    cy.findLink('Add Have').click()
    cy.findField('Name').type('My Card')
    cy.findButton('Create Have').click()
    cy.contains('name is already taken')
  })

  it('should allow to edit', function() {
    cy.appFactories([
      ['create', 'have', { name: 'Duplicate', user_uid: 'billy@email.com' }],
    ])

    cy.findLink('I Have').click()
    cy.get('[data-cy="Duplicate"]').contains('Edit').click()
    cy.findField('Name').clear()
    cy.findField('Name').type('Duplicate 1')
    cy.findField('Amount').type('1')
    cy.findButton('Update Have').click()
    cy.contains('Have was successfully updated.')
    cy.contains('Duplicate 1')
  })

  it('cannot edit other users haves', function() {
    cy.appFactories([
      ['create', 'have', { id: '00000000-0000-0000-0000-000000000001', name: 'Duplicate' }],
    ])

    cy.findLink('All Haves').click()
    cy.get('[data-cy="Duplicate"]').should('not.contain', 'Edit').click()

    cy.visit("/haves/00000000-0000-0000-0000-000000000001/edit", {failOnStatusCode: false})
    cy.contains('Not allow to edit this')
  })

  it('should allow to delete', function() {
    cy.appFactories([
      ['create', 'have', { name: 'Test123', user_uid: 'billy@email.com' }],
    ])

    cy.findLink('I Have').click()
    cy.get('[data-cy="Test123"]').contains('Delete').click()
    cy.contains('Successfully deleted.')
  })

  it('cannot delete other users haves', function() {
    cy.appFactories([
      ['create', 'have', { name: 'Pichu' }],
    ])

    cy.findLink('All Haves').click()
    cy.get('[data-cy="Pichu"]').should('contain', 'Make Offer')
    cy.get('[data-cy="Pichu"]').should('not.contain', 'Delete')
  })
})

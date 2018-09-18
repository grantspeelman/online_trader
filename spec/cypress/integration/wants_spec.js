describe('Wants', function() {
  beforeEach(() => {
    cy.app('clean')
  })

  beforeEach(() => {
    cy.login({name: 'Bobbie', email: 'bob@email.com'})
    cy.visit('/')
  })

  it('should list wants', function() {
    cy.appFactories([
      ['create', 'want', { name: 'Card 1', user_uid: 'bob@email.com' }],
      ['create', 'want', { name: 'Card 2', user_uid: 'bob@email.com' }]
    ])
    cy.findLink('My Wants').click()
    cy.contains('Card 1')
    cy.contains('Card 2')
  })

  it('can create wants', function() {
    cy.findLink('My Wants').click()
    cy.findLink('Add Want').click()
    cy.findField('Name').type('Test Card')
    cy.findButton('Create Want').click()
    cy.contains('Want was successfully created.')
    cy.contains('Test Card')
  })

  it('should prevent duplicates', function() {
    cy.appFactories([
      ['create', 'want', { name: 'My Card', user_uid: 'bob@email.com' }],
    ])

    cy.findLink('My Wants').click()
    cy.findLink('Add Want').click()
    cy.findField('Name').type('My Card')
    cy.findButton('Create Want').click()
    cy.contains('name and user_id is already taken')
  })

  it('should allow to edit', function() {
    cy.appFactories([
      ['create', 'want', { name: 'Duplicate', user_uid: 'bob@email.com' }],
    ])

    cy.findLink('My Wants').click()
    cy.get('[data-cy="Duplicate"]').contains('Edit').click()
    cy.findField('Name').clear()
    cy.findField('Name').type('Duplicate 1')
    cy.findField('Amount').type('1')
    cy.findButton('Update Want').click()
    cy.contains('Want was successfully updated.')
    cy.contains('Duplicate 1')
  })

  it('cannot edit other users wants', function() {
    cy.appFactories([
      ['create', 'want', { id: '00000000-0000-0000-0000-000000000001', name: 'Evee' }],
    ])

    cy.findLink('All Wants').click()
    cy.get('[data-cy="Evee"]').should('contain', 'Make Offer')
    cy.get('[data-cy="Evee"]').should('not.contain', 'Edit').click()

    cy.visit("/wants/00000000-0000-0000-0000-000000000001/edit", {failOnStatusCode: false})
    cy.contains('Not allow to edit this')
  })

  it('should allow to delete', function() {
    cy.appFactories([
      ['create', 'want', { name: 'Test123', user_uid: 'bob@email.com' }],
    ])

    cy.findLink('My Wants').click()
    cy.get('[data-cy="Test123"]').contains('Delete').click()
    cy.contains('Successfully deleted.')
  })

  it('cannot delete other users wants', function() {
    cy.appFactories([
      ['create', 'want', { name: 'Evee' }],
    ])

    cy.findLink('All Wants').click()
    cy.get('[data-cy="Evee"]').should('contain', 'Make Offer')
    cy.get('[data-cy="Evee"]').should('not.contain', 'Delete')
  })
})

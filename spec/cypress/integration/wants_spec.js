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
      ['create', 'want', { card_name: 'Card 1', user_uid: 'bob@email.com' }],
      ['create', 'want', { card_name: 'Card 2', user_uid: 'bob@email.com' }]
    ])
    cy.findLink('My Wants').click()
    cy.contains('Card 1')
    cy.contains('Card 2')
  })

  it('can create wants', function() {
    cy.findLink('My Wants').click()
    cy.findLink('Add Want').click()
    cy.findField('Card name').type('Test Card')
    cy.findButton('Create Want').click()
    cy.contains('Want was successfully created.')
    cy.contains('Test Card')
  })

  it('should prevent duplicates', function() {
    cy.appFactories([
      ['create', 'want', { card_name: 'My Card', user_uid: 'bob@email.com' }],
    ])

    cy.findLink('My Wants').click()
    cy.findLink('Add Want').click()
    cy.findField('Card name').type('My Card')
    cy.findButton('Create Want').click()
    cy.contains('Card name is already taken')
  })

  it('should allow to edit', function() {
    cy.appFactories([
      ['create', 'want', { id: 1, card_name: 'Duplicate', user_uid: 'bob@email.com' }],
    ])

    cy.findLink('My Wants').click()
    cy.findLink('edit_want_1').click()
    cy.findField('Card name').type('Duplicate 1')
    cy.findField('Amount').type('1')
    cy.findButton('Update Want').click()
    cy.contains('Want was successfully updated.')
    cy.contains('Duplicate 1')
  })

  it('cannot edit other users wants', function() {
    cy.appFactories([['create', 'auth_billy', { uid: 'billy@email.com' } ]])

    cy.appFactories([
      ['create', 'want', { id: 1, card_name: 'Duplicate', user_uid: 'billy@email.com'  }],
    ])

    cy.visit("/wants/1/edit", {failOnStatusCode: false})
    cy.contains('Not allow to edit this')
  })

  it('should allow to delete', function() {
    cy.appFactories([
      ['create', 'want', { id: 1, card_name: 'Duplicate', user_uid: 'bob@email.com' }],
    ])

    cy.findLink('My Wants').click()
    cy.findLink('delete_want_1').click()
    cy.contains('Successfully deleted.')
  })
})

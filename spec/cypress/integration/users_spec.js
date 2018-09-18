describe('Users', function() {
  beforeEach(() => {
    cy.app('clean')
    cy.login({name: 'Bobbie', email: 'bob@email.com'})
    cy.visit('/')
  })

  it('should list users', function() {
    cy.appFactories([
      ['create', 'user', { name: 'User 1' }],
      ['create', 'user', { name: 'User 2' }]
    ])
    cy.visit('/users')
    cy.contains('User 1')
    cy.contains('User 2')
  })

  it('cannot create users', function() {
    cy.visit("/users/new", {failOnStatusCode: false})
    cy.contains('No route matches')
  })

  it('should allow to edit own user', function() {
    cy.findLink('My Account').click()
    cy.findLink('edit_user').click()
    cy.findField('Name').type(' MJ')
    cy.findButton('Update User').click()
    cy.contains('User was successfully updated.')
    cy.contains('Bobbie MJ')
  })

  it('cannot edit other users', function() {
    cy.appFactories([
      ['create', 'user', { id: '88f1b921-8782-4815-b490-c6e36ba5a78a' }],
    ])

    cy.visit("/users/88f1b921-8782-4815-b490-c6e36ba5a78a/edit", {failOnStatusCode: false})
    cy.contains('Not allow to edit this')
  })
})

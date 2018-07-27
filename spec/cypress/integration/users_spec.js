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
    cy.contains('Not Found')
  })

  it('should allow to edit own user', function() {
    cy.findLink('My Account').click()
    cy.findLink('edit_user').click()
    cy.findField('Name').type(' MJ')
    cy.get('#user_time_zone').select('(GMT-11:00) American Samoa')
    cy.findButton('Update User').click()
    cy.contains('User was successfully updated.')
    cy.contains('Bobbie MJ')
    cy.contains('American Samoa')
  })

  it('cannot edit other users', function() {
    cy.appFactories([
      ['create', 'user', { id: 2 }],
    ])

    cy.visit("/users/2/edit", {failOnStatusCode: false})
    cy.contains('Not allow to edit this')
  })
})

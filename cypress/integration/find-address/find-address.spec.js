describe('Find Address by Zipcode', ()=> {

  it('Should return address by zipcode valid', () => {

    cy.visit('/')

    cy.get('#page_zip').type('64016700')

    cy.get('[type=submit]').click()

    cy.contains('Rua Doutor Area Leão, Nossa Senhora das Graças Teresina, PI')

  })

  it('Should return message error when zipcode invalid', () => {

    cy.visit('/')

    cy.get('#page_zip').type('0100')

    cy.get('[type=submit]').click()

    cy.contains('Não é válido')
  })

  it('Should return message error when zipcode not found', () => {

    cy.visit('/')

    cy.get('#page_zip').type('01000000')

    cy.get('[type=submit]').click()

    cy.contains('Cep não localizado')
  })
})
describe('Add to Cart', () => {
  beforeEach(() => {
    cy.visit('http://localhost:3000/') // Update the URL if needed
  })

  it('should increase the cart count when a product is added', () => {
    cy.get('.nav-item > .nav-link').invoke('text').as('initialCount')

    cy.get(':nth-child(1) > div > .button_to > .btn').click({ force: true })
    cy.get('@initialCount').then((initialCount) => {
      const initialCountValue = parseInt(initialCount)
      cy.get('.nav-item > .nav-link').should(($newCartCount) => {
        const newCount = parseInt($newCartCount.text().trim())
        expect(`My Cart ${newCount}`).to.equal( `My Cart ${initialCountValue + 1}`)
      })
    })
  })

  it('should have one item in the cart after navigating to the cart page', () => {
    cy.get(':nth-child(1) > div > .button_to > .btn').click({ force: true })

    cy.get('.end-0 > .nav-link').click()
   
    cy.get('.quantity').should('exist').and('have.text', ' 1 ' ) 
  })
})
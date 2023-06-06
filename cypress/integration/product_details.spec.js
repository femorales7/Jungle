describe('Product details', () => {
  beforeEach(() => {
    cy.visit('http://localhost:3000/') // Update the URL if needed
  })

  it('should navigate to the product detail page', () => {
    cy.get('.products article') // Select the product partial element, adjust the selector if needed
      .first() // Choose the first product, adjust if needed
      .find('a') // Find the link within the product partial
      .click() // Click the link to navigate to the product detail page

      cy.url().should('include', '/products/')
      cy.get('.product-detail').should('be.visible')
      cy.contains('Cliff Collard').should('exist')
      cy.contains('$79.99').should('exist')

  })
})

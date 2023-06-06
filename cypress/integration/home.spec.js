describe('Home page', () => {
  beforeEach(() => {
    cy.visit('http://localhost:3000/') // Update the URL if needed
  })

  it('should visit the home page', () => {
    cy.contains('Where you can find any plants!') // Replace with the expected content on your home page
  })
  it("There is products on the page", () => {
    cy.get(".products article").should("be.visible");
  });

  it("There is 12 products on the page", () => {
    cy.get(".products article").should("have.length", 12);
  });
})
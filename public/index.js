var productTemplate = document.querySelector('#product-card');
var productContainer = document.querySelector('.row');
console.log(productContainer);

for (var i = 0; i <= 10; i++) {
  productContainer.appendChild(productTemplate.content.cloneNode(true));
}

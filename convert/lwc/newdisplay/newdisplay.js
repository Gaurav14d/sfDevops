import { LightningElement, track } from 'lwc';

export default class CartScreen extends LightningElement {
    @track products = []; // Assuming this is your product data
    @track quantity = 0;

    // Convert products to datatable format
    get dataTableData() {
        return this.products.map(product => {
            return {
                id: product.id,
                image: `<img src="${product.image}" alt="${product.title}" />`,
                title: product.title,
                price: product.price,
                quantity: this.quantity,
                action: `<lightning-button label="Add to Cart" variant="brand" onclick={addToCart} data-id=${product.id}></lightning-button>`
            };
        });
    }

    // Columns definition for the datatable
    get columns() {
        return [
            { label: 'Image', fieldName: 'image', type: 'html' },
            { label: 'Title', fieldName: 'title', type: 'text' },
            { label: 'Price', fieldName: 'price', type: 'currency' },
            { label: 'Quantity', fieldName: 'quantity', type: 'number' },
            { label: 'Action', fieldName: 'action', type: 'html' }
        ];
    }

    // Handler for decrementing quantity
    decrementQuantity() {
        if (this.quantity > 0) {
            this.quantity--;
        }
    }

    // Handler for incrementing quantity
    incrementQuantity() {
        this.quantity++;
    }

    // Handler for adding product to cart
    addToCart(event) {
        const productId = event.target.dataset.id;
        // Add logic to add product to cart and update the database
    }

    // Handler for navigating to the cart page
    goToCart() {
        // Add logic to navigate to the cart page
    }
}
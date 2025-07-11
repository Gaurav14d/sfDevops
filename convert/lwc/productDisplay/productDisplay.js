import { LightningElement, track } from 'lwc';

export default class QuantityComponent extends LightningElement {
    @track products = [
        { id: '1', name: 'iPhone 15', price: 130000, quantity: 0, image: 'https://m.media-amazon.com/images/I/71nvkHnPpZL._AC_SR230,210_QL65_.jpg' },
        { id: '2', name: 'iPhone 14', price: 120000, quantity: 0, image: 'https://m.media-amazon.com/images/I/61bK6PMOC3L._AC_SR270,180_QL65_.jpg' },
        { id: '3', name: 'iPhone 13', price: 110000, quantity: 0, image: 'https://m.media-amazon.com/images/I/71xb2xkN5qL._AC_SR270,180_QL65_.jpg' },
        // Add more products as needed
    ];

    handleClick(event) {
        const productId = event.target.dataset.id;
        const action = event.target.dataset.action;

        const productIndex = this.products.findIndex(prod => prod.id === productId);
        if (productIndex !== -1) {
            if (action === 'Increase') {
                this.products[productIndex].quantity++;
            } else if (action === 'Decrease') {
                if (this.products[productIndex].quantity > 0) {
                    this.products[productIndex].quantity--;
                    this.product[productIndex].quantity--;
                }
            }
        }
    }

    handleCartClick() {
        // Add logic to handle adding products to cart
    }
}
import { LightningElement, wire } from 'lwc';
import getProducts from '@salesforce/apex/ProductController.getProducts';

export default class ProductDisplay extends LightningElement {
    products = [];
    quantity=0;
    addToCart=0;
    // Wire method to call getProducts Apex method and retrieve products from the server
    @wire(getProducts)
    wiredProducts({ error, data }) {
        if (data) { 
            // Assign the fetched products to the 'products' property
            this.products = data
        } else if (error) { 
            console.error('Error fetching products', error);
        }
    }

    // Method to increment the quantity of a product when the '+' button is clicked
    handleQuantityPlus() {
        this.quantity++;
        console.log("increase",quantity);
        }
    // Method to decrement the quantity of a product when the '-' button is clicked
    handleQuantityMinus(){
        this.quantity--;
        }
        addToCartButton(){
        this.addToCart++;
        }
}
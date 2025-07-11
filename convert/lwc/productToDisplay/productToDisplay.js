import { LightningElement, track , wire } from 'lwc';
import getProducts from '@salesforce/apex/ProductItemListController.getProducts';

export default class ProductToDisplay extends LightningElement {
 // Importing the Apex method
    // Trackable variables
    @track sgst = 0; // SGST
    @track cgst = 0; // CGST
    @track secondScreen = false; // Flag to show the second screen
    @track firstScreen = true; // Flag to show the first screen
    @track error; // Error message
    @track cartObj; // Object to hold items in the cart
    @track totalPayment = 0; // Total payment

    // Pagination variables
    @track products = []; // Array to hold products
    @track recordSize = 3; // Number of records per page
    @track pageNumber = 1; // Current page number
    @track productToDisplay = []; // Products to display on the current page
    @track totalRecords; // Total number of records
    @track totalPages; // Total number of pages
    @track addToCart = []; // Array to hold items added to the cart


    @wire(getProducts)
    wiredProducts({ error, data }) {
        if (data) {
            // If data is received
            this.products = data; // Set the products
            this.totalRecords = this.products.length; // Calculate total records
            this.totalPages = Math.ceil(this.totalRecords / this.recordSize); // Calculate total pages
            this.paginationHelper(); // Helper function to handle pagination
        } else if (error) {
            // If there's an error
            this.error = error; // Set the error message
        }
    }

    // Getters to disable Previous and Next buttons based on page number
    get handleDisablePrevious() {
        return this.pageNumber == 1;
    }

    get handleDisableNext() {
        return this.pageNumber == this.totalPages;
    }

    // Helper function to populate products on the current page
    paginationHelper() {
        this.productToDisplay = [];
        const start = ((this.pageNumber - 1) * this.recordSize);
        const end = start + this.recordSize;
        for (let i = start; i < end; i++) {
            this.productToDisplay.push(this.products[i]);
        }
    }

    // Handle click events
    handleClick(event) {
        if (event.target.title == 'Previous') {
            // Previous button clicked
            this.pageNumber = this.pageNumber - 1;
            this.paginationHelper(); // Update products for the new page
        }

        if (event.target.title == 'Next') {
            // Next button clicked
            this.pageNumber = this.pageNumber + 1;
            this.paginationHelper(); // Update products for the new page
        }

        if (event.target.title == 'Remove') {
            // Remove button clicked
            const productId = event.target.dataset.id;
            // Decrease quantity of the product
            this.productToDisplay = this.productToDisplay.map(product => {
                if (product.Id === productId && product.quantity > 0) {
                    return { ...product, quantity: product.quantity - 1, quantity2: product.quantity2 - 1, finalPrice: ((product.quantity - 1) * product.Price__c) };
                }
                return product;
            });
        }

        if (event.target.title == 'Add') {
            // Add button clicked
            const productId = event.target.dataset.id;
            // Increase quantity of the product
            this.productToDisplay = this.productToDisplay.map(product => {
                if (product.Id === productId) {
                    return { ...product, quantity: (product.quantity + 1), quantity2: product.quantity2 + 1, finalPrice: (product.price * (product.quantity + 1)) };
                }
                return product;
            });
        }

        if (event.target.title == 'AddToCart' && event.target.value > 0) {
            // Add to cart button clicked
            const productId = event.target.dataset.id;
            // Create cart object for the product
            this.cartObj = this.productToDisplay.map(product => {
                if (product.Id === productId) {
                    return { ...product, finalPrice: (product.price * (product.quantity2)), sgst: (product.price * 0.28), cgst: (product.price * 0.28) };
                }
                return null;
            });
            // Add product to the cart
            this.cartObj.forEach(element => {
                if (element != null) {
                    this.addToCart.push(element);
                }
            });
            // Reset quantity of the product to 0
            this.productToDisplay = this.productToDisplay.map(product => {
                if (product.Id === productId) {
                    return { ...product, quantity: 0 };
                }
                return product;
            });
            // Show success message
            const eventToast = new ShowToastEvent({
                title: event.target.name + ' Added !!',
                message: 'Product added to cart successfully!',
                variant: 'success',
                mode: 'dismissable'
            });
            this.dispatchEvent(eventToast);
        }

        if (event.target.title == 'cart') {
            // Cart button clicked
            this.secondScreen = true; // Show second screen
            this.firstScreen = false; // Hide first screen
        }
    }
}
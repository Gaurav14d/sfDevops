import { LightningElement, track, wire } from 'lwc';
import getProducts from '@salesforce/apex/ProductItemListController.getProducts';
import { ShowToastEvent } from "lightning/platformShowToastEvent";


export default class MyNewShoppingCart extends LightningElement {
// Trackable variables for various functionalities
@track sgst = 0;
@track cgst = 0;
@track secondScreen = false;
@track firstScreen = true;
@track error;
@track cartObj; 
@track totalPayment = 0;
@track products = []; 
@track recordSize = 3; 
@track pageNumber = 1;
@track productToDisplay = []; 
@track totalRecords;
@track totalPages; 
@track addToCart = []; 

// Apex method to fetch product data
@wire(getProducts)
wiredProducts({ error, data }) {
if (data) {
    this.products = data; 
    this.totalRecords = this.products.length;
    this.totalPages = Math.ceil(this.totalRecords / this.recordSize);
    this.paginationHelper();
} else if (error) {
    // Handle error
    this.error = error;
}
}

// Getter to disable Previous button based on page number
get handleDisablePrevious() { 
return this.pageNumber == 1;
}

// Getter to disable Next button based on page number and total pages
get handleDisableNext() {
return this.pageNumber == this.totalPages;
}

// Helper method for pagination
paginationHelper() {
this.productToDisplay = [];
const start = ((this.pageNumber - 1) * this.recordSize);
const end = start + this.recordSize;
for (let i = start; i < end; i++) {
    this.productToDisplay.push(this.products[i]);
}
}

// Handle click events for various actions
handleClick(event){
// Handle click on Previous button
if(event.target.title == 'Previous'){
    this.pageNumber = this.pageNumber - 1;
    this.paginationHelper();
}
// Handle click on Next button
if(event.target.title == 'Next'){
    this.pageNumber = this.pageNumber + 1;
    this.paginationHelper();
}
// Handle click on Remove button
if(event.target.title == 'Remove'){
    const productId = event.target.dataset.id;
    this.productToDisplay = this.productToDisplay.map(product=>{
        if(product.Id === productId && product.quantity>0){
            return{ ...product, quantity: product.quantity - 1, quantity2: product.quantity2 - 1, finalPrice: ((product.quantity - 1) * product.Price__c)}
        }
        return product;
    });
}
// Handle click on Add button
if(event.target.title == 'Add'){
    const productId = event.target.dataset.id; // use variables don't like API Name.
    this.productToDisplay = this.productToDisplay.map(product =>{
        if(product.Id === productId){
            return{ ...product, quantity: (product.quantity + 1), quantity2: product.quantity2 + 1, finalPrice: (product.price * (product.quantity + 1))};
        }
        return product;
    });
}
// Handle click on AddToCart button
if(event.target.title == 'AddToCart' && event.target.value > 0){
    const productId = event.target.dataset.id;
    this.cartObj = this.productToDisplay.map(product =>{
        if(product.Id === productId){
            return{ ...product, finalPrice: (product.price *(product.quantity2)), sgst: (product.price * 0.28), cgst: (product.price * 0.28)};
        }
        return null;     
    });
    this.cartObj.forEach(element => {
        if(element != null){
            this.addToCart.push(element);
        }
    });
    this.productToDisplay = this.productToDisplay.map(product =>{
        if(product.Id === productId){
            return{ ...product, quantity: 0};
        }
        return product;
    });
    // Dispatch event to show success toast
    const eventToast = new ShowToastEvent({   // import the Showtoast event.
        title: event.target.name+' Added !!',
        message: 'Product added to cart successfully!',
        variant: 'success',
        mode: 'dismissable'
    });
    this.dispatchEvent(eventToast);
}
// Handle click on Cart button
if(event.target.title == 'cart'){
    this.secondScreen = true;
    this.firstScreen = false;
}
}
}
import { LightningElement, api, track } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import createPaymentIntent from '@salesforce/apex/stripeService.createCharge';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

const columns = [
    { label: 'Product Name', fieldName: 'name' },
    { label: 'Quantity', fieldName: 'quantity2', type: 'number' },
    { label: 'Price Per Item', fieldName: 'price', type: 'currency' },
    { label: 'Final Price', fieldName: 'finalPrice', type: 'currency' },
    {
        type: 'button',
        typeAttributes: {
            label: 'Remove',
            name: 'Remove',
            disabled: false,
            value: 'remove',
            iconPosition: 'center',
            variant: 'Outline'
        }
    }
];

export default class NewCheckoutPage extends NavigationMixin(LightningElement) {
    columns = columns;
    @track showDataTable = true;
    @track showCheckOut = false;
    @track cartList = []; // Initialize cartList as empty array
    sgst = 0;
    cgst = 0;
    totalPayment = 0;

    connectedCallback() {
        // Mock data initialization
        this.cartList = [
            { Id: '1', name: 'Product 1', quantity2: 2, price: 50, finalPrice: 100 },
            { Id: '2', name: 'Product 2', quantity2: 1, price: 30, finalPrice: 30 }
        ];
        this.finalBill();
    }

    // Method to calculate final bill
    finalBill() {
        this.sgst = 0;
        this.cgst = 0;
        this.totalPayment = 0;
        this.cartList.forEach(element => {
            this.sgst += element.price * 0.05 * element.quantity2;
            this.cgst += element.price * 0.05 * element.quantity2;
            this.totalPayment += element.finalPrice + (element.price * 0.05) * element.quantity2 * 2;
        });
    }

    // Method to handle row actions
    callRowAction(event) {
        const rowId = event.detail.row.Id;
        const actionName = event.detail.action.name;

        if (actionName === 'Remove' && event.detail.row.quantity2 > 1) {
            this.cartList = this.cartList.map(product => {
                if (product.Id === rowId) {
                    return { ...product, quantity2: product.quantity2 - 1, finalPrice: product.finalPrice - product.price };
                }
                return product;
            });
            this.finalBill();
        }

        if (actionName === 'Remove' && event.detail.row.quantity2 === 1) {
            this.cartList = this.cartList.filter(element => element.Id !== rowId);
            this.finalBill();
        }
    }

    // Method to handle checkout
    handleCheckout() {
        this[NavigationMixin.Navigate]({
            type: 'standard__webPage',
            attributes: {
                url: 'https://buy.stripe.com/test_6oEg0c38o9qD8FOaEE'
            }
        });
    }

    // Method to handle form submission
    handleSubmit() {
        createPaymentIntent({ amount: this.totalPayment })
            .then(result => {
                console.log('Payment Status:', result);
                if (result === 'success') {
                    this.dispatchEvent(
                        new ShowToastEvent({
                            title: 'Success',
                            message: 'Payment successful',
                            variant: 'success'
                        })
                    );
                }
            })
            .catch(error => {
                console.error('Error:', error);
                this.dispatchEvent(
                    new ShowToastEvent({
                        title: 'Error',
                        message: 'Error in processing payment',
                        variant: 'error'
                    })
                );
            });
    }

    // Method to handle event
    handleEvent() {
        this.showDataTable = false;
        this.showCheckOut = true;
    }
}
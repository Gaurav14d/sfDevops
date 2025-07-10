import { LightningElement, api, track } from 'lwc';

const columns = [
    { label: 'Product Name', fieldName: 'name' },
    { label: 'Quantity', fieldName: 'quantity', type: 'number' },
    { label: 'Price Per Item', fieldName: 'price', type: 'currency' },
    { label: 'Final Price', fieldName: 'finalPrice', type: 'currency' },
    {
        type: "button", typeAttributes: {
            label: 'Delete',
            name: 'Delete',
            disabled: false,
            value: 'delete',
            iconPosition: 'center',
            variant: 'outline'
        }
    },
];

export default class ProductListScreen2 extends LightningElement {
    columns = columns;
    @api cartList;
    @track totalPayment = 0;
    @track sgst = 0;
    @track cgst = 0;
    @track Price;
   /* isModalOpen = false;

    openModal() {
        this.isModalOpen = true;
    }

    closeModal() {
        this.isModalOpen = false;
    }

    savePaymentMethod() {
        // Logic to save payment method
        // You can implement your save logic here
        this.closeModal();
    }*/

    callRowAction(event) {
        const rowId = event.detail.row.Id;
        const actionName = event.detail.action.name;

        if (actionName === 'Delete' && event.detail.row.quantity2 > 1) {
            this.cartList = this.cartList.map(product => {
                if (product.Id === rowId) {
                    const newQuantity = product.quantity2 - 1;
                    const finalPrice = product.Price__c * newQuantity;
                    return { ...product, quantity2: newQuantity, finalPrice: finalPrice };
                }
                return product;
            });

            this.calculateTotalPayment();
        }

        if (actionName === 'Delete' && event.detail.row.quantity2 == 1) {
            this.cartList = this.cartList.filter(product => product.Id !== rowId);
            this.calculateTotalPayment();
        }
    }

    calculateTotalPayment() {
        let totalFinalPrice = 0;
        this.cartList.forEach(product => {
            totalFinalPrice += product.finalPrice;
        });
        this.sgst = totalFinalPrice * 0.09; // Assuming SGST is 9% of the total
        this.cgst = totalFinalPrice * 0.09; // Assuming CGST is 9% of the total
        this.totalPayment = totalFinalPrice + this.sgst + this.cgst;
    }
}
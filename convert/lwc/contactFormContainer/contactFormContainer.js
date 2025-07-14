// contactFormContainer.js
import { LightningElement, track } from 'lwc';

export default class ContactFormContainer extends LightningElement {
    @track createContactForm = [];
    nextKey = 0;

    addcreateContactForm() {
        this.createContactForm.push({ key: this.nextKey });
        this.nextKey++;
    }
}
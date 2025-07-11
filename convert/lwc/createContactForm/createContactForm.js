import { LightningElement, track, wire } from 'lwc';
    import { ShowToastEvent } from 'lightning/platformShowToastEvent';
    import getContacts from '@salesforce/apex/contactcontroller.getContacts';
    import saveContacts from '@salesforce/apex/contactcontroller.saveContacts';

    export default class CreateContactForm extends LightningElement {
        @track contactList = [];

        connectedCallback() {
          
            this.contactList.push({
                FirstName: '',
                LastName: '',
                Phone: '',
                index: 1,
                showDeleteButton: false 
            });
        }

        addRow() {
            let newIndex = this.contactList.length + 1;
            this.contactList.push({
                FirstName: '',
                LastName: '',
                Phone: '',
                index: newIndex,
                showDeleteButton: true 
            });
        }

        removeRow(event) {
            let index = event.target.dataset.index;
            this.contactList.splice(index, 1);
            this.contactList.forEach((contact, idx) => {
                contact.index = idx + 1;
            });
        }

        handleFirstNameChange(event) {
            let index = event.target.dataset.index;
            this.contactList[index].FirstName = event.target.value;
        }

        handleLastNameChange(event) {
            let index = event.target.dataset.index;
            this.contactList[index].LastName = event.target.value;
        }

        handlePhoneChange(event) {
            let index = event.target.dataset.index;
            this.contactList[index].Phone = event.target.value;
        }

        saveRecords() {
            saveContacts({ conList: this.contactList })
                .then(() => {
                    this.showToast('Success', 'Contacts saved successfully', 'success');
                    this.contactList = [];
                })
                .catch(error => {
                    this.showToast('Error', 'Error saving contacts', 'error');
                    console.error('Error saving contacts:', error);
                });
        }

        showToast(title, message, variant) {
            const event = new ShowToastEvent({
                title: title,
                message: message,
                variant: variant
            });
            this.dispatchEvent(event);
        }
    }
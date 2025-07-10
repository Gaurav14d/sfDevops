import { LightningElement, track } from 'lwc';

export default class DemoScreen4 extends LightningElement {
    @track senderName = '';
    @track requestedBy = '';
    @track newSender = '';
    
    @track transactions = [
        {
            id: '1',
            dateOfRequest: '1/1/1 1:1:1',
            dateOfApproval: '1/1/1 1:1:1',
            whoRequested: 'XXX',
            whoApproved: 'abcd',
            whitelistedName: 'AAA',
            status: 'Active',
            disabledOn: '1/1/1 1:1:1',
            disabledBy: 'AAA',
        },
        {
            id: '2',
            dateOfRequest: '2/2/2 2:2:2',
            dateOfApproval: '2/2/2 2:2:2',
            whoRequested: 'YYY',
            whoApproved: 'efgh',
            whitelistedName: 'BBB',
            status: 'Disabled',
            disabledOn: '2/2/2 2:2:2',
            disabledBy: 'BBB',
        },
        {
            id: '3',
            dateOfRequest: '3/3/3 3:3:3',
            dateOfApproval: '3/3/3 3:3:3',
            whoRequested: 'ZZZ',
            whoApproved: 'ijkl',
            whitelistedName: 'CCC',
            status: 'Pending',
            disabledOn: '3/3/3 3:3:3',
            disabledBy: 'CCC',
        },
    ];

    handleInputChange(event) {
        const field = event.target.label; // Get the label of the input field
        if (field === 'Sender Name') {
            this.senderName = event.target.value;
        } else if (field === 'Requested By') {
            this.requestedBy = event.target.value;
        } else if (field === 'Whitelist a New Global Sender') {
            this.newSender = event.target.value;
        }
    }

    handleRemove(event) {
        const idToRemove = event.target.dataset.id; // Get the ID from the button
        this.transactions = this.transactions.filter(transaction => transaction.id !== idToRemove);
    }

    handleWhitelist() {
        if (this.newSender) {
            // Logic to handle whitelisting the new sender
            // This is where you might send an API request to save the new sender
            console.log(`Whitelisting new sender: ${this.newSender}`);
            // Optionally clear the input field after whitelisting
            this.newSender = '';
        } else {
            console.error('Please enter a valid sender name to whitelist.');
        }
    }
}
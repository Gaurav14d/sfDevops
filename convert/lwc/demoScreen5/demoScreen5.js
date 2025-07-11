import { LightningElement, track } from 'lwc';

export default class DemoScreen5 extends LightningElement {
    @track approvedBy = '';
    @track vanNumber = '';

    @track transactions = [
        {
            id: 1, dateOfRequest: '1/1/1 1:1:1', dateOfApproval: '1/1/1 1:1:1', whoRequested: 'abcd',
            whoApproved: 'aaaa', whitelistedName: 'AAA', transactionId: 'RID 1', endUserName: 'Abcd', policyNumber: 'SA001'
        },
        {
            id: 2, dateOfRequest: '2/2/2 2:2:2', dateOfApproval: '2/2/2 2:2:2', whoRequested: 'efgh',
            whoApproved: 'bbbb', whitelistedName: 'BBB', transactionId: 'RID 2', endUserName: 'Efgh', policyNumber: 'SA002'
        },
        {
            id: 3, dateOfRequest: '3/3/3 3:3:3', dateOfApproval: '3/3/3 3:3:3', whoRequested: 'ijkl',
            whoApproved: 'cccc', whitelistedName: 'CCC', transactionId: 'RID 3', endUserName: 'ijkl', policyNumber: 'SA003'
        }
    ];

    handleInputChange(event) {
        const field = event.target.label;
        if (field === 'Approved By') {
            this.approvedBy = event.target.value;
        } else if (field === 'Virtual Account Number') {
            this.vanNumber = event.target.value;
        }
    }

    handleSearch() {
        console.log('Searching for:', this.approvedBy, this.vanNumber);
    }

    handleRemove(event) {
        const transactionId = event.target.dataset.id;
        this.transactions = this.transactions.filter(transaction => transaction.id !== parseInt(transactionId));
    }
}
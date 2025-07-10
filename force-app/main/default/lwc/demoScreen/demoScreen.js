import { LightningElement, track } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';

export default class TransactionQuarantine extends LightningElement {
    @track transactions = [
        {
            id: '1', senderName: 'Name 1', receiverName: 'Name 1', amount: 'XXX', customerReference: 'abcd',
            bankReference: 'abcd', timestamp: '1/1/1 1:1:1', paymentType: 'Type 1', transactionId: 'ID 1',
            receiverId: 'RID 1', ledgerId: 'LID 1', virtualAccount: 'VA 1', policyNumber: 'SA0001', selected: false
        },
        {
            id: '2', senderName: 'Name 2', receiverName: 'Name 2', amount: 'YYY', customerReference: 'efgh',
            bankReference: 'efgh', timestamp: '2/2/2 2:2:2', paymentType: 'Type 2', transactionId: 'ID 2',
            receiverId: 'RID 2', ledgerId: 'LID 2', virtualAccount: 'VA 2', policyNumber: 'SA0002', selected: false
        },
        {
            id: '3', senderName: 'Name 3', receiverName: 'Name 3', amount: 'ZZZ', customerReference: 'ijkl',
            bankReference: 'ijkl', timestamp: '3/3/3 3:3:3', paymentType: 'Type 3', transactionId: 'ID 3',
            receiverId: 'RID 3', ledgerId: 'LID 3', virtualAccount: 'VA 3', policyNumber: 'SA0003', selected: false
        }
    ];

    @track isDeclineModalOpen = false;

    @track selectedDeclineReason = '';

    // Options for decline reasons
    @track declineOptions = [
        { label: 'Compliance Rejected', value: 'compliance_rejected' },
        { label: 'No Reply from Client', value: 'no_reply_from_client' },
        { label: 'No NRIC Sighted', value: 'no_nric_sighted' },
        { label: 'Mismatched Name', value: 'mismatched_name' }
    ];

    // Handle checkbox state changes for selecting transactions
    handleCheckboxChange(event) {
        const transactionId = event.target.dataset.id; 
        const selected = event.target.checked; 

        // Update the selected state of the transaction
        this.transactions = this.transactions.map(transaction =>
            transaction.id === transactionId
                ? { ...transaction, selected } 
                : transaction 
        );
    }

    // Open the decline modal if at least one transaction is selected
    handleDecline() {
        const selectedTransactions = this.transactions.filter(transaction => transaction.selected);
        if (selectedTransactions.length === 0) {
            this.showToast('Error', 'Please select at least one transaction to decline.', 'error');
            return;
        }

        this.isDeclineModalOpen = true;
    }

    handleDeclineReasonChange(event) {
        this.selectedDeclineReason = event.detail.value; 
    }

    // Close the decline modal and reset the selected reason
    closeDeclineModal() {
        this.isDeclineModalOpen = false; 
        this.selectedDeclineReason = ''; 
    }

    proceedWithDecline() {
        if (this.selectedDeclineReason) {
            this.transactions = this.transactions.filter(transaction => !transaction.selected);

            this.showToast('Success', `Transactions declined due to: ${this.selectedDeclineReason}`, 'success');

            this.closeDeclineModal();
        } else {
            this.showToast('Error', 'Please select a reason before proceeding.', 'error');
        }
    }

    handleAccept() {
        this.showToast('Success', 'Transaction Accepted Successfully', 'Success');
        console.log('Accept button clicked');
    }

    handleAcceptAndWhitelist() {
        this.showToast('Success', 'Transaction Accept and whitelist Successfully', 'Success');

        console.log('Accept & Whitelist button clicked');
    }

    showToast(title, message, variant) {
        const event = new ShowToastEvent({
            title,
            message,
            variant,
        });
        this.dispatchEvent(event); 
}
}
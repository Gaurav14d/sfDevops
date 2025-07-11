import { LightningElement } from 'lwc';

export default class DemoScreen3 extends LightningElement {
    records = [
        {
            senderName: 'Name 1',
            receiverName: 'Name 1',
            amount: 'XXX',
            reference: 'abcd',
            transactionDate: '2023-01-01',
            paymentType: 'Type 1',
            transactionId: 'ID 1',
            receiverId: 'RID 1',
            ledgerId: 'LID 1',
            virtualAccount: 'VA 1',
            policyNumber: 'SA0001',
            transactionOutcome: 'Rejected',
            staffEmail: 'aa@singlife.com',
            rejectionReason: 'Compliance rejected'
        },
        {
            senderName: 'Name 2',
            receiverName: 'Name 2',
            amount: 'YYY',
            reference: 'efgh',
            transactionDate: '2023-02-02',
            paymentType: 'Type 2',
            transactionId: 'ID 2',
            receiverId: 'RID 2',
            ledgerId: 'LID 2',
            virtualAccount: 'VA 2',
            policyNumber: 'SA0002',
            transactionOutcome: 'Approved',
            staffEmail: 'bb@singlife.com',
            rejectionReason: 'N/A'
        },
        {
            senderName: 'Name 3',
            receiverName: 'Name 3',
            amount: 'ZZZ',
            reference: 'ijkl',
            transactionDate: '2023-03-03',
            paymentType: 'Type 3',
            transactionId: 'ID 3',
            receiverId: 'RID 3',
            ledgerId: 'LID 3',
            virtualAccount: 'VA 3',
            policyNumber: 'SA0003',
            transactionOutcome: 'Pending',
            staffEmail: 'cc@singlife.com',
            rejectionReason: 'N/A'
        }
    ];

    // Store search criteria
    searchCriteria = {
        ledgerId: '',
        transactionId: '',
        transactionDate: '',
        virtualAccount: ''
    };

    // Filtered records based on the search criteria
    filteredRecords = this.records;

    // Handle input change
    handleInputChange(event) {
        const field = event.target.name;
        this.searchCriteria[field] = event.target.value;
    }

    // Handle search operation
    handleSearch() {
        const { ledgerId, transactionId, transactionDate, virtualAccount } = this.searchCriteria;
        this.filteredRecords = this.records.filter(record => {
            return (
                (!ledgerId || record.ledgerId.includes(ledgerId)) &&
                (!transactionId || record.transactionId.includes(transactionId)) &&
                (!transactionDate || record.transactionDate === transactionDate) &&
                (!virtualAccount || record.virtualAccount.includes(virtualAccount))
            );
        });
    }
}
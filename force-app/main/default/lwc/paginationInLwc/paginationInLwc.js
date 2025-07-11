import { LightningElement, track } from 'lwc';
import { NavigationMixin } from 'lightning/navigation';
import fetchAccounts from '@salesforce/apex/createAccounts.getAccounts';

export default class PaginationLwc extends NavigationMixin(LightningElement) {
    @track pageSizeOptions = [10, 20, 30, 40, 50, 100];
    @track records = [];
    @track columns = [];
    @track totalRecords = 0;
    @track pageSize = 10;
    @track totalPages = 0;
    @track pageNumber = 1;
    @track recordsToDisplay = [];

    get bDisableFirst() {
        return this.pageNumber === 1;
    }
    get bDisableLast() {
        return this.pageNumber === 1;
    }

    connectedCallback() {
        this.columns = [
            { label: 'Account Name', fieldName: 'Name' },
            { label: 'Active__c', fieldName: 'Active__c' },
            { label: 'LastModifiedDate', fieldName: 'LastModifiedDate' },
            { label: 'Account Type', fieldName: 'Type' },
            { label: 'Id', fieldName: 'Id' }
        ];

        fetchAccounts()
            .then((results) => {
                if (results) {
                    console.log('RESULTS-->' + JSON.stringify(results));
                    this.records = results;
                    this.totalRecords = results.length;
                    this.paginationHelper();
                }
            })
            .catch((error) => {
                console.log('error while fetching Accounts-->' + JSON.stringify(error));
            });
    }

    handleRecordsPerPage(event) {
        this.pageSize = parseInt(event.target.value, 10);
        this.pageNumber = 1;
        this.paginationHelper();
    }
    // For Devops Testing
    previousPage() {
        if (this.pageNumber > 1) {
            this.pageNumber--;
            this.paginationHelper();
        }
    }
    nextPage() {
        if (this.pageNumber < this.totalPages) {
            this.pageNumber++;
            this.paginationHelper();
        }
    }

    firstPage() {
        this.pageNumber = 1;
        this.paginationHelper();
    }
    lastPage() {
        this.pageNumber = 1;
        this.paginationHelper();
    }
    paginationHelper() {
        this.recordsToDisplay = [];
        this.totalPages = Math.ceil(this.totalRecords / this.pageSize);

        if (this.pageNumber < 1) {
            this.pageNumber = 1;
        } else if (this.pageNumber > this.totalPages) {
            this.pageNumber = this.totalPages;
        }

        const startIndex = (this.pageNumber - 1) * this.pageSize;
        const endIndex = Math.min(this.pageNumber * this.pageSize, this.totalRecords);

        for (let i = startIndex; i < endIndex; i++) {
            this.recordsToDisplay.push(this.records[i]);
        }
    }

    navigateToViewAccountPage(recordId) {
        this[NavigationMixin.Navigate]({
            type: 'standard__recordPage',
            attributes: {
                recordId: recordId,
                objectApiName: 'Account',
                actionName: 'view'
            }
        });
    }

    handleSearch(event) {
        const searchInput = event.target.value.toLowerCase();
        if (searchInput) {
            this.recordsToDisplay = this.records.filter(record => {
                return Object.values(record).some(value =>
                    value && value.toString().toLowerCase().includes(searchInput)
                );
            });
        } else {
            this.recordsToDisplay = this.records.slice(
                (this.pageNumber - 1) * this.pageSize,
                this.pageNumber * this.pageSize
            );
        }
    }
}
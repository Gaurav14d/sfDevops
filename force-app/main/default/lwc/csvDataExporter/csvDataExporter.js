import { LightningElement, wire } from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
import fetchRecords from '@salesforce/apex/CsvController.fetchRecords';

export default class CsvDataExporter extends LightningElement {
    accountData = [];
    columns = [
        { label: 'Id', fieldName: 'Id' },
        { label: 'Account Name', fieldName: 'Name' },
        { label: 'Phone', fieldName: 'Phone' },
        { label: 'Industry', fieldName: 'Industry' },
        { label: 'Type', fieldName: 'Type' },
        { label: 'AnnualRevenue', fieldName: 'AnnualRevenue' },
        { label: 'Active__c', fieldName: 'Active__c' }
    ];

    @wire(fetchRecords) wiredFunction({ data, error }) {
        if (data) {
            console.log('Inside Wire');
            console.log('Data==>>', data);
            this.accountData = data;
        } else if (error) {
            console.log(error);
        }
    }

    get checkRecord() {
        return this.accountData.length > 0 ? false : true; 
    }

    clickHandler() {
     //   let selectedRows = [];
       let downloadRecords = [];
        // selectedRows = this.template.querySelector("lightning-datatable").getSelectedRows()
        // if(selectedRows.length > 0) {
        //     downloadRecords = [...selectedRows];
        // } else {
            downloadRecords = [...this.accountData];
       // }
        let csvFile = this.convertArrayToCsv(downloadRecords);
        this.createLinkForDownload(csvFile);
        this.showSuccessToast(); 
    }

    convertArrayToCsv(downloadRecords) {
        let csvHeader = Object.keys(downloadRecords[0]).toString();
        console.log('header: ' + csvHeader);
        let csvBody = downloadRecords.map((currItem) => Object.values(currItem).toString());
        console.log('body: ' + csvBody);
        let csvFile = csvHeader + "\n" + csvBody.join("\n");
        return csvFile;
    }

    createLinkForDownload(csvFile) {
        const downLink = document.createElement("a");
        downLink.href = "data:text/csv;charset=utf-8," + encodeURI(csvFile);
        downLink.target = '_blank';
        downLink.download = "Account_Record_Data.csv";
        downLink.click();
    }

    showSuccessToast() {
        const evt = new ShowToastEvent({
            title: 'Success',
            message: 'Your file has been downloaded.',
            variant: 'success',
        });
        this.dispatchEvent(evt);
    }
}
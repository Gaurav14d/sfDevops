import { LightningElement, track, wire } from 'lwc';
import fetchContactData from '@salesforce/apex/ExportDataCtrl.getContactData';
import { CurrentPageReference } from 'lightning/navigation';

export default class ExportData extends LightningElement {
    @track recordId;
    @track allData = [];
    isDataExported = false;
    columnHeader = ['Id', 'Name', 'Email'];

    @wire(CurrentPageReference)
    getStateParameters(currentPageReference) {
        if (currentPageReference) {
            this.recordId = currentPageReference.state.recordId;
        }
    }

    @wire(fetchContactData, { recordId: '$recordId' })
    wiredData({ error, data }) {
        if (data) {
            console.log('Data:', data);
            this.allData = Array.isArray(data) ? data : [];
        } else if (error) {
            console.error('Error:', error);
        }
    }

    exportData() {
        this.isDataExported = false;

        if (!Array.isArray(this.allData) || this.allData.length === 0) {
            console.warn('No data to export');
            return;
        }

        const csvHeader = this.columnHeader.join(',');
        const csvBody = this.allData.map(item =>
            this.columnHeader.map(field => item[field] || '').join(',')
        );

        const csvFile = csvHeader + '\n' + csvBody.join('\n');

        const downLink = document.createElement('a');
        downLink.href = 'data:text/csv;charset=utf-8,' + encodeURIComponent(csvFile);
        downLink.target = '_blank';
        downLink.download = 'data.csv';
        document.body.appendChild(downLink); // Append to body to make it work in some browsers
        downLink.click();
        document.body.removeChild(downLink); // Remove after clicking

        this.isDataExported = true;
    }
}
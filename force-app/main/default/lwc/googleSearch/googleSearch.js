import { LightningElement, track } from 'lwc';
import searchGoogle from '@salesforce/apex/GoogleSearchService.searchGoogle';

export default class GoogleSearch extends LightningElement {
    @track searchQuery = '';
    @track results;

    handleInput(event) {
        this.searchQuery = event.target.value;
    }

    handleSearch() {
        searchGoogle({ query: this.searchQuery })
            .then(data => {
                this.results = data;
            })
            .catch(error => {
                console.error('Error fetching search results', error);
            });
    }
}
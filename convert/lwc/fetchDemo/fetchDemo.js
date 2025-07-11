import { LightningElement, track } from 'lwc';

export default class FetchDemo extends LightningElement {
    @track imgURL;
    endPoint = 'https://some-random-api.ml/endpoints/animal/bird';

    async getImageHandler() {
        try {
            const response = await fetch(this.endPoint, { method: 'GET' });

            if (!response.ok) {
                throw new Error(`HTTP error! Status: ${response.status}`);
            }

            const resp = await response.json();
            this.imgURL = resp.image; 
        } catch (error) {
            console.error('There was a problem with the fetch operation:', error);
        }
    }
}
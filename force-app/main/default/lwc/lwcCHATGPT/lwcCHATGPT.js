import { LightningElement, api, track } from 'lwc';
import getChatGPTResponse from '@salesforce/apex/ChatGPTService.getChatGPTResponse';

export default class LwcChatGPT extends LightningElement {
    @api question = ' What is salesforce';
    @track message = '';
    @track isLoaded = true;

    handleOnChange(event) {
        this.question = event.target.value;
    }

    async handleOnClick() {
        // Show loader
        this.isLoaded = false;

        try {

            const result = await getChatGPTResponse({ question: this.question });
            this.message = result;
        } catch (error) {
            console.error('Error:', error);
            this.message = 'Error: ' + (error.body?.message || error.message || JSON.stringify(error));
        } finally {
            this.isLoaded = true;
        }
    }
}
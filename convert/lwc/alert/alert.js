import { LightningElement } from 'lwc';
import LightningAlert from 'lightning/alert';

export default class Alert extends LightningElement {
    async handleAlertClick(){
        await LightningAlert.open({
            message: 'this is the alert message',
            theme: 'error',
            label: 'error!'
        }
            
        );
    }
}
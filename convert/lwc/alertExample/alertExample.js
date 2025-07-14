import { LightningElement } from 'lwc';
import LightningAlert from 'lightning/alert';

export default class AlertExample extends LightningElement {
async handleShowAlert() {
    await LightningAlert.open({
        message: 'This is a test alert message!',
        theme: 'error',
        label: 'Error Alert'
    });
}
}
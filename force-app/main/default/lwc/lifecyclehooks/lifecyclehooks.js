import { LightningElement } from 'lwc';

export default class Lifecyclehooks extends LightningElement {
constructor() {
    super();
    console.log('call received from constructor');
}
connectedCallback(){
    console.log('call received from connectedCallback');

}
renderedCallback(){
    console.log('call received from rendered call back');
}
}
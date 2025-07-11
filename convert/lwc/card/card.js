import { LightningElement } from 'lwc';
import { ShowToastEvent } from "lightning/platformShowToastEvent";


export default class Card extends LightningElement {
  handleclick(){
    this.ShowToastEvent();
    
  }
  ShowToastEvent(){
    const event = new ShowToastEvent({
    title: 'show toast demo',
    message: 'show message',
    variant: 'success',
    });
     this.dispatchEvent(event);
  }
}
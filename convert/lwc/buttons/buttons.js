import { LightningElement } from 'lwc';

export default class Buttons extends LightningElement {
    isSelected = false;
    handleClick(){
            this.isSelected = !this.isSelected;
    }
}
import { LightningElement } from 'lwc';

export default class CheckBoxGroup extends LightningElement {
    value=['Option 1'];
    get options(){
        return [
            {label: 'Gaurav', value: 'option 1'},
            {label: 'Vaibhav', value: 'option 2'},
            {label: 'Vipul', value: 'option 3'}
        ];
    }
    get slectedvalues(){
        return this.value.join(',');
    }
    handleChange(e){
        this.value=e.detail.value;
    }
}
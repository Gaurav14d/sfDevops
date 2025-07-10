import { LightningElement } from 'lwc';

export default class ComboBox extends LightningElement {
    value='inProgress';
    get options(){
        return[
            {label:'New', value: 'New'},
            {label: 'In Progress', value: 'inProgress'},
            {label: 'Finsihed', value: 'Finished'}
        ];
    }
    handleChange(event){
        this.value=event.details.value;
    }

}
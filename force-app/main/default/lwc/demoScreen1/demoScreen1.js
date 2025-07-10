import { LightningElement } from 'lwc';

export default class DemoScreen1 extends LightningElement {
get options() {
    return [
        { label: 'Compliance Rejected', value: 'Compliance Rejected' },
        { label: 'In Progress', value: 'inProgress' },
        { label: 'Finished', value: 'finished' },
    ];
}
handleChange(event) {
    this.value = event.target.value;
}
}
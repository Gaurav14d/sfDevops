import { LightningElement } from 'lwc';

export default class MyFirstLwcComponent extends LightningElement {
    myTitle = 'Salesforce Developer';
    connectedCallback(){
        var name = "Salesforce Developer";
        window.alert("age"+name);
    }

}
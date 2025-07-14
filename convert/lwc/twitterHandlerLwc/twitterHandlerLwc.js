import { LightningElement, api, wire } from 'lwc';
import { getRecord } from 'lightning/uiRecordApi';
const FIELDS = ['Contact.Twitter_Handle__c']
export default class TwitterHandlerLwc extends LightningElement {
    @api recordId
    twitterHandler = "Gaurav_14Dubey"
    get fullUrl(){
        return `https://d5g00000llag5eal-dev-ed--c.develop.vf.force.com/apex/twitterFeedPage?Gaurav_14Dubey`
    }

    @wire(getRecord, { recordId: '$recordId', fields: FIELDS})
    wiredRecord({ error, data }) {
        if(data){
            this.twitterHandler = data.fields.Twitter_Handle__c.value
        } 
        if(error){
            console.error(error)
        }
    }

    
}
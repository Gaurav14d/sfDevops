import { LightningElement, track } from 'lwc';
import productController from '@salesforce/apex/ProductController.updateProductQuantity';

export default class DynamicProductItems extends LightningElement {
    @track producttData;
    connectedCallback(){
        updateProductQuantity({}.then(result=>{
        this.producttData=result;
        }))
        .catch(error=>{
            console.log('error', error);
        })
    }
}
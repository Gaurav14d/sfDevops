import { LightningElement,track } from 'lwc';
import { ShowToastEvent } from "lightning/platformShowToastEvent";
import ProductItem from '@salesforce/apex/ProductItemListController.getProducts';


export default class ProductItemsList extends LightningElement {


    @track sgst = 0;
    @track cgst =  0;
    @track secondScreen = false;
    @track firstScreen = true;
    @track error;
    @track addToCart =[]; 
    @track cartObj; 
   @track totalPayment = 0; 
   @track newProdcuts = [];

  /*@track products = [{
        Id : '1',
        name : 'T Shirt',
        price : 400,
        image : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTe8TClBpoLKnOcyOUvO9DaeYJ9jiTbE11h7g&s.png",
        quantity : 0,
        quantity2: 0
    },
    {
        Id : '2',
        name : 'Polo T Shirt',
        price : 190,
        image : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcT304XoMs9wRaorQC4v6uXhWM2qdj8jplE-mA&s.png",
        quantity : 0,
        quantity2: 0
    },
    {
        Id : '3',
        name : 'T Shirt',
        price : 200,
        image : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSodi0cRZhRDyER0gEinNr2QYIzQhzHE9Sm5w&s.png",
        quantity : 0,
        quantity2: 0
    },
    {
        Id : '4',
        name : 'T Shirt',
        price : 100,
        image : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTe8TClBpoLKnOcyOUvO9DaeYJ9jiTbE11h7g&s.png",
        quantity : 0,
        quantity2: 0
    },
    {
        Id : '5',
        name : 'T Shirt',
        price : 500,
        image : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTe8TClBpoLKnOcyOUvO9DaeYJ9jiTbE11h7g&s.png",
        quantity : 0,
        quantity2: 0
    },
    {
        Id : '6',
        name : 'T Shirt',
        price : 300,
        image : "https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcTe8TClBpoLKnOcyOUvO9DaeYJ9jiTbE11h7g&s.png",
        quantity : 0,
        quantity2: 0
    }];
    */


    recordSize = 3;
    pageNumber = 1; 
    productToDisplay = []; 
    @track totalRecords
    @track totalPages

    connectedCallBack(){
        ProductItem()
        .then(result=>{
            this.ProductItemList = result;
        })
        .catch(error=>{
            console.log(error);
        })


        this.paginationHelper();
    }

    get handleDisablePrevious() {
        return this.pageNumber == 1;
    }
    get handleDisableNext() {
        console.log('this.pageNumber == this.totalPages;' , this.pageNumber == this.totalPages);
        return this.pageNumber == this.totalPages;
    }
    paginationHelper() {
        this.productToDisplay = [];

        
        const start = ((this.pageNumber - 1) * this.recordSize);
        const end = start + this.recordSize;
        for (let i = start; i < end; i++) {
            this.productToDisplay.push(this.products[i]);
        }

    }

    handleClick(event){

        if(event.target.title == 'Previous'){
            this.pageNumber = this.pageNumber - 1;
            this.paginationHelper();
        }

        if(event.target.title == 'Next'){
            this.pageNumber = this.pageNumber + 1;
            this.paginationHelper();
        }

    
        if(event.target.title == 'Remove'){
            const productId = event.target.dataset.id;
            this.productToDisplay = this.productToDisplay.map(product=>{
                if(product.Id === productId && product.quantity>0){
                    return{ ...product, quantity: product.quantity - 1, quantity2: product.quantity2 - 1, finalPrice: ((product.quantity - 1) * product.Price__c)}
                }
                return product;
            });

        }

        if(event.target.title == 'Add'){
            const productId = event.target.dataset.id;
            this.productToDisplay = this.productToDisplay.map(product =>{
                if(product.Id === productId){
                    return{ ...product, quantity: (product.quantity + 1), quantity2: product.quantity2 + 1, finalPrice: (product.price * (product.quantity + 1))};
                }
                return product;
            });
        }

    
        if(event.target.title == 'AddToCart' && event.target.value > 0){
            const productId = event.target.dataset.id;
            this.cartObj = this.productToDisplay.map(product =>{
                if(product.Id === productId){
                    return{ ...product, finalPrice: (product.price *(product.quantity2)), sgst: (product.price * 0.5), cgst: (product.price * 0.5)};
                }
                return null;     
            });
            this.cartObj.forEach(element => {
                if(element != null){
                    this.addToCart.push(element);
                }
            });
            console.log("add to cart ==>",this.addToCart);
            console.log("obj ==>",this.cartObj);
    
            this.productToDisplay = this.productToDisplay.map(product =>{
                if(product.Id === productId){
                    return{ ...product, quantity: 0};
                }
                console.log(this.addToCart);
                return product;
            });
            const eventToast = new ShowToastEvent({
                title: event.target.name+' Added !!',
                message: 'Product added to cart successfully!',
                variant: 'success',
                mode: 'dismissable'
            });
            this.dispatchEvent(eventToast);

        }
        
    
        if(event.target.title == 'cart'){
            this.secondScreen = true;
            this.firstScreen = false;
            
        }

    }
}
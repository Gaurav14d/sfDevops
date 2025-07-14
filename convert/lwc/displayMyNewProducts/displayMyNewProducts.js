import Name from '@salesforce/schema/Account.Name';
import { LightningElement , track} from 'lwc';
export default class displayMyNewProducts extends LightningElement {
    screen1 = true;
    @track addtocartItems = [];
    @track paginatedProducts = [];
    @track currentPage = 1;
    totalNoOFProducts = 0
    productsPerPage = 3;


    @track products = [{
    Id : '1',
    Name: 'GenWatt Diesel 10kW',
    image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRloIRbeNr-gZzLvYRAiIdr6HjiM_HuDJpzxA&s.jpg',
    price: 130000,
    quantity: 0,
    productId : 0,
    finalPrice : 0
    },
    {
    Id :'2',
    Name: "GenWatt Diesel 20kW",
    image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRPEP0G4ZJGLT0URp3vqviXEIwGi7cYVwXvzA&s.jpg',
    price: 120000,
    quantity: 0,
    productId : 0,
    finalPrice : 0
    },
    {
    Id : '3',
    Name: 'GenWatt Diesel 200kW',
    image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSRxvoBHvvgzaBuWCNsxpjzPMA4C162r31tjw&s.jpg',
    price: 1212122,
    quantity: 0,
    productId : 0,
    finalPrice : 0
    },
    {
        Id : '4',
        Name: 'GenWatt Diesel 200kW',
        image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSRxvoBHvvgzaBuWCNsxpjzPMA4C162r31tjw&s.jpg',
        price: 1212122,
        quantity: 0,
        productId : 0,
        finalPrice : 0
        },
        {
            Id : '5',
            Name: 'GenWatt Diesel 200kW',
            image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSRxvoBHvvgzaBuWCNsxpjzPMA4C162r31tjw&s.jpg',
            price: 1212122,
            quantity: 0,
            productId : 0,
            finalPrice : 0
            },
            {
                Id : '6',
                Name: 'GenWatt Diesel 200kW',
                image: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSRxvoBHvvgzaBuWCNsxpjzPMA4C162r31tjw&s.jpg',
                price: 1212122,
                quantity: 0,
                productId : 0,
                finalPrice : 0
                }
                
];
decrementQuantity(event){
    const productId = event.target.dataset.id;
    console.log(productId);
    this.products = this.products.map(product => {
        if(product.Id === productId && product.quantity>0){
            return { ...product, quantity: product.quantity - 1, finalPrice : (product.unitPrice * (product.quantity - 1)) };
        }
        return product;
    });
    this.addtocartItems = this.addtocartItems.map(product=>{
        if(product.Id === productId && product.quantity>0){
            return{ ...product, quantity: product.quantity-1, finalprice: (product.unitprice*(product.quantity -1))}
        }
    });

}

incrementQuantity(event){
    const productId = event.target.dataset.id;
    console.log(productId);
    this.products = this.products.map(product => {
        if(product.Id === productId){
            return { ...product, quantity: product.quantity + 1, finalPrice : (product.unitPrice * (product.quantity + 1)) };
        }
        return product;
    });
    this.addtocartItems = this.addtocartItems.map(product=>{
        if(product.Id === productId){
            return{ ...product, quantity: product.quantity +1, finalPrice :(product.unitPrice * (product.quantity + 1))};
        }
    });
}
get totalPages() {
    return Math.ceil(this.listOfProducts.length / this.productsPerPage);
}
get isPreviousDisabled() {
    return this.currentPage <= 1;
}

get isNextDisabled() {
    return this.currentPage >= this.totalPages;
}

handlePrevious() {
    console.log('handlePrevious called');
    if (this.currentPage > 1) {
        this.currentPage--;
        this.updatePaginatedProducts();
    }
}

handleNext() {
    console.log('handleNext called')
    if (this.currentPage < this.totalPages) {
        this.currentPage++;
        this.updatePaginatedProducts();
    }
}

updatePaginatedProducts() {
    console.log('updatePaginatedProducts called');
    const start = (this.currentPage - 1) * this.productsPerPage;
    const end = start + this.productsPerPage;
    this.paginatedProducts = this.listOfProducts(start, end);
    console.log('paginatedProducts : ',JSON.stringify(this.paginatedProducts));
}
connectedCallback() {
    this.updatePaginatedProducts();
}


}
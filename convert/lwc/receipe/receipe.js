import { LightningElement, api, wire } from "lwc";
//import getRandomRecipe from "@salesforce/apex/SpoonacularAPI.getRandomRecipe";
//import getRandomRecipeInformation from "@salesforce/apex/SpoonacularAPI.getRandomRecipeInformation";

export default class Receipe extends LightningElement {
    @api image;
    @api title;
    @api price;
    @api time;
    @api summary;
    @api recipeId;
    dishList;
    dietList;

    @api
    set dishTypes(data) {
        this.dishList = data && data.join();
    }
    get dishTypes() {
        return this.dishList;
    }

    @api
    set diets(data) {
        this.dietList = data && data.join();
    }
    get diets() {
        return this.dietList;
    }

    fetchRecipe() {
        getRandomRecipeInformation({ recipeId: this.recipeId })
            .then((data) => {
                this.handleRecipeData(data);
            })
            .catch((error) => {
                console.error("Error fetching recipe information: ", error);
            });
    }

    handleRecipeData(data) {
        const recipe = JSON.parse(data);
        if (recipe) {
            this.image = recipe.image;
            this.price = recipe.pricePerServing;
            this.time = recipe.readyInMinutes;
            this.summary = recipe.summary;
            this.dishList = recipe.dishTypes && recipe.dishTypes.join();
            this.dietList = recipe.diets && recipe.diets.join();
        }
    }

    get hasDetails() {
        return this.summary ? true : false;
    }
}
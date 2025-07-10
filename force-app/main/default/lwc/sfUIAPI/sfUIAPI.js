import { LightningElement, wire, track} from 'lwc';
import { ShowToastEvent } from 'lightning/platformShowToastEvent';
//import patch from '@salesforce/apex/SurveyApi1.patch';
//import post from '@salesforce/apex/SurveyApi1.post';
i//mport getSurveyResponseRecord from '@salesforce/apex/CustomIndigoSurveyController.getSurveyResponseRecord';
//import saveResponse from '@salesforce/apex/CustomIndigoSurveyController.saveResponse';
//import prepareQuestionObject from "c/utils";
//import indiGoIcon from '@salesforce/resourceUrl/indiGoIcon';
export default class SurveyAPI1 extends LightningElement {
    @track mapData = []
    @track surveyDescriptionOutput;
    @track surveyDetail;
    @track surveyPage;
    @track surveyQuestions;
    @track numOfQuestion;
    @track contact;
    @track thankyouPageRep = undefined;
    selectedLanguage='';
    sfRecordId = '';
    surveyId = '';
    @track isOnWelcomePage = true;
    invitationSetting = {
        "allowGuestUserResponse" : true,
        "allowParticipantsAccessTheirResponse" : false,
        "collectAnonymousResponse" : false
    }
    
    connectedCallback(){
        var url = new URL(window.location.href);
        this.selectedLanguage = url.searchParams.get("language");
        this.sfRecordId = url.searchParams.get("id");
        if(this.sfRecordId != null){
            // getSurveyResponseRecord({ recordId: this.sfRecordId })
            //     .then(data => {
            //         console.log('getSurveyResponseRecord', data);
            //         if(data != null){
            //             //this.isOnWelcomePage = false;
            //             for(var response of data[0].Survey_Question_Responses__r){
            //                 this.defaultResponseMap[response.name] = response.Response__c;
            //             }
            //             //console.log(data[0].Response__c);
            //             //this.defaultResponseMap = JSON.parse(data[0].Response__c);
            //             //this.fillData(JSON.parse(data[0].Pages_With_Questions__c));
            //         }else{
            //             this.isOnWelcomePage = true;
            //         }
            //     }).catch (error => {
            //     console.log("Error : " + error.body.message);
            //     }); 
            let payloadStart;
                let payloadStartObject = {
                    "invitationSettings" : this.invitationSetting
                }

                payloadStart = JSON.stringify(payloadStartObject);
                console.log('payloadStart==>',payloadStart)
                post({payloadString : payloadStart}).then(data => {
                    console.log("data : " , data);
                }).catch(error => {
                    console.log("error : " , error);
                })
        }
   }
   handleNext(evt){
        getSurveyResponseRecord({recordId : this.sfRecordId})
        .then(data => {
            console.log('getSurveyResponseRecord',data);
            console.log('getSurveyResponseRecord',data.length);
            if(data.length == 0){
                let payloadStart;
                let payloadStartObject = {
                    "invitationSettings" : this.invitationSetting
                }

                payloadStart = JSON.stringify(payloadStartObject);
                console.log('payloadStart==>',payloadStart)
                post({payloadString : payloadStart}).then(data => {
                    console.log("data : " + data);
                    if(data.error){
                        const evt = new ShowToastEvent({
                            title: data.error[0].errorCode,
                            message: data.error[0].message,
                            variant: 'error',
                            mode: 'dismissable'
                        });
                        this.dispatchEvent(evt);
                    }else if(data.errors && data.errors.length != 0){
                        const evt = new ShowToastEvent({
                            title: data.status,
                            message: data.errors[0],
                            variant: 'error',
                            mode: 'dismissable'
                        });
                        this.dispatchEvent(evt); 
                    }
                    else{
                        this.fillData(data);  
                    }
                }).catch(error => {
                    console.log("Error : " + error.body.message);
                }); 
            }else{
                this.isOnWelcomePage = false;
                console.log(data[0].Response__c);
                this.defaultResponseMap = JSON.parse(data[0].Response__c);
                this.fillData(JSON.parse(data[0].Pages_With_Questions__c)); 
            }
            this.isOnWelcomePage = false;
        }).catch(error => {
            console.log("Error : " + error.body.message);
        }); 
    }  

    fillData(data){
        console.log('data====>',data);
        this.surveyDescriptionOutput = data;
        // if(!this.isPrefilled){
        //     this.surveyDetail = data.surveyDetail;
        //     this.surveyPage = this.surveyDetail.surveyPage;
        //     this.surveyQuestions = this.surveyPage.surveyQuestions;
        //     this.numOfQuestion = this.surveyQuestions.length;
        //     this.initializeDataMap();
        // }else{
        //     console.log('data.surveyPageResponses===>',data.surveyPageResponses)
        //     console.log('data.questionResponses===>',data.surveyPageResponses.questionResponses)
        // }
        this.surveyDetail = data.surveyDetail;
        this.surveyPage = this.surveyDetail.surveyPage;
        this.surveyQuestions = this.surveyPage.surveyQuestions;
        this.numOfQuestion = this.surveyQuestions.length;
        this.initializeDataMap();
    }

    defaultResponseMap = {};
    dataQuestionTypeMap = {};
    initializeDataMap(){
      for(let index in this.surveyQuestions){
        let question = this.surveyQuestions[index];
        if(this.defaultResponseMap[question.name] != undefined && this.defaultResponseMap[question.name] != null && this.defaultResponseMap[question.name] != ''){
            console.log('Here ', question.name);
            this.surveyQuestions[index]['response'] = this.defaultResponseMap[question.name];
            console.log('surveyQuestions ', this.surveyQuestions);
        }else{
            if(question.questionType === 'FreeText' || question.questionType === 'ShortText'){
                this.defaultResponseMap[question.name] = '';
            }else if(question.questionType === 'MultiChoice' || question.questionType === 'RadioButton' || question.questionType === 'Boolean' || question.questionType === 'Rating'){
                this.defaultResponseMap[question.name] = [];
            }else{
                this.defaultResponseMap[question.name] = null;
            }
            this.surveyQuestions[index]['response'] = null;
        }
        this.dataQuestionTypeMap[question.name] = question.questionType;
      }
    }

    choiceClicked(evt){
        console.log('choiceClicked');
        var questionName = evt.detail.questionName;
        var choiceName = evt.detail.choiceDevName;
        var type = evt.detail.type;
        if(type == 'add'){
            this.defaultResponseMap[questionName].push(choiceName);
        }else{
            const index = this.defaultResponseMap[questionName].indexOf(choiceName);
            if(index > -1){
                this.defaultResponseMap[questionName].splice(index, 1);
            }
        }
        this.saveThePartialResponse();
    }

    singleChoiceClicked(evt){
        console.log('singleChoiceClicked');
        var questionName = evt.detail.questionName;
        var choiceName = evt.detail.choiceDevName;
        var type = evt.detail.type;
        if(type == 'add'){
            if(this.defaultResponseMap[questionName].length > 0){
                this.defaultResponseMap[questionName].pop();
            }
                
            this.defaultResponseMap[questionName].push(choiceName);
        }else{
            const index = this.defaultResponseMap[questionName].indexOf(choiceName);
            if(index > -1){
                this.defaultResponseMap[questionName].splice(index, 1);
            }
        }
        this.saveThePartialResponse();
    }
    inputChanged(evt){
        console.log('inputChanged');
        var questionName = evt.detail.name;
        var value = evt.detail.value;
        this.defaultResponseMap[questionName] = value;
        this.saveThePartialResponse();
    }

  
    @track submitPayload = {};

    payloadPreparation(){
        this.submitPayload["invitationId"] = this.surveyDescriptionOutput.invitationId;
        this.submitPayload["flowInterviewState"] = this.surveyDescriptionOutput.flowInterviewState;
        this.submitPayload["navigationAction"] = "Next";
        var questionResponses = [];
        for(let key in this.defaultResponseMap){
            let obj = prepareQuestionObject(this.dataQuestionTypeMap, this.defaultResponseMap, key);
            questionResponses.push(obj);
        }

        var surveyPageResponses = {
            "name":"p_c9b0cbf0_b908_4315_9b2b_c882e50e1849",
            "questionResponses" : questionResponses
        }

        this.submitPayload["surveyPageResponses"] = surveyPageResponses;
    }

    handleSubmit(){
        this.payloadPreparation();
        console.log(this.submitPayload);
        var payloadString = JSON.stringify(this.submitPayload);
        patch({payload: payloadString, invitationId : this.surveyDescriptionOutput.invitationId}).then(response => {
            if(response.error){
                const evt = new ShowToastEvent({
                    title: response.error[0].errorCode,
                    message: response.error[0].message,
                    variant: 'error',
                    mode: 'dismissable'
                });
                this.dispatchEvent(evt); 
            }else if(response.errors && response.errors.length != 0){
                const evt = new ShowToastEvent({
                    title: response.status,
                    message: response.errors[0],
                    variant: 'error',
                    mode: 'dismissable'
                });
                this.dispatchEvent(evt); 
            }
            else{
                console.log(response);
                this.thankyouPageRep = response;
                this.clearData();
            }
        }).catch(error => {
            console.log("Error : " + error.body.message);
        })
    }

    clearData(){
        this.surveyDescriptionOutput = undefined;
        this.surveyDetail = undefined
        this.surveyPage = undefined;
        this.surveyQuestions = undefined;
        this.defaultResponseMap = {};
        this.dataQuestionTypeMap = {};
        this.contact = undefined;
        this.numOfQuestion = undefined;

        this.invitationSetting = {
            "allowGuestUserResponse" : false,
            "allowParticipantsAccessTheirResponse" : false,
            "collectAnonymousResponse" : false
        }
    }
    saveThePartialResponse(){
        this.payloadPreparation();
        saveResponse({
            recordId: this.sfRecordId,
            surveyInvitationId: this.surveyDescriptionOutput.invitationId,
            response: JSON.stringify(this.defaultResponseMap),
            /*surveyId: this.surveyId,*/
            pagesWithQuestions: JSON.stringify(this.surveyDescriptionOutput)
        })
        .then(data => {

        }).catch(error => {
            console.log("Error : " + error.body.message);
        }); 
    }

    indiGoIcon = indiGoIcon;

    value = 'English';

    get options() {
        return [
            { label: 'English', value: 'English' },
            { label: 'हिन्दी', value: 'hindi' }
        ];
    }
}
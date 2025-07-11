/**
* @description       : 
* @author            : ChangeMeIn@UserSettingsUnder.SFDoc
* @group             : 
* @last modified on  : 01-21-2025
* @last modified by  : ChangeMeIn@UserSettingsUnder.SFDoc
**/
public with sharing class ChatGPTService {
@AuraEnabled
public static String getChatGPTResponse(String question) {
    String endpoint = 'https://api.openai.com/v1/chat/completions';
    Http http = new Http();
    HttpRequest request = new HttpRequest();
    
    request.setEndpoint(endpoint);
    request.setMethod('POST');
    request.setHeader('Authorization', 'Bearer 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');
    request.setHeader('Content-Type', 'application/json');
    
    Map<String, Object> messageMap = new Map<String, Object>{
        'role' => 'user',
        'content' => question
    };
    
    List<Map<String, Object>> messagesList = new List<Map<String, Object>>();
    messagesList.add(messageMap);
    

    Map<String, Object> requestBody = new Map<String, Object>{
        'model' => 'gpt-3.5-turbo',
        'messages' => messagesList
    };
    
    request.setBody(JSON.serialize(requestBody));
    
    HttpResponse response = http.send(request);
    
    if (response.getStatusCode() == 200) {
        Map<String, Object> jsonResponse = (Map<String, Object>) JSON.deserializeUntyped(response.getBody());
        List<Object> choices = (List<Object>) jsonResponse.get('choices');
        if (!choices.isEmpty()) {
            Map<String, Object> firstChoice = (Map<String, Object>) choices[0];
            Map<String, Object> message = (Map<String, Object>) firstChoice.get('message');
            return (String) message.get('content');
        } else {
            throw new CalloutException('No choices returned from OpenAI API.');
        }
    } else {
        throw new CalloutException('Error from OpenAI API: ' + response.getStatus() + ' - ' + response.getBody());
    }
}
}
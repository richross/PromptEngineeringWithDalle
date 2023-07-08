# Prompt Engineering With DALL-E
## Description
This is a fork of the original project created by Jennifer Marsman.  This fork includes files and folder structure to deploy this application into an Azure subscription.
Please note that in the Overview section 'I' refers to Jennifer and not me. :)

## Overview
Learn prompt engineering by iterating over image prompts with the DALL-E model.  

The motivation behind this demo is to help teach the concept of prompt engineering.  I used DALL-E for two reasons:
+	It's a shipped, public model.
+	It's easier to learn prompt engineering with images than with text generation.

I created this based on a conversation I had with someone to help teach him prompt engineering.  I asked him to visualize a picture in his head and then describe it to me.  He said "a baseball stadium".  So I put those words in DALL-E, showed him the resulting image, and asked him how close it was.  The image shown had no players on the field (an empty diamond), and he was picturing baseball players on the field.  The image also showed a view from the field, and he was picturing it from the top row of the stadium looking down.  He continued to refine his description and I continued to put his words into DALL-E until we got something close, and he understood the right level of detail, style and lighting cues, and things to ask for through this iterative process.  So I created this app to mimic our experience.  

Here's a screenshot of the website.  Originally, the image on the right is blank.  An image is displayed on the left, and the user can iteratively guess prompts until they get a similar image.  I call out explicitly that **it will never be exactly the same**.  When you are ready, clicking the "Reveal Prompt" button will show the prompt that created the original image.  A "next" button (not shown below) would take you to another random image in the collection.  

![Screenshot](PracticePromptEngineeringScreenshot.png)


## Setup
You will need an Azure OpenAI resource.  You can create a resource following the instructions at https://learn.microsoft.com/azure/cognitive-services/openai/how-to/create-resource.  

## Local Deployment
Clone this repo.  In the appsettings.json file, replace the values for "AzureOpenAIResourceName" and "AzureOpenAIResourceKey" with your corresponding resource name and key from the Azure OpenAI service.  These values can be found at the [Azure portal](https://portal.azure.com).  The resource name is not the full https://my-aoai.openai.azure.com/ endpoint, but just the value "my-aoai".  

## Azure Deployment
You can deploy this project to an Azure App Service.  This project includes the Azure Developer CLI constructs to make that process easier.  Install the Azure Developer CLI on you machine and provide the following values in the ./azure/PromptEngineeringWithDalle/env file.  
```
    AZURE_COG_SERV_ACCOUT_RG_NAME - name of the resource group where the Azure OpenAI resource is deployed.
    AZURE_COG_SERV_ACCT_NAME - resource name of the Azure OpenAI resource.
    AZURE_LOCATION - name of the location where resources will be deployed.  This should match the region of the Azure OpenAI instance.
    AZURE_ENV_NAME - name of the environment.  Do not change this value.
    AZURE_RESOURCE_GROUP="rg-PromptEngineeringWithDalle-dev"

```
Save the env file and open the command prompt (Ctrl + ` ) and run the following command.
```
    azd auth login
    azd up
```
The bicep scripts in the infra folder of the project will create a resource group, an app service plan, connect to the existing Azure OpenAI resource, populate the appSettings with the appropriate values for Azure OpenAI name and key, create the app service, and deploy the code to the app service.  

Once you are finished using this demo in Azure, run the following command to remove the items.
```
    azd down
```

NOTE: An Azure App Service is a public url by default.  This means anyone can access your app if they know it.  The app uses the Azure OpenAI resource, which is a paid service.  If you are not using the app, you should delete the app service so it is not publicly accessible.
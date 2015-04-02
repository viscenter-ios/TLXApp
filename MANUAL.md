## About the NASA-TLX App ##

The NASA Task Load Index (NASA-TLX) is a well-established rating system for 
assessing mental workload. Though first intended for aerospace system design 
and evaluation at the NASA Ames Research Center, it is currently used to 
assess the workload many types of products and systems impose. These systems 
include anything from instructional technology and consumer products to surgical 
tools and process control systems. The Vis TLX app provides a simple way to 
administer the NASA-TLX and to export the collected data. The User Experience 
Lab at the University of Kentucky’s Vis Center uses this version of the NASA-TLX 
as their standard subjective workload assessment tool.  

## Using the NASA-TLX App ##

In a standard NASA-TLX administration scenario, a Tester is asked to perform a 
task and then is asked to evaluate the difficulty or demand of that task by 
filling in a questionnaire. This app was built to facilitate the latter part of 
this process: the adminstration of the questionnaire and the collection of the 
resulting data.  

The NASA-TLX app provides two methods for loading a questionnaire. The first is 
by creating a questionnaire inside of the app and the second is by loading a 
questionnaire from a URL.  

_Creating a Questionnaire on the App_

To create a questionnaire inside of the NASA-TLX app, select the "Create Question 
File" option from the Main Menu. You will be provided with various options:  

* **Name of questionnaire**: A unique identifier for the questionnaire. The app 
can support multiple questionnaires and this value helps the Administrator keep 
track of them.  

* **Data Range**: The numerical minimum and maximum values for each question. 
The Tester will be presented with a slider for each question in the 
questionnaire. Min will be the value returned by the lowest point on the slider 
and maximum will be the value returned by the highest point on the slider.

    _e.g. With the question "On a scale from 1-10, how difficult was this task?" Min 
would be 0 and Max would be 10._  

* **Question title**: The text presented to the user for the first question.

    _e.g. "How mentally demanding was the task?"_

* **Minimum and Maximum Label**: The labels for each end of the slider.

    _e.g. Minimum: "Very Low" Maximum: "Very High"_

* **Add Question**: Adds another question to the questionnaire. When clicked, 
will add another set of Question Title and Minimum/Maximum label fields.  

After all questions have been added to the Questionnaire, select the Save option 
in the top-right. The Questionnaire will now be available for administration.  

_Uploading a Questionnaire from a URL_

The NASA-TLX app allows for administrators to create custom questionnaires on 
their computers and upload them to the NASA-TLX app. This method is generally 
more useful for long Questionnaires. 

A NASA-TLX Questionnaire file is an ASCII text file that conforms to the 
following format:  

> TITLE \[Name of Questionnaire\]  
>
> QUESTIONS_PER_FRAME \[Total # of questions in questionnaire\]  
> RANGE \[Data Range Minimum\] \[Data Range Maximum\]  
> RANGE_INCREMENT \[# of steps between Range Min and Range Max\]  
>
>
> QUESTION \[Question title #1\]
> RANGE_MIN_LABEL [Minimum Label]  
> RANGE_MAX_LABEL [Maximum Label]  
>
> 
> QUESTION \[Question title #2\]
> RANGE_MIN_LABEL [Minimum Label]  
> RANGE_MAX_LABEL [Maximum Label]  

An example questionnaire file can be viewed [here](https://github.com/viscenter-ios/TLXApp/blob/master/TLXQuestionnaire_Example).  

Once this questionnaire file has been created, it must be hosted online at a 
publicly accessible URL. If you do not have a web host, sites such as [Pastebin](http://pastebin.com)
will allow you to [host text files](http://pastebin.com/zcFfjguA) for temporary transfer to the NASA-TLX app. 
When accessing Questionnaire files using this method, always be sure to copy the URL to the [RAW data](http://pastebin.com/raw.php?i=zcFfjguA) 
as opposed to the normal Pastebin URL.  

After your Questionnaire file has been uploaded to a webhost, select the Download 
Question File option from the Home Screen of the NASA-TLX app. Enter the URL of your 
Questionnaire file and click Download file. The raw text of your Questionnaire file 
will be shown in the view below the URL. If you are satisfied with what is shown, 
select the Save File option. Your Questionnaire will now be available for 
administration.  

## Administering a Questionnaire ##

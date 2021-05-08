*** Settings ***
Documentation           Arquivo Base do Projeto - Tudo começa aqui 


Library                 Browser 
Library                 OperatingSystem

Resource                actions/search.robot


*Keywords*

Start Session
    New Browser                        chromium          false
    New Page                           http://parodifood.qaninja.academy/ 
    #CheckPoint     
    Get Text                           css=span             contains                          Nunca foi tão engraçado pedir comida

##Helpers ##

Get JSON
    [Arguments]             ${file_name}

   ${file}                  Get File                 ${EXECDIR}/resource/fixtures/${file_name}
   ${supoer_var}            Evaluete                 json.loads(${file})           json

   [return]                 ${supoer_var}
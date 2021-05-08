*** Settings ***

Resource            ${EXECDIR}/resources/base.robot
Test Setup          Start Session
Test Teardown       Take Screenshot


*Test Cases*

Deve adicionar um item ao carrinho


    &{restaurant}               Create Dictionary               name=STARBUGS COFFEE        desc=Nada melhor que um café pra te ajudar a resolver um bug.

    Go To Restaurants
    Choose Restaurant           ${restaurant}
    Add To cart                 Starbugs 500 error
    Should Add To Cart          Starbugs 500 error
    Total Cart Should Be        15,60

Deve adicionar três itens ao carrinho 
   [tags]               temp  

   ${cart_json}         Get JSON         cart_json

    Go To Restaurants
    Choose Restaurant           ${cart_json["restaurant"]}

    FOR        ${products}       IN     @{cart_json["products"]} 
        Add To cart                     ${products["name"]}
        Should Add To Cart              ${products["name"]}
    END

    Total Cart Should Be        38,00

    Sleep                       10

   # Add To cart                 Starbugs 500 error
  #  Should Add To Cart          Starbugs 500 error

   # Add To cart                 Cappuccino com Chantilly
   # Should Add To Cart          Cappuccino com Chantilly

  #  Add To cart                 Super Espreso
  #  Should Add To Cart          Super Espreso

    
   
*Keywords*
Choose Restaurant   
    [Arguments]             ${super_var}
   
    Click                   text=${super_var["restaurant"]}

    Wait For Elements State             css=#detail                 visible         10
    Get Text                            css=#detail                 contains        ${super_var["desc"]}

Add To cart
    [Arguments]             ${name}

    Click                   xpath=//span[text()="${name}"]/..//a[@class="add-to-cart"]

Should Add To Cart 
     [Arguments]             ${name}

      Wait For Elements State     css=#cart tr >> text=${name}          visible           5

Total Cart Should Be
    [Arguments]              ${total}

    Get Text                 xpath=//th[contains(text(),"Total")]/..//td                contains             ${total}
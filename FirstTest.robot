*** Settings ***
Library    SeleniumLibrary
Test Setup         Open Browser    ${monURL}    chrome
Test Teardown    Close All Browsers


*** Variables ***
${monURL}    https://www.saucedemo.com/

*** Test Cases ***
Test de connexion OK
    connexion    standard_user    secret_sauce
    Vérifier l'affichage de la page Product

Test de connexion utilisateur bloqué
    connexion    locked_out_user    secret_sauce
    Page Should Contain    Epic sadface: Sorry, this user has been locked out.
    


Test connexion identifiant invalid
    connexion    wafaa    secret_sauce
    Page Should Contain    Epic sadface: Username and password do not match any user in this service

Selectionner un produit
    connexion    standard_user    secret_sauce
    Click Button    id:add-to-cart-sauce-labs-backpack

Selectionner le panier 
    connexion    standard_user    secret_sauce
    Click Button    id:add-to-cart-sauce-labs-backpack
    Click Link    class:shopping_cart_link

Cliquer sur Checkout
     connexion    standard_user    secret_sauce
    Click Button    id:add-to-cart-sauce-labs-backpack
    Click Link    class:shopping_cart_link
    Click Button    id:checkout


*** Keywords ***
connexion
    [Arguments]    ${username}    ${password}
     #Open Browser    ${monURL}    chrome
    Input Text    id:user-name   ${username}
    Input Password   id:password    ${password}
    Click Button    id:login-button
    
Vérifier l'affichage de la page Product
        Page Should Contain Element    xpath://span[contains(text(),'Products')]

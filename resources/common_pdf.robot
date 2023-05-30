*** Settings ***
Library                           QWeb
Library                           QVision
Library                           OperatingSystem
Library                           String


*** Variables ***
${BROWSER}                        chrome
${home_url}                       https://tieto.traficom.fi/en/datatraficom/open-data
# https://www.traficom.fi/en/news/open-data
${open_data_faq}                  Usein kysytyt kysymykset Avoin Data
${pdf_file}                       Avoin Data Usein Kysytyimmät Kysymykset
#Avoin Data 10 kysytyintä kysymystä
${text_in_file}                   Excelissä


*** Keywords ***
Setup Browser
    Set Library Search Order      QWeb    QVision
    Open Browser                  about:blank    ${BROWSER}


End Suite
    Close All Browsers


Home
    GoTo                          ${home_url}
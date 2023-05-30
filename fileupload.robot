*** Settings ***
Library                 QWeb
Suite Setup             Open Browser    about:blank    chrome
Suite Teardown          Close All Browsers

*** Variables ***
${FILE_PATH}          ${CURDIR}/../PDF Sample 123.pdf
${SUITE}              ${EMPTY}

*** Test Cases ***
File Upload
    [Documentation]    Upload a file on Heroku test page.
    GoTo                        https://the-internet.herokuapp.com/upload
    VerifyText                  File Uploader

    UploadFile                  Choose a file    ${FILE_PATH}
    ClickText                   Upload    partial_match=False

    VerifyText                  File Uploaded!
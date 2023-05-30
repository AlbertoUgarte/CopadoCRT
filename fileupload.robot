*** Settings ***
Library                 QWeb
Library                 Collections
Suite Setup             Open Browser    about:blank    chrome
Suite Teardown          Close All Browsers

*** Variables ***
${FILE}                 PDF Sample 123.pdf
${SUITE}                ${EMPTY}

*** Test Cases ***
File Upload
    [Documentation]    Upload a file on Heroku test page.
    GoTo                        https://the-internet.herokuapp.com/upload
    VerifyText                  File Uploader

    IF    "${EXECDIR}" == "/home/executor/execution"
        ${SUITE}=               Evaluate    "${SUITE NAME}".split(".")[0].lower()
        ${FILE_PATH}            Set Variable    /home/executor/execution/${SUITE}/resources/data/${FILE}
    ELSE
        ${FILE_PATH}            Set Variable    /home/services/suite/resources/data/${FILE}
    END

    UploadFile                  Choose a file    ${FILE_PATH}
    ClickText                   Upload    partial_match=False

    VerifyText                  File Uploaded!
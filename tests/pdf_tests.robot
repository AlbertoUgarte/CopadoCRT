*** Settings ***
Resource                    ../resources/common_pdf.robot
Suite Setup                 Setup Browser
Suite Teardown              End Suite

*** Variables ***
${FILE_PATH}          ${CURDIR}/../pdf_download_icon.png
${SUITE}              ${EMPTY}

*** Test Cases ***
Read PDF Text
    [Documentation]         Read values from a pdf file.
    AppState                Home
    VerifyText              Open data for vehicles
    ClickText               Open data for vehicles
    ScrollText              Open data for vehicles contains registration, approval and technical information

    ClickText               ${open_data_faq}    partial_match=true

    # Pdf opens to a new tab and we need to switch focus
    SwitchWindow            NEW

    # Live Testing and normal test runs use different execution and download directories
    # and that needs to be taken into account
     IF    "${EXECDIR}" == "/home/executor/execution"    # normal test run environment
         ${test_suite}=          Evaluate    "${SUITE NAME}".lower().split(".")[0]
    #     ${reference_folder}=    Set Variable    ${EXECDIR}/${test_suite}/resources/images
         ${downloads_folder}=    Set Variable    /home/executor/Downloads
     ELSE    # Live Testing environment
    #     ${reference_folder}=    Set Variable    ${EXECDIR}/../resources/images
         ${downloads_folder}=    Set Variable    /home/services/Downloads
     END

    ${reference_folder}=   Set Variable     ${CURDIR}
    # Use QVision library to access elements on the pdf viewer
    QVision.SetReferenceFolder   ${reference_folder}
    QVision.ClickIcon       pdf_download_icon
    ExpectFileDownload
    QVision.ClickText       Save    anchor=Cancel

    ${file_exists}          Set Variable    False

    # Wait for file download
    FOR    ${i}    IN RANGE    0    20
        ${file_exists}      Run Keyword And Return Status
        ...                 File Should Exist    ${downloads_folder}/${pdf_file}.pdf

        IF                  ${file_exists}       BREAK
        Sleep               0.5s
    END

    List Files In Directory    ${downloads_folder}

    # When dowloading a large file there should be a waiting mechanism
    UsePdf                  ${downloads_folder}/${pdf_file}.pdf


    # Read file contents to a variable and find an address
    ${file_content}         GetPdfText
    ${find_position}        Evaluate    $file_content.find("${text_in_file}")
    ${onsight_address}      Evaluate    $file_content[$find_position:$find_position+77].lstrip("${text_in_file}; ")
    Log                     ${onsight_address}    console=true

    CloseWindow
    SwitchWindow            1
*** Settings ***
Library    OperatingSystem
Library    RequestsLibrary
Library    Collections
Library    RPA.JSON
Library    base64_1.py

*** Variables ***
${base_url}    https://www.googleapis.com/gmail/v1/users/hieuvyp@gmail.com/messages/send

*** Tasks ***
POST - send new google email
    ${test}    Get File    /Users/o_vy.p/Desktop/Gmail_Manual/data.txt
    ${test}    Encode As Base64    ${test}
    Create Session    myssion    ${base_url}    verify=true
    # ${body}=    Convert String to JSON    {"raw":"RnJvbTogPGhpZXV2eXBAZ21haWwuY29tPgpUbzogPGhpZXV2eXAzM0BnbWFpbC5jb20+ClN1YmplY3Q6IFRlc3QgRW1haWwgMgoKVGVzdC4gVGhpcyBpcyB0aGUgYm9keQ=="}
    ${body}=    Convert String to JSON    {"raw":"${test}"}
    Log To Console    ${test}
    Log To Console    ${body}

    &{headers}     Create Dictionary    Content-Type=application/json    Authorization=Bearer ya29.a0AWY7CkkFAw1seLYGJ9Nio4Dw2zV_PQu1swY6Y8-39vXayhSJKM_VkekGdeO5ApMaAgMOB9k_FJqgr6ZivAOr5JLXsi4_zs6DXIIhCW8mSpA3rdEu1IJen67kErDTmKwfy0b6BaxuKTO6ent3OxWmdKVAVCIksAaCgYKAdASARASFQG1tDrp6ONAj87Wok8h6DMz2zD_kw0165

    ${response}=        POST    url=${base_url}      json=${body}      headers=${headers}

    Log To Console    ${response.status_code}
    Log To Console    ${response.content}

    ${status_code}=    Convert To String    ${response.status_code}
    Should Be Equal    ${status_code}    200
    
    ${body}=    Convert To String    ${response.content}
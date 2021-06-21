# Prerequisite
# >> pip install robotframework-requests

***Settings***
Library    RequestsLibrary
Library    Collections

***Variables***
${url}         http://localhost:8080
${box1Info}    {'id': 1, 'code': 111, 'max': 3, 'current': 0}
${box2Info}    {'id': 2, 'code': 222, 'max': 2, 'current': 0}

***Test Cases***
Test List of Driver Job
    Job List GET Request And Verify Status Success

Test List of Boxs In Job
    Box List GET Request
    Pre-Verify Box List

Test Scan Box
    Post Request For Scan Box And Verify Status Success

Test Complete Job
    Post Request For Complete Box And Verify Status Success

*** Keywords ***
Request Create Session
    [Arguments]            ${method}         ${attribute}
    Create Session         ${attribute}      ${url}
    ${respGET}=            Run Keyword If    '${method}' == 'GET'     GET On Session     ${attribute}    /${attribute}               expected_status=200
    Set Global Variable    ${respGET}

Job List GET Request And Verify Status Success
    Request Create Session    GET    jobs

Box List GET Request
    Request Create Session    GET    boxs    

Pre-Verify Box List
    ${boxes}           Set Variable         ${respGET.json()[0]}[boxes]
    ${box1} =          Get From List        ${boxes}                       0
    ${box2} =          Get From List        ${boxes}                       1
    ${box1_str}        Convert To String    ${box1}
    ${box2_str}        Convert To String    ${box2}
    Should Be Equal    ${box1_str}          ${box1Info}
    Should Be Equal    ${box2_str}          ${box2Info}

Post Request For Scan Box And Verify Status Success    
    Create Session      scan                 ${url}
    &{data}=            Create dictionary    code=222
    ${resp}=            POST On Session      scan        /scan    json=${data}    
    Status Should Be    201                  ${resp}

Post Request For Complete Box And Verify Status Success
    Create Session      done                 ${url} 
    &{data}=            Create dictionary    id=2
    ${resp}=            POST On Session      done       /done    json=${data}   
    Status Should Be    201                  ${resp}
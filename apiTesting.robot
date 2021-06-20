***Settings***
Library    RequestsLibrary
Library    Collections

***Variables***
${url}        http://localhost:8080
${boxes1}     {'id': 1, 'code': 111, 'max': 3, 'current': 0}
${boxes2}     {'id': 2, 'code': 222, 'max': 2, 'current': 0}

***Test Cases***
Test List of Driver Job
    Get Request Job List And Verify Status Success

Test List of Boxs In Job
    Get Request Box List 
    Verify Box List

Test Scan Box
    Post Request For Scan Box And Verify Status Success

Test Complete Job
    Post Request For Complete Box And Verify Status Success

*** Keywords ***
Get Request Job List And Verify Status Success
    Create Session      jobs    ${url} 
    ${resp_jobs}=      GET On Session    jobs    /jobs    expected_status=200

Get Request Box List
    Create Session      boxs    ${url} 
    ${resp_boxs}=      GET On Session    boxs    /boxs    expected_status=200
    Set Test Variable    ${resp_boxs}

Verify Box List
    ${boxes}    Set Variable    ${resp_boxs.json()[0]}[boxes]
    ${boxes_id1} =      Get From List   ${boxes}    0
    ${boxes_id2} =      Get From List   ${boxes}    1
    ${box1_string}     Convert To String    ${boxes_id1}
    ${box2_string}     Convert To String    ${boxes_id2}
    Should Be Equal     ${box1_string}    ${boxes1}
    Should Be Equal     ${box2_string}    ${boxes2}

Post Request For Scan Box And Verify Status Success
    Create Session      scan    ${url} 
    &{data}=    Create dictionary  code=111
    ${resp}=    POST On Session    scan  /scan  json=${data}  expected_status=anything
    Status Should Be                 201  ${resp}

Post Request For Complete Box And Verify Status Success
    Create Session      done    ${url} 
    &{data}=    Create dictionary  id=1
    ${resp}=    POST On Session    done  /done  json=${data}  expected_status=anything
    Status Should Be                 201  ${resp}
import re

def convertWord():
    output = []
    count = 0
    inputWord = input("Input: word = ")
    rmvChar = re.sub("[^0-9]", " ", inputWord)
    splitStr = rmvChar.split()
    myList = list(set(splitStr))

    for i in range(0, len(myList)):
        myList[i] = int(myList[i])

    for i in myList:
        if i not in output:
            count += 1
            output.append(i)
    print("Output:", count)

convertWord()
# "a123bc34d8ef34"  "leet1234code234"  "a1b01c001"
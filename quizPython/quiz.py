import mysql.connector
import requests
import json
import html
import urllib
import urllib.parse as urlparse
from urllib.parse import urlencode

url1="https://opentdb.com/api.php?"



mydb=mysql.connector.connect(host="159.89.161.122",user="ganesh",passwd="hotMAIL123@")
#mydb=mysql.connector.connect(host="databases.000webhost.com",user="id5776939_ganesht049",passwd="hotMAIL123@")
def getDataFromUrl(category, difficulty , amount , typeQuestions):
    dataUrl=url1+"amount="+amount+"&category="+category+"&difficulty="+difficulty+"&type="+typeQuestions
    print(dataUrl)
    data=requests.get(dataUrl).json()
    return data

def createOtherTables():
    mycursor=mydb.cursor()
    mycursor.execute("use trivia_db;")
    mycursor.execute("create table score(username varchar(20), score int);")
    mycursor.execute("create table suggestsingle(question varchar(300), answer varchar(10),subject varchar(10));")
    mycursor.execute("create table suggestmultiple(question varchar(300), option1 varchar(100), option2 varchar(100) , option3 varchar(100) , answer varchar(10) , subject varchar(10));")
    mycursor.execute("create table users(id int auto_increment , username varchar(20), email varchar(50) , password varchar(50), PRIMARY KEY (id));")


def getDataFromUrlND(category, amount , typeQuestions):
    dataUrl=url1+"amount="+amount+"&category="+category+"&type="+typeQuestions
    print(dataUrl)
    data=requests.get(dataUrl).json()
    return data

def parseJsonToList(data,typeData):
    listReturn=[]
    results=data["results"]
    if typeData=="multiple":
        for a in results:
            question=a["question"]
            answer=a["correct_answer"]
            options=a["incorrect_answers"]
            option1=options[0]
            option2=options[1]
            option3=options[2]
            item={"question":question,"answer":answer,"option1":option1,"option2":option2,"option3":option3}
            listReturn.append(item)
    else:
        for a in results:
            question=a["question"]
            answer=a["correct_answer"]
            item={"question":question,"answer":answer}
            listReturn.append(item)
    return listReturn


def returnListNames(mycursor):
    a = list(mycursor)
    listReturn=[]
    for x in a:
        itemlist=list(x)
        item=itemlist[0]
        listReturn.append(item)
    return listReturn


def checkExistence(name,typeData):
    mycursor=mydb.cursor()
    mycursor.execute("show "+typeData)
    items=returnListNames(mycursor)
    if name in items:
        return True

def _storeInTable(table_name,data,typeData):
    mycursor=mydb.cursor()

    if typeData=="multiple":
        mycursor.execute("create table "+table_name+"(question varchar(200), option1 varchar(100), option2 varchar(100),option3 varchar(100),answer varchar(100))")
        listQuestions=parseJsonToList(data,typeData)
        for a in listQuestions:
            question=html.unescape(a["question"])
            option1=html.unescape( a["option1"])
            option2=html.unescape( a["option2"])
            option3=html.unescape( a["option3"])
            answer=html.unescape(a["answer"])
            val=[question,option1,option2,option3,answer]
            query="insert into "+table_name+" (question,option1,option2,option3,answer) values (%s,%s,%s,%s,%s);"
            mycursor.execute(query,val)
        mydb.commit()
    else:
        mycursor.execute("create table "+table_name+"(question varchar(200) , answer varchar(100))")
        listQuestions=parseJsonToList(data,typeData)
        for a in listQuestions:
            question=html.unescape(a["question"])
            answer=html.unescape(a["answer"])
            val=[question,answer]
            query="insert into "+table_name+" (question,answer) values (%s,%s);"
            mycursor.execute(query,val)
        mydb.commit()
    print("records inserted")

def saveDataToDatabase(data,database_name,table_name,typeData):
    mycursor=mydb.cursor()
    
    #Check if database exists if exists then use else create 
    if checkExistence(database_name,"databases"):
        #database exists using the same
        mycursor.execute("use "+database_name)
        if checkExistence(table_name,"tables"):
            #table exists dropping table
            mycursor.execute("drop table "+table_name)
            #new table creating and saving data
            _storeInTable(table_name,data,typeData)
        else:
            #new table creating and saving data
            _storeInTable(table_name,data,typeData)        
    else:
        #database creating 
        mycursor.execute("create database "+database_name)
        #new table creating and saving data
        _storeInTable(table_name,data,typeData)




dbname="trivia_db"

def saveMultiple():
    typeData="multiple"
    saveDataToDatabase(getDataFromUrl("17","easy","43",typeData),dbname,"science_easy_"+typeData,typeData)
    saveDataToDatabase(getDataFromUrl("22","easy","50",typeData),dbname,"geography_easy_"+typeData,typeData)
    saveDataToDatabase(getDataFromUrl("23","easy","35",typeData),dbname,"history_easy_"+typeData,typeData)
    saveDataToDatabase(getDataFromUrl("20","easy","12",typeData),dbname,"mythology_easy_"+typeData,typeData)
    saveDataToDatabase(getDataFromUrl("11","easy","50",typeData),dbname,"films_easy_"+typeData,typeData)
    saveDataToDatabase(getDataFromUrl("21","easy","13",typeData),dbname,"sports_easy_"+typeData,typeData)
    saveDataToDatabase(getDataFromUrl("18","easy","29",typeData),dbname,"computers_easy_"+typeData,typeData)


    saveDataToDatabase(getDataFromUrl("17","medium","50",typeData),dbname,"science_medium_"+typeData,typeData)
    saveDataToDatabase(getDataFromUrl("22","medium","50",typeData),dbname,"geography_medium_"+typeData,typeData)
    saveDataToDatabase(getDataFromUrl("23","medium","50",typeData),dbname,"history_medium_"+typeData,typeData)
    saveDataToDatabase(getDataFromUrl("20","medium","15",typeData),dbname,"mythology_medium_"+typeData,typeData)
    saveDataToDatabase(getDataFromUrl("11","medium","50",typeData),dbname,"films_medium_"+typeData,typeData)
    saveDataToDatabase(getDataFromUrl("21","medium","32",typeData),dbname,"sports_medium_"+typeData,typeData)
    saveDataToDatabase(getDataFromUrl("18","medium","48",typeData),dbname,"computers_medium_"+typeData,typeData)

    saveDataToDatabase(getDataFromUrl("17","hard","41",typeData),dbname,"science_hard_"+typeData,typeData)
    saveDataToDatabase(getDataFromUrl("22","hard","42",typeData),dbname,"geography_hard_"+typeData,typeData)
    saveDataToDatabase(getDataFromUrl("23","hard","46",typeData),dbname,"history_hard_"+typeData,typeData)
    saveDataToDatabase(getDataFromUrl("20","hard","7",typeData),dbname,"mythology_hard_"+typeData,typeData)
    saveDataToDatabase(getDataFromUrl("11","hard","28",typeData),dbname,"films_hard_"+typeData,typeData)
    saveDataToDatabase(getDataFromUrl("21","hard","9",typeData),dbname,"sports_hard_"+typeData,typeData)
    saveDataToDatabase(getDataFromUrl("18","hard","22",typeData),dbname,"computers_hard_"+typeData,typeData)

def saveBoolean():
    typeData="boolean"
    saveDataToDatabase(getDataFromUrlND("17","31",typeData),dbname,"science_"+typeData,typeData)
    saveDataToDatabase(getDataFromUrlND("22","37",typeData),dbname,"geography_"+typeData,typeData)
    saveDataToDatabase(getDataFromUrlND("23","37",typeData),dbname,"history_"+typeData,typeData)
    #saveDataToDatabase(getDataFromUrlND("20","12",typeData),dbname,"mythology_"+typeData,typeData)
    saveDataToDatabase(getDataFromUrlND("11","26",typeData),dbname,"films_"+typeData,typeData)
    saveDataToDatabase(getDataFromUrlND("21","11",typeData),dbname,"sports_"+typeData,typeData)
    saveDataToDatabase(getDataFromUrlND("18","32",typeData),dbname,"computers_"+typeData,typeData)

#saveBoolean()
#saveMultiple()
#typeData="boolean"
#saveDataToDatabase(getDataFromUrlND("20","9",typeData),dbname,"mythology_"+typeData,typeData)
createOtherTables()
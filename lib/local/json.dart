const localPMList = ''' [
    {
        "promiseId" : "101",
        "creatorId" : "Vicky",
        "promiseFromId" : "Mason",
        "promiseToId" : "Vicky",
        "title" : "Wash dishes tonight!!!",
        "bonus" : 10.0,
        "loveRate" : 1,
        "status" : "Expired",
        "expireTime":"20180308T120000.000Z"
    },
    {
        "promiseId" : "102",
        "creatorId" : "Mason",
        "promiseFromId" : "Mason",
        "promiseToId" : "Vicky",
        "title" : "Mown the lawn!",
        "bonus" : 20.0,
        "loveRate" : 2,
        "status" : "Fulfilling",
        "expireTime":"20180315T120000.000Z"
    },
    {
        "promiseId" : "103",
        "creatorId" : "Vicky",
        "promiseFromId" : "Vicky",
        "promiseToId" : "Mason",
        "title" : "Give Mason a 10 min back massage",
        "bonus" : 10.0,
        "loveRate" : 1,
        "status" : "Negociation",
        "expireTime":"20180508T120000.000Z"
    }
]  ''';

const txDoneList = ''' [
    {
         "promiseId" : "101",
         "currentId": "Vicky",
         "status":"New",
         "message":"It is your turn to wash dishes tonight!",
         "timestamp":"20180228T163000.000Z"        
    },
    {
         "promiseId" : "101",
         "currentId" :"Mason",
         "status":"Negociating",
         "message":"Can I do it tomorrow? very tired from work...",
         "timestamp":"20180228T165100.000Z"        
    },
    {
         "promiseId" : "101",
         "currentId" :"Vicky",
         "status":"Negociating",
         "message":"No more execuses please",
         "timestamp":"20180228T165100.000Z"        
    },
     {
         "promiseId" : "101",
         "currentId" :"Vicky",
         "status":"Fufilling",
         "message":"OK then , I will do it!",
         "timestamp":"20180228T165100.000Z"        
    }
] ''';
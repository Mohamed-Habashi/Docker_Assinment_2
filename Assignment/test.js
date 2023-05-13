const express = require('express');
const cors = require('cors');
const port = 5000;
var array=[];
var fs = require('fs');
var path ="textdata/file.txt";
read();
const app = express();

app.use(cors({
    origin: '*',
    methods: ['GET','POST','DELETE','UPDATE','PUT','PATCH']
}));
app.use(express.json());

app.listen(port, () => {
    console.log("API server started on port 4444");
});



app.get('/persons', async (req, res) => {
    try {
        res.send(array);
    }
    catch (error) {
        res.status(500).send(error.toString('ascii'));
    }
});


app.get('/persons/:id', async (req, res) => {
    try {
        var index=array.findIndex((Obj=>Obj.id==req.params.id));
        if(index==-1){
            throw 'person not found';
        }
        res.send(array[index]);
    }
    catch (error) {
        res.status(500).send(error.toString('ascii'));
    }
});


function write(){
    fs.writeFile(path, arrayToString(array), (err) => {
    if (err) throw err;
    else{
        console.log("The file is updated with the given data")
        }
    })
}

app.post('/persons', async (req, res) => {
    try {
        const {id,name,email,gender,age} = req.body;
        if(id==null || name==null || gender==null || age==null || email==null) throw 'you must provide all attributes (id, name, email, gender,age)'
        const newPerson ={
            id: id,
            name: name,
            email: email,
            gender: gender,
            age:age
        }
        index=array.findIndex((obj=> obj.id ==newPerson.id))
        if(index!=-1) throw 'There is a person with same id'
        array.push(newPerson)
        write()
        res.send("New Person added Successfuly");
    }
    catch (error) {
        res.status(500).send(error.toString('ascii'));
    }
});

app.put('/persons/:id', async (req, res) => {
    try {
        const id2 = req.body["id"];
        const name2 = req.body["name"];
        const email2 = req.body["email"];
        const gender2 = req.body["gender"];
        const age2 = req.body["age"];
        index=array.findIndex((obj=>obj.id==req.params.id));
        index2=array.findIndex((obj=>obj.id==id2));
        if(index==-1) throw 'id not found'
        if(index2 !=-1 && index!=index2) throw 'new id already exists'
        if(id2) array[index].id=id2;
        if(name2) array[index].name=name2;
        if(email2) array[index].email=email2;
        if(gender2) array[index].gender=gender2;
        if(age2) array[index].age=age2;
        write()
        console.log("Updated Successfuly")
        res.send('Update complete')
    }
    catch (error) {
        res.send(error.toString('ascii'));
    }
});


app.delete('/persons/:id', async (req, res) => {   
    try {
        index=array.findIndex((obj=>obj.id==req.params.id))
        if(index==-1)throw 'id not found'
        let unDeletedPeople = array.filter( function(val) { 
            if(val.id != req.params.id) {
                return val;
            }
        })
        array=unDeletedPeople
        write()
        res.send('Deleted Successfuly');
    }
    catch (error) {
        res.send(error.toString('ascii'));
    }
});

function read(){
    const ReadLines = require('n-readlines');
    const readLines = new ReadLines(path);
    let line;
    while ((line = readLines.next())) {
        var person={
            id :line.toString('ascii'),
            name :line=readLines.next().toString('ascii'),
            email :line=readLines.next().toString('ascii'),
            gender : line=readLines.next().toString('ascii'),
            age :line=readLines.next().toString('ascii')
        };
        array.push(person)
    }
}
function arrayToString(array) {
    var str='';
    for(var i=0;i<array.length;i++){
        str+=toString(array[i]);
    }
    return str;
}

function toString(data){
    return data.id + '\n' + data.name + '\n' + data.email + '\n' + data.gender + '\n' + data.age + '\n';
}




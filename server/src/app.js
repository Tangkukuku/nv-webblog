let express = require('express')
let bodyParser = require('body-parser')
const app = express()

app.use(bodyParser.json())
app.use(bodyParser.urlencoded({extended: true}))

app.get('/status', function (req, res ){
    res.send('Hello nodejs server')
})

app.get('/hello/:person', function (req, res ){
    console.log('hello - ' + req.params.person)
    res.send('sey hello with ' + req.params.person)
})

app.get('/user/:userId', function (req, res){
    res.send('ดูข้อมูลผู้ใช้งาน: ' + req.params.userId)
})

app.get('/users', function (req, res ){
    res.send('เรียกข้อมูลผู้ใช้งานทั้งหมด')
})

app.post('/user/', function (req, res ){
    res.send('ทำการสร้างผู้ใช้งาน:' + JSON.stringify(req.body))
})

app.put('/user/:userId', function (req, res ){
    res.send('ทาํการแกไ้ขผใุ้ชง้าน: ' + req.params.userId + ' : ' + JSON.stringify(req.body))
})

app.delete('/user/:userId', function (req, res) {
    res.send('ทําการลบผุ้ใช้งาน: ' + req.params.userId + ' : ' + JSON.stringify(req.body))
})

let port = 8081

app.listen(port,function() {
    console.log('server running on ' + port)
})
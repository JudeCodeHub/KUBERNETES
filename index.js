import expres from 'express';

const app = expres();

const PORT = process.env.PORT || 3000;

app.get('/', (req, res) => {   
    res.json({
        message: 'Hello From a Container....welcome to Kubernetes with Node.js',
        service: "hello-node",
        pod: process.env.POD_NAME || 'unknown',
        time: new Date().toISOString()
    })
 })

 app.get('/readyz', (req, res) => {res.status(200).send('ready')})
 app.get('/healthz', (req, res) => {res.status(200).send('ok')})

 app.listen(PORT, () => {
    console.log(`App is running on port ${PORT}`);
 })
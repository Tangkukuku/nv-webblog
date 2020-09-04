module.exports = {   
    port: 8081,     
    db: {
        database: process.env.DB_NAME || 'nvwebblog',
        user: process.env.DB_User || 'root',
        password: process.env.DB_PASS || 'root1234',
        options: {
        dialect: process.env.DIALECT || 'mysql',
        // storage: './nvwebblog-db.sqlite'
        host: process.env.HOST || 'localhost',
        },
        },  
    authentication: {
        jwtSecret: 'test'
    }
}
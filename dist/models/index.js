import { Sequelize } from 'sequelize';
import { initUserModel } from './User.js';
import { initSpaceModel } from './Space.js';
import config from '../config/environment.js';
const sequelize = new Sequelize({
    dialect: 'mysql',
    host: config.database.host,
    username: config.database.user,
    password: config.database.password,
    database: config.database.name,
    logging: process.env.NODE_ENV === 'development' ? console.log : false,
    pool: {
        max: 5,
        min: 0,
        acquire: 30000,
        idle: 10000
    },
    dialectOptions: {
        multipleStatements: true
    }
});
// Initialize models
export const User = initUserModel(sequelize);
export const Space = initSpaceModel(sequelize);
// Set up associations
User.associate({ Space });
Space.associate({ User });
// Sync database
export const syncDatabase = async () => {
    try {
        await sequelize.sync({ alter: true });
        console.log('Database synced successfully');
    }
    catch (error) {
        console.error('Error syncing database:', error);
        throw error;
    }
};
export { sequelize };
//# sourceMappingURL=index.js.map
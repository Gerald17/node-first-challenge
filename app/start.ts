import express from 'express';
import "reflect-metadata";
import helmet from 'helmet';
import dotenv from 'dotenv';

import getRouter from './routes';

const port = 3000;
function startServer() {
  try {
    dotenv.config();
    const router = getRouter();
    const app = express();
    app.use(helmet());
    app.use(express.json());
    app.use('/api', router);
    app.listen(port, () => {
      console.log(`REST API on http://localhost:${port}/api`);
    });
  } catch (e) {
    console.error(e);
  }
}

export default startServer;

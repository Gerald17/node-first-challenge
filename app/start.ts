import express from 'express';
import getRouter from './routes';

const port = 3000;
function startServer() {
  try {
    const app = express();

    app.use(express.json());

    const router = getRouter();
    app.use('/api', router);
    app.listen(port, () => {
      console.log(`REST API on http://localhost:${port}/api`);
    });
  } catch (e) {
    console.error(e);
  }
}

export default startServer;

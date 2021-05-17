import express from 'express';
import getAuthRouter from './authRoutes/auth-router';

function getRouter() {
  const router = express.Router();
  router.use('/auth', getAuthRouter());
  return router;
}

export default getRouter;

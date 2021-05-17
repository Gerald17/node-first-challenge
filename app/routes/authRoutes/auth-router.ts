import {Router} from 'express';
import * as authController from '../../controllers/authController/auth.controller';

function getAuthRoutes() {
  const router = Router();
  router.get('/login', authController.login);
  return router;
}

export default getAuthRoutes;

import {Router} from 'express';
import * as authController from '../../controllers/authController/auth.controller';

function getAuthRoutes() {
  const router = Router();
  router.get('/users', authController.getUsers);
  return router;
}

export default getAuthRoutes;

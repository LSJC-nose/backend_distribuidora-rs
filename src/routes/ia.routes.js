import { Router } from 'express';
import { consultarConIA } from '../controllers/ia.controller.js';


const router = Router();

router.post('/consultarconias', consultarConIA);

export default router;